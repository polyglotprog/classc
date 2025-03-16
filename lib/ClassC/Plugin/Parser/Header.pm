package ClassC::Plugin::Parser::Header;

use v5.38;

use ClassC::Core::Console::AnsiStyles qw(
    $BOLD
    $RESET
    dim
    reset
);
use ClassC::Core::Logging::Logger;
use ClassC::Core::Util             qw( inspect );
use ClassC::Plugin::Parser::Tokens qw(
    $BLANK_LINE_TOKENS
    $CLASS_TOKENS
    $FIELD_TOKENS
    $INCLUDE_TOKENS
    $METHOD_TOKENS
);
use ClassC::Plugin::Parser::Util qw(
    bad_chars
    format_parsing_error
    parse
    starts_with
    store_until
    tokens
);
use File::Basename;
use File::Spec;
require ClassC::Core::OOP::Class;
require ClassC::Core::OOP::Dependency;
require ClassC::Core::OOP::Field;
require ClassC::Core::OOP::Method;

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

sub parse_header {
  my $file    = shift;
  my %options = (@_);
  $logger->debug("Parsing header: $file");

  my $relative_to = $options{relative_to};
  my $header_file = File::Spec->abs2rel($file, $relative_to);
  my $source_file = $header_file         =~ s/\.h$/.c/gr;
  my $full_name   = $header_file         =~ s/\.h$//gr;
  my $name        = basename($full_name) =~ s/\.h$//gr;

  my $lines = [];
  my $class = {
    id           => ClassC::Core::OOP::Class::CLASS(),
    header_file  => $header_file,
    source_file  => $source_file,
    full_name    => $full_name,
    name         => undef,
    lines        => $lines,
    dependencies => [],
    fields       => undef,
    methods      => undef,
  };

  my $input;
  eval {
    open($input, $file) or die "Could not open file $file: $!";
    local *STDIN = $input;
    __parse_class($class, $lines);
  };

  if ($@) {
    my $error = $@;
    __handle_error($class, $input, $error);
  }

  if ($logger->is_trace_enabled()) {
    $logger->trace("Class: ", inspect($class));
  }

  close $input if $input;

  return ClassC::Core::OOP::Class->new(%$class);
}

sub __parse_class {
  $logger->trace('> Parsing class');
  my ($class, $lines) = @_;
  __parse_until_class_declaration($class, $lines);
  __parse_members($class, $lines);
  __parse_until_eof($lines);
}

sub __parse_until_class_declaration {
  my ($class, $lines) = @_;
  my $class_name;
  my @dependencies = ();

  while (my $line = <STDIN>) {
    chomp $line;
    push @$lines, $line;
    my $trimmed = ($line =~ s/^\s+|\s+$//gr);    # trim whitespace
    my $char    = substr($trimmed, 0, 1);
    my $chars   = substr($trimmed, 0, 2);

    if ($char eq '#') {
      my $include = __parse_include($line);
      push @dependencies, $include;
    } elsif ($char eq 'c') {
      my (@parents, $parent_list, $brace);
      ($class_name, $parent_list, $brace) = __parse_class_declaration($line);
      $logger->warningf("parent_list: %s", $parent_list);
      $logger->warningf("brace:       %s", $brace);
      if ($parent_list eq '{') {
        @parents = ();
        $brace = '{';
      } else {
        $parent_list =~ s/\s*:\s*//;
        @parents = map { $_ =~ s/^\s+|\s+$//gr } split /,\s*/, $parent_list;
      }
      $class->{parents} = \@parents;
      store_until('{', *STDIN, $lines, $line) if not defined $brace;
      last;
    } elsif ($char ne '') {
      parse($line, $BLANK_LINE_TOKENS);
    }
  }

  $class->{name}         = $class_name;
  $class->{dependencies} = \@dependencies;
}

sub __parse_include {
  $logger->trace('>> Parsing include');
  my ($line)       = @_;
  my ($dependency) = parse($line, $INCLUDE_TOKENS);
  if ($dependency =~ m/\<(.*)\>/) {
    return ClassC::Core::OOP::Dependency->new(
      id         => ClassC::Core::OOP::Dependency::SYSTEM(),
      dependency => $1,
    );
  } elsif ($dependency =~ m/"(.*)"/) {
    return ClassC::Core::OOP::Dependency->new(
      id         => ClassC::Core::OOP::Dependency::USER(),
      dependency => $1,
    );
  }
}

sub __parse_class_declaration {
  $logger->trace('>> Parsing class declaration');

  my ($line) = @_;
  return parse($line, $CLASS_TOKENS);
}

sub __parse_members {
  $logger->trace('>> Parsing members');
  my ($class, $lines) = @_;
  my $class_name    = $class->{name};
  my @fields        = ();
  my @methods       = ();

  while (my $line = <STDIN>) {
    chomp $line;
    my $trimmed = ($line =~ s/^\s+|\s+$//gr);    # trim whitespace
    my $chars   = substr($trimmed, 0, 2);

    if ($chars eq '/*') {
      $line = dim($line);
      store_until('*/', *STDIN, $lines, $line);
      push @$lines, reset(pop @$lines);          # not efficient, but terse
      next;
    } elsif ($chars eq '//') {
      push @$lines, dim(reset($line));
      next;
    }

    push @$lines, $line;

    if (substr($trimmed, -1, 1) eq ';') {
      my $left_paren_index  = index($line, '(');
      my $right_paren_index = rindex($line, ')');

      if ($left_paren_index != -1 and $right_paren_index != -1) {
        my $method = __parse_method($line);
        $method->{source} = $class_name;
        push @methods, $method;
      } elsif ($left_paren_index == -1 and $right_paren_index == -1) {
        my $field = __parse_field($line);
        $field->{source} = $class_name;
        push @fields, $field;
      } elsif ($left_paren_index == -1 and $right_paren_index != -1) {
        die {
          index  => $right_paren_index,
          detail => 'missing matching (',
        };
      } elsif ($left_paren_index != -1 and $right_paren_index == -1) {
        die {
          index  => $left_paren_index,
          detail => 'missing matching )',
        };
      }
    } elsif ($trimmed eq '}') {
      $class->{fields}  = \@fields;
      $class->{methods} = \@methods;
      return;
    } else {
      parse($line, $BLANK_LINE_TOKENS);
    }
  }
  die {
    # line_number => STDIN->input_line_number() + 1,
    index  => -1,
    detail => 'reached EOF without closing }',
  };
}

sub __parse_field {
  $logger->trace('>>> Parsing field');
  my ($line) = @_;
  my ($type, $name) = parse($line, $FIELD_TOKENS);
  if (starts_with($name, '*')) {
    $type = "$type *";
    $name = substr($name, 1);
  }
  return ClassC::Core::OOP::Field->new(
    id   => ClassC::Core::OOP::Field::FIELD(),
    type => $type,
    name => $name
  );
}

sub __parse_method {
  $logger->trace('>>> Parsing method');
  my ($line) = @_;
  my ($return_type, $name, $arguments, $override) = parse($line, $METHOD_TOKENS);
  if (starts_with($name, '*')) {
    $return_type = "$return_type *";
    $name        = substr($name, 1);
  }
  return ClassC::Core::OOP::Method->new(
    id          => ClassC::Core::OOP::Method::METHOD(),
    override    => length($override) > 0 ? 1 : 0,
    return_type => $return_type,
    name        => $name,
    arguments   => $arguments,
  );
}

sub __parse_until_eof {
  my ($lines) = @_;
  while (my $line = <STDIN>) {
    chomp $line;
    parse($line, $BLANK_LINE_TOKENS);
    push @$lines, $line;
  }
}

sub __handle_error {
  my ($class, $input, $error) = @_;
  if (ref($error) eq 'HASH') {
    my $line_number
        = $input
        ? $input->input_line_number()
        : 0;
    my $index  = $error->{index} // -1;
    my $detail = $error->{detail}
        // 'invalid: ' . bad_chars($error->{string}, $index);
    $logger->error(format_parsing_error({
      file        => $class->{header_file},
      lines       => $class->{lines},
      line_number => $line_number,
      index       => $index,
      detail      => $detail,
    }));
  } else {
    $logger->error($error);
  }
  exit;
}

1;

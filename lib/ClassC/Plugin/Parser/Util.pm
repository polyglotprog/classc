package ClassC::Plugin::Parser::Util;

use v5.38;
use ClassC::Core::Console::AnsiStyles qw(
    $BOLD
    $BRIGHT_RED
    $DIM
    $RESET
    dim
);
require Exporter;

our @ISA    = qw(Exporter);
our @EXPORT = qw(
    bad_chars
    format_parsing_error
    parse
    skip_until
    store_until
    tokens
);

sub bad_chars {
  my ($line, $index) = @_;
  substr($line, $index) =~ m/(\S+)/g;
  return $1;
}

sub format_parsing_error {
  my ($error) = @_;
  if (ref($error) eq 'HASH') {
    my $file         = $error->{file};
    my $lines        = $error->{lines};
    my $line_number  = $error->{line_number};
    my $index        = $error->{index};
    my $column       = $index + 1;
    my $detail       = $error->{detail};
    my $last_n_lines = __last_n_lines(5, $lines);
    my $marker       = __error_marker($index, $detail);
    return <<~"PARSING_ERROR";
        Parsing error at line $line_number, column $column of $BOLD$file$RESET:

        $last_n_lines
        $marker
        PARSING_ERROR
  } else {

    # TODO: Remove
    return $error;
  }
}

sub parse {
  my ($string, $tokens) = @_;
  my $index  = 0;
  my @groups = ();
  for my $token (@$tokens) {
    my $regex = qr/$token/;
    if ($string =~ m/$regex/g) {
      $index = pos($string);
      push @groups, @{^CAPTURE} if @{^CAPTURE};
    } else {
      die {
        string => $string,
        index  => $index
      };
    }
  }
  return @groups;
}

# Reads lines from $input until $string is found.
sub skip_until {
  my ($string, $input, $line) = @_;
  pop @{ store_until($string, $input, [], $line) };
}

# Read lines from $input, storing them in array @$lines, until $string is
# found.
sub store_until {
  my ($string, $input, $lines, $line) = @_;
  $lines = $lines || [];

  return $lines if (index($line, $string) != -1);

  while ($line = <$input>) {
    chomp $line;
    push @$lines, $line;
    return $lines if (index($line, $string) != -1);
  }

  die {
    line   => $.,
    index  => 0,
    detail => "Reached EOF without $string",
    lines  => $lines,
  };
}

sub __error_marker {
  my ($index, $message) = @_;
  if ($index < 0) {
    return "${BRIGHT_RED}\\ $message${RESET}";
  }
  my $spaces = ' ' x $index;
  return "${BRIGHT_RED}${spaces}^ $message${RESET}";
}

# Create a string from the last n lines
sub __last_n_lines {
  my ($n, $lines) = @_;
  my $line_count = scalar @$lines;
  $n = $line_count < $n ? $line_count : $n;
  return join "\n", splice(@$lines, -$n, $n);
}

sub tokens {
  my @tokens = map {"\\G$_"} @_;
  return \@tokens;
}

1;

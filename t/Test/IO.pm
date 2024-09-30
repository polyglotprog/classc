package Test::IO;

use v5.38;

use Test::Builder;

require Exporter;
our @ISA    = 'Exporter';
our @EXPORT = qw(
    capture_output
    capture_stderr
    capture_stdout
    get_file_contents
    get_file_lines
    output_is
    stderr_is
    stdout_is
);

sub get_file_contents {
  my ($file) = @_;
  open(my $input, $file) or die "Could not open file $file: $!";
  return do { local $/; <$input> };
}

sub get_file_lines {
  my ($file) = @_;
  return split /\r?\n/, get_file_contents($file);
}

sub output_is {
  my ($block, $expected, $name) = @_;
  my $got = capture_output($block);
  $name //= '';

  my $test = Test::Builder->new;
  $test->is_eq($got, $expected, $name);
}

sub stdout_is {
  my ($block, $expected, $name) = @_;
  my $got = capture_stdout($block);
  $name //= '';

  my $test = Test::Builder->new;
  $test->is_eq($got, $expected, $name);
}

sub stderr_is {
  my ($block, $expected, $name) = @_;
  my $got = capture_stderr($block);
  $name //= '';

  my $test = Test::Builder->new;
  $test->is_eq($got, $expected, $name);
}

sub capture_output {
  my ($block) = (@_);
  my $output = '';

  do {
    local *STDOUT;
    local *STDERR = *STDOUT;

    open STDOUT, '>', \$output;
    $block->();

    return $output;
  }
}

sub capture_stdout {
  my ($block) = (@_);
  my $output = '';

  do {
    local *STDOUT;

    open STDOUT, '>', \$output;
    $block->();

    return $output;
  }
}

sub capture_stderr {
  my ($block) = (@_);
  my $output = '';

  do {
    local *STDERR;

    open STDERR, '>', \$output;
    $block->();

    return $output;
  }
}

1;

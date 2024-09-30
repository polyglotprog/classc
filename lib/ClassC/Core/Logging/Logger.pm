package ClassC::Core::Logging::Logger;

use v5.38;

use ClassC::Core::Console::AnsiStyles qw(
    $BOLD
    $BRIGHT_BLUE
    $BRIGHT_CYAN
    $BRIGHT_GREEN
    $BRIGHT_MAGENTA
    $BRIGHT_RED
    $BRIGHT_YELLOW
    $RESET
    set_color
);
use Scalar::Util qw( blessed looks_like_number );
require Data::Dumper;

require Exporter;
our @ISA    = 'Exporter';
our @EXPORT = qw(
    NONE
    DEBUG
    ERROR
    INFO
    WARNING
    TRACE
);

use constant {
  NONE    => 0,
  ERROR   => 1,
  WARNING => 2,
  INFO    => 3,
  DEBUG   => 4,
  TRACE   => 5,
};

my %LOGGING_LEVELS = (
  none    => NONE,
  error   => ERROR,
  warning => WARNING,
  info    => INFO,
  debug   => DEBUG,
  trace   => TRACE,
);

{
  # %LOGGING_LEVELS only has string keys so far. Add corresponding integer keys
  # so we can look up the value by either integer value or name.
  foreach my $level (values %LOGGING_LEVELS) {
    $LOGGING_LEVELS{$level} = $level;
  }
}

# Message Tags
my %TAGS = (
  NONE()    => "",
  ERROR()   => "${BRIGHT_RED         }${BOLD}  error${RESET}",
  WARNING() => "${BRIGHT_YELLOW      }${BOLD}warning${RESET}",
  INFO()    => "${BRIGHT_BLUE        }${BOLD}   info${RESET}",
  DEBUG()   => "${BRIGHT_CYAN        }${BOLD}  debug${RESET}",
  TRACE()   => "${\( set_color(207) )}${BOLD}  trace${RESET}",
);

sub new {
  my $class       = shift;
  my %options     = (@_);
  my $file        = $options{file} // *STDERR;
  my $file_handle = __create_file_handle($file);
  my $level       = $options{level} // INFO;

  return bless {
    file        => $file,
    file_handle => $file_handle,
    level       => $level
  }, $class;
}

sub set_level {
  my ($self, $value) = @_;
  my $level = $LOGGING_LEVELS{$value};
  if (!$level) {
    die "$value is not a valid logging level.";
  }
  $self->{level} = $level;
}

sub is_error_enabled {
  my ($self) = @_;
  return $self->{level} >= ERROR;
}

sub is_warning_enabled {
  my ($self) = @_;
  return $self->{level} >= WARNING;
}

sub is_info_enabled {
  my ($self) = @_;
  return $self->{level} >= INFO;
}

sub is_debug_enabled {
  my ($self) = @_;
  return $self->{level} >= DEBUG;
}

sub is_trace_enabled {
  my ($self) = @_;
  return $self->{level} >= TRACE;
}

sub log {
  my $self  = shift;
  my $level = $_[0];
  if (looks_like_number($level)) {    # => number
    shift;
  } else {                            # => string
    $level = NONE;
  }
  if ($level <= $self->{level}) {
    my $fh  = $self->{file_handle};
    my $tag = $TAGS{$level};
    say $fh $tag ? "$tag " : '', @_;
  }
}

sub logf {
  my $self  = shift;
  my $level = $_[0];
  if (looks_like_number($level)) {    # => number
    shift;
  } else {                            # => string
    $level = NONE;
  }
  my $format = shift;
  if ($level <= $self->{level}) {
    my $fh  = $self->{file_handle};
    my $tag = $TAGS{$level};
    $format = $tag ? "$tag $format" : $format;
    printf $fh "$format\n", @_;
  }
}

sub error {
  my $self = shift;
  if ($self->{level} >= ERROR) {
    my $fh = $self->{file_handle};
    say $fh "$TAGS{ERROR()} ", @_;
  }
}

sub errorf {
  my ($self, $format) = (shift, shift);
  if ($self->{level} >= ERROR) {
    my $fh = $self->{file_handle};
    printf $fh "$TAGS{ERROR()} $format\n", @_;
  }
}

sub warning {
  my $self = shift;
  if ($self->{level} >= WARNING) {
    my $fh = $self->{file_handle};
    say $fh "$TAGS{WARNING()} ", @_;
  }
}

sub warningf {
  my ($self, $format) = (shift, shift);
  if ($self->{level} >= WARNING) {
    my $fh = $self->{file_handle};
    printf $fh "$TAGS{WARNING()} $format\n", @_;
  }
}

sub info {
  my $self = shift;
  if ($self->{level} >= INFO) {
    my $fh = $self->{file_handle};
    say $fh "$TAGS{INFO()} ", @_;
  }
}

sub infof {
  my ($self, $format) = (shift, shift);
  if ($self->{level} >= INFO) {
    my $fh = $self->{file_handle};
    printf $fh "$TAGS{INFO()} $format\n", @_;
  }
}

sub debug {
  my $self = shift;
  if ($self->{level} >= DEBUG) {
    my $fh = $self->{file_handle};
    say $fh "$TAGS{DEBUG()} ", @_;
  }
}

sub debugf {
  my ($self, $format) = (shift, shift);
  if ($self->{level} >= DEBUG) {
    my $fh = $self->{file_handle};
    printf $fh "$TAGS{DEBUG()} $format\n", @_;
  }
}

sub trace {
  my $self = shift;
  if ($self->{level} >= TRACE) {
    my $fh = $self->{file_handle};
    say $fh "$TAGS{TRACE()} ", @_;
  }
}

sub tracef {
  my ($self, $format) = (shift, shift);
  if ($self->{level} >= TRACE) {
    my $fh = $self->{file_handle};
    printf $fh "$TAGS{TRACE()} $format\n", @_;
  }
}

sub __create_file_handle {
  my ($file) = @_;
  my $ref = ref(\$file);

  my $file_handle;
  if ($ref eq 'GLOB') {
    $file_handle = $file;
  } elsif ($ref eq 'SCALAR' && ($file & ~$file)) {
    open $file_handle, ">$file";
  } else {
    die "Invalid file (type $ref): $file";
  }

  return $file_handle;
}

1;

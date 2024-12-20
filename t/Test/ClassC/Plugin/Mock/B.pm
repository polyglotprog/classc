package Test::ClassC::Plugin::Mock::B;

use ClassC::Core::Logging::Logger;
use Scalar::Util qw(blessed);

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

my %default_options = (b => 0);

sub new {
  my $class = shift;
  $logger->trace("> Initializing mock plugin B");

  # Options as hash ref
  if (ref($_[0]) eq 'HASH') {
    return bless { %default_options, %{ $_[0] } }, $class;
  }

  # Options as list
  my %options = (@_);
  return bless \%options, $class;
}

sub __fields {
  return [
    # Field order used by `inspect` (see ClassC::Core::Util)
    'b',
  ];
}

sub plug_in {
  my ($self, $data) = @_;
  $logger->trace("> Applying mock plugin B");
  $data->{B} = $self->{b};
  return $data;
}

1;

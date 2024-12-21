package ClassC::Plugin::Inheritance::None;

use v5.38;

use ClassC::Core::Logging::Logger;
use ClassC::Core::Util qw(inspect);

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

my %default_options = ();

sub new {
  my $class = shift;
  # Options as hash ref
  if (ref($_[0]) eq 'HASH') {
    return bless {%default_options, %{$_[0]}}, $class;
  }
  # Options as list
  my %options = (%default_options, @_);
  return bless \%options, $class;
}

sub __fields {
  # Field order used by `inspect` (see ClassC::Core::Util)
  return [];
}

sub plug_in {
  return resolve_inheritance(@_);
}

sub resolve_inheritance {
  my ($self, $data) = @_;
  $logger->warning("No inheritance will be applied.");
  return $data;
}

1;

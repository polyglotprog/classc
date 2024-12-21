package ClassC::Plugin::Inheritance;

use v5.38;

use ClassC::Core::Logging::Logger;
use ClassC::Core::Util qw(inspect);
require ClassC::Plugin::Inheritance::None;

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

my %DEFAULT_OPTIONS = (
  strategy => 'none',
);

sub new {
  my $class = shift;
  # Options as hash ref
  if (ref($_[0]) eq 'HASH') {
    return bless {%DEFAULT_OPTIONS, %{$_[0]}}, $class;
  }
  # Options as list
  my %options = (%DEFAULT_OPTIONS, @_);
  return bless \%options, $class;
}

sub __fields {
  return [
    # Field order used by `inspect` (see ClassC::Core::Util)
    'strategy',
  ];
}

sub plug_in {
  return resolve_inheritance(@_);
}

sub resolve_inheritance {
  my ($self, $data) = @_;
  my $strategy = $self->{strategy};
  my $plugin = __PACKAGE__ . '::' . __to_pascal_case($strategy);
  my $resolver = $plugin->new($self);
  return $resolver->resolve_inheritance($data);
}

sub __to_pascal_case {
  my ($string) = @_;
  $string =~ s/(-|_)(\w)/\u$2/g;
  return ucfirst($string);
}

1;

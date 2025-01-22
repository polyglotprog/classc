package ClassC::Plugin::Inheritance::Single;

use v5.38;

use ClassC::Core::Logging::Logger;
use ClassC::Core::Util qw(inspect);

my %DEFAULT_OPTIONS = (
  max_inheritance_depth => 4,
);

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

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
    'max_inheritance_depth',
  ];
}

sub plug_in {
  return resolve_inheritance(@_);
}

sub resolve_inheritance {
  my ($self, $data) = @_;
  my $classes = $data->{classes};
  my $max_depth = $self->{max_inheritance_depth};

  for my $class (values %$classes) {
    my $chain = [];
    __recursively_resolve_inheritance(0, $max_depth, $classes, $class, $chain);
  }

  $logger->trace('Resolved: ', inspect($data));
  return $data;
}

sub __recursively_resolve_inheritance {
  my ($depth, $max_depth, $classes, $class, $chain) = @_;

  if ($depth > $max_depth) {
    $logger->error("Depth $depth greater than max depth $max_depth!");
    die '';
  }

  return if ($class->{resolved});

  my $class_name = $class->{name};
  my @parents = @{$class->{parents}};
  push @$chain, $class_name;

  if ($#parents > 1) {
    $logger->error("Class $class_name is not allowed to have more than one superclass.");
    die ''; # TODO
  }

  my $parent_name = $parents[0];
  if ($parent_name) {
    my $superclass = $classes->{$parent_name};
    if (!$superclass) {
      $logger->error("Class $parent_name does not exist!");
      die ''; # TODO
    }
    if (!$superclass->{resolved}) {
      __recursively_resolve_inheritance($depth + 1, $max_depth, $classes,
          $superclass, $chain);
    }
    unshift @{$class->{fields}}, @{$superclass->{fields}};
    unshift @{$class->{methods}}, @{$superclass->{methods}};
  }

  $class->{resolved} = 1;
}

1;

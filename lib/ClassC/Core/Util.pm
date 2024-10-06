package ClassC::Core::Util;

use v5.38;
use Scalar::Util qw(blessed);
require Data::Dumper;
require Exporter;

our @ISA    = 'Exporter';
our @EXPORT = qw(
    inspect
);

sub inspect {
  #<<< perltidy: ignore formatting
  return Data::Dumper
      ->new(\@_)
      ->Indent(1)
      ->Pad('    ')
      ->Sortkeys(\&__sortkeys)
      ->Terse(1)
      ->Dump();
  #>>>
}

sub __sortkeys {
  my ($self) = @_;

  if (blessed($self) && $self->can('__fields')) {
    return $self->__fields();
  }

  my @keys = keys %$self;
  return \@keys;
}

1;

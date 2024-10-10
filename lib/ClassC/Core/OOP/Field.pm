package ClassC::Core::OOP::Field;

use v5.38;

use constant {
  UNKNOWN => 0,
  FIELD   => 1,
};

my %TYPE_DESCRIPTIONS = (
  UNKNOWN() => 'Unknown Field',
  FIELD()   => 'Field',
);

sub new {
  my $class = shift;
  my %self  = (@_);
  set_id(\%self, $self{id} // UNKNOWN());
  return bless \%self, $class;
}

sub __fields {
  return [
    # Field order used by `inspect` (see ClassC::Core::Util)
    'id',
    'description',
    'source',
    'type',
    'name',
  ];
}

sub set_id {
  my ($self, $id) = @_;
  my $description = $TYPE_DESCRIPTIONS{$id} // $TYPE_DESCRIPTIONS{ UNKNOWN() };
  $self->{id}          = $id;
  $self->{description} = $description;
}

1;

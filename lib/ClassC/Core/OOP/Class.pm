package ClassC::Core::OOP::Class;

use v5.38;

use constant {
  UNKNOWN => 0,
  CLASS   => 1,
};

my %TYPE_DESCRIPTIONS = (
  UNKNOWN() => 'Unknown Class',
  CLASS()   => 'Class',
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
    'resolved',
    'header_file',
    'source_file',
    'full_name',
    'name',
    'dependencies',
    'parents',
    'fields',
    'methods',
  ];
}

sub set_id {
  my ($self, $id) = @_;
  my $description = $TYPE_DESCRIPTIONS{$id} // $TYPE_DESCRIPTIONS{ UNKNOWN() };
  $self->{id}          = $id;
  $self->{description} = $description;
}

1;

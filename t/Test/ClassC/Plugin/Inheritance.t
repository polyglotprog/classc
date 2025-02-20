package Test::ClassC::Plugin::Inheritance;

use v5.38;
use lib './lib';
use lib './t';

require ClassC::Plugin::Inheritance;
require Test::Data::Example::1::In;
require Test::Data::Example::2::In;
require Test::Data::Example::2::Out;

use Test::More tests => 2;

my ($strategy, $data);

# Inheritance::None
$strategy = ClassC::Plugin::Inheritance->new(strategy => 'none');
$data = {
  classes => {
    'Object' => $Test::Data::Example::1::OBJECT,
    'Car'    => $Test::Data::Example::1::CAR,
  },
};
is_deeply($strategy->resolve_inheritance($data), $data, 'No inheritance');

# Inheritance::Single
$strategy = ClassC::Plugin::Inheritance->new(strategy => 'single');
$data = {
  classes => {
    'Animal'  => $Test::Data::Example::2::In::ANIMAL,
    'Bird'    => $Test::Data::Example::2::In::BIRD,
    'Cat'     => $Test::Data::Example::2::In::CAT,
    'Dog'     => $Test::Data::Example::2::In::DOG,
    'Parrot'  => $Test::Data::Example::2::In::PARROT,
    'Penguin' => $Test::Data::Example::2::In::PENGUIN,
  },
};
is_deeply($strategy->resolve_inheritance($data), {
    classes => {
      'Animal'  => $Test::Data::Example::2::Out::ANIMAL,
      'Bird'    => $Test::Data::Example::2::Out::BIRD,
      'Cat'     => $Test::Data::Example::2::Out::CAT,
      'Dog'     => $Test::Data::Example::2::Out::DOG,
      'Parrot'  => $Test::Data::Example::2::Out::PARROT,
      'Penguin' => $Test::Data::Example::2::Out::PENGUIN,
    },
  },
  'Single Inheritance'
);

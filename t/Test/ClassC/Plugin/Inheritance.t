package Test::ClassC::Plugin::Inheritance;

use v5.38;
use lib './lib';
use lib './t';

require ClassC::Plugin::Inheritance;
require Test::Data::Example::1;
require Test::ClassC::TestData::Example2;

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
    'Object' => $Test::Data::Example::1::OBJECT,
    'Car'    => $Test::Data::Example::1::CAR,
  },
};
is_deeply($strategy->resolve_inheritance($data),
    classes => {
      'Object' => $Test::ClassC::TestData::Example2::OBJECT,
      'Car'    => $Test::ClassC::TestData::Example2::CAR,
    },
    'No inheritance'
);

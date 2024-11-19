package Test::ClassC::Plugin::Parser;

use v5.38;
use lib './lib';
use lib './t';

use Test::Data::Example::1::In qw(
    $OBJECT
    $BIRD
    $CAR
);
require ClassC::Plugin::Parser;

use Test::More tests => 1;

my $parser;

$parser = ClassC::Plugin::Parser->new(input_dir => 'example/1/in');
is_deeply(
  $parser->parse(),
  {
    input_dir => 'example/1/in',
    classes   => {
      'Object' => $OBJECT,
      'Bird'   => $BIRD,
      'Car'    => $CAR,
    }
  },
  'Parsed classes'
);

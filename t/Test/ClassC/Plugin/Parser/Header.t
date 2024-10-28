package Test::ClassC::Plugin::Parser::Header;

use v5.38;
use lib './lib';
use lib './t';

use ClassC::Core::Logging::Logger;
use Test::Data::Example::1::In qw(
    $OBJECT
    $CAR
);
require ClassC::Core::OOP::Class;
require ClassC::Core::OOP::Dependency;
require ClassC::Core::OOP::Field;
require ClassC::Core::OOP::Method;
require ClassC::Plugin::Parser::Header;

use Test::More tests => 2;
use Test::IO;

my $class;

# Object
$class = ClassC::Plugin::Parser::Header::parse_header('example/1/in/Object.h',
  relative_to => 'example/1/in');
is_deeply($class, $OBJECT, 'Parse Object');

# Car
$class = ClassC::Plugin::Parser::Header::parse_header('example/1/in/Car.h',
  relative_to => 'example/1/in');
is_deeply($class, $CAR, 'Parse Car');

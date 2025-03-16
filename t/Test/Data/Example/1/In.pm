package Test::Data::Example::1::In;

use v5.38;
use lib './lib';
use lib './t';

use ClassC::Core::Logging::Logger;
require ClassC::Core::OOP::Class;
require ClassC::Core::OOP::Dependency;
require ClassC::Core::OOP::Field;
require ClassC::Core::OOP::Method;
require ClassC::Plugin::Parser::Header;
require Exporter;

use Test::IO;

our @ISA    = 'Exporter';
our @EXPORT = qw(
    $OBJECT
    $BIRD
    $CAR
);

our $OBJECT = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  header_file  => 'Object.h',
  source_file  => 'Object.c',
  full_name    => 'Object',
  name         => 'Object',
  lines        => [ get_file_lines('example/1/in/Object.h') ],
  dependencies => [
    ClassC::Core::OOP::Dependency->new(
      id          => ClassC::Core::OOP::Dependency::SYSTEM(),
      description => 'System Dependency',
      dependency  => 'stdbool.h',
    ),
  ],
  parents => [],
  fields  => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Object',
      override    => 0,
      return_type => 'int',
      name        => 'hash',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Object',
      override    => 0,
      return_type => 'bool',
      name        => 'equals',
      arguments   => 'void* this, void* that',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Object',
      override    => 0,
      return_type => 'char*',
      name        => 'to_string',
      arguments   => 'void* this',
    )
  ]
);

our $BIRD = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  header_file  => 'Bird.h',
  source_file  => 'Bird.c',
  full_name    => 'Bird',
  name         => 'Bird',
  lines        => [ get_file_lines('example/1/in/Bird.h') ],
  dependencies => [],
  parents      => [],
  fields       => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Bird',
      override    => 0,
      return_type => 'void',
      name        => 'make_noise',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Bird',
      override    => 0,
      return_type => 'void',
      name        => 'fly',
      arguments   => 'void* this',
    ),
  ]
);

our $CAR = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  header_file  => 'Car.h',
  source_file  => 'Car.c',
  full_name    => 'Car',
  name         => 'Car',
  lines        => [ get_file_lines('example/1/in/Car.h') ],
  dependencies => [],
  parents      => [],
  fields       => [
    ClassC::Core::OOP::Field->new(
      id          => ClassC::Core::OOP::Field::FIELD(),
      description => 'Field',
      source      => 'Car',
      type        => 'int',
      name        => 'max_speed',
    ),
    ClassC::Core::OOP::Field->new(
      id          => ClassC::Core::OOP::Field::FIELD(),
      description => 'Field',
      source      => 'Car',
      type        => 'int',
      name        => 'horse_power',
    ),
  ],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Car',
      override    => 0,
      return_type => 'void',
      name        => 'move',
      arguments   => 'void* this',
    ),
  ]
);

1;

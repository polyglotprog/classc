package Test::Data::Example::2::Out;

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
    $ANIMAL
    $BIRD
    $CAT
    $DOG
    $PARROT
    $PENGUIN
);

our $ANIMAL = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  resolved     => 1,
  header_file  => 'Animal.h',
  source_file  => 'Animal.c',
  full_name    => 'Animal',
  name         => 'Animal',
  lines        => [ get_file_lines('example/2/in/Animal.h') ],
  dependencies => [],
  parents      => [],
  fields       => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 0,
      return_type => 'void',
      name        => 'make_sound',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 0,
      return_type => 'void',
      name        => 'move',
      arguments   => 'void* this',
    ),
  ],
);

our $BIRD = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  resolved     => 1,
  header_file  => 'Bird.h',
  source_file  => 'Bird.c',
  full_name    => 'Bird',
  name         => 'Bird',
  lines        => [ get_file_lines('example/2/in/Bird.h') ],
  dependencies => [],
  parents      => ['Animal'],
  fields       => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'make_sound',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'move',
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
  ],
);

our $CAT = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  resolved     => 1,
  header_file  => 'Cat.h',
  source_file  => 'Cat.c',
  full_name    => 'Cat',
  name         => 'Cat',
  lines        => [ get_file_lines('example/2/in/Cat.h') ],
  dependencies => [],
  parents      => ['Animal'],
  fields       => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'make_sound',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'move',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Cat',
      override    => 0,
      return_type => 'void',
      name        => 'scratch',
      arguments   => 'void* this',
    ),
  ],
);

our $DOG = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  resolved     => 1,
  header_file  => 'Dog.h',
  source_file  => 'Dog.c',
  full_name    => 'Dog',
  name         => 'Dog',
  lines        => [ get_file_lines('example/2/in/Dog.h') ],
  dependencies => [],
  parents      => ['Animal'],
  fields       => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'make_sound',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'move',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Dog',
      override    => 0,
      return_type => 'void',
      name        => 'fetch',
      arguments   => 'void* this',
    ),
  ],
);

our $PARROT = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  resolved     => 1,
  header_file  => 'Parrot.h',
  source_file  => 'Parrot.c',
  full_name    => 'Parrot',
  name         => 'Parrot',
  lines        => [ get_file_lines('example/2/in/Parrot.h') ],
  dependencies => [],
  parents      => ['Bird'],
  fields       => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'make_sound',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'move',
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
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Parrot',
      override    => 0,
      return_type => 'void',
      name        => 'talk',
      arguments   => 'void* this',
    ),
  ],
);

our $PENGUIN = ClassC::Core::OOP::Class->new(
  id           => ClassC::Core::OOP::Class::CLASS(),
  resolved     => 1,
  header_file  => 'Penguin.h',
  source_file  => 'Penguin.c',
  full_name    => 'Penguin',
  name         => 'Penguin',
  lines        => [ get_file_lines('example/2/in/Penguin.h') ],
  dependencies => [],
  parents      => ['Bird'],
  fields       => [],
  methods => [
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'make_sound',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Animal',
      override    => 1,
      return_type => 'void',
      name        => 'move',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Bird',
      override    => 1,
      return_type => 'void',
      name        => 'fly',
      arguments   => 'void* this',
    ),
    ClassC::Core::OOP::Method->new(
      id          => ClassC::Core::OOP::Method::METHOD(),
      description => 'Method',
      source      => 'Penguin',
      override    => 0,
      return_type => 'void',
      name        => 'slide',
      arguments   => 'void* this',
    ),
  ],
);

1;

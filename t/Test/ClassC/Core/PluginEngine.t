package Test::ClassC::PluginEngine;

use v5.38;
use lib './lib';
use lib './t';

use ClassC::Core::Util qw(
  inspect
);
use Test::Data::Example::1::In qw(
    $OBJECT
    $BIRD
    $CAR
);
require ClassC::Core::PluginEngine;

use Test::More tests => 2;

my ($plugin_manager, $configuration, $result);


################################################################################
# Mock Plugins
################################################################################

$plugin_manager = ClassC::Core::PluginEngine->new(
  plugin_base_path => 'Test::ClassC::Plugin::Mock');
$configuration = {
  A => {
    a => 1,
  },
  B => {
    b => 2,
  },
  C => {
    c => 3,
  }
};

say "\nTest loading mock plugins...";
$plugin_manager->load_plugins('A', 'B', 'C', $configuration);
$result = $plugin_manager->apply_plugins({});

is_deeply(
  $result,
  {
    A => 1,
    B => 2,
    C => 3,
  },
  'Load and apply mock plugins'
);


################################################################################
# Real Plugins
################################################################################

$plugin_manager = ClassC::Core::PluginEngine->new();
$configuration  = {
  Parser => {
    input_dir => 'example/1/in',
  },
  Writer => {
    output_dir => 'example/1/out',
  },
};

say "\nTest loading ClassC plugins...";
$plugin_manager->load_plugins('Parser', 'Writer', $configuration);
$result = $plugin_manager->apply_plugins({});

is_deeply(
  $result,
  {
    input_dir  => 'example/1/in',
    output_dir => 'example/1/out',
    classes    => {
      'Object' => $OBJECT,
      'Bird'   => $BIRD,
      'Car'    => $CAR,
    },
    files_written_count => 3,
  },
  'Load and apply ClassC plugins'
);

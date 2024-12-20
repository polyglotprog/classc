package ClassC::Core::PluginEngine;

use v5.38;

use ClassC::Core::Logging::Logger;
use Scalar::Util qw(blessed);

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

sub new {
  my $class   = shift;
  my %options = (
    plugin_base_path => 'ClassC::Plugin',
    loaded_plugins   => [],
    @_,
  );
  return bless \%options, $class;
}

sub __fields {
  return [
    # Field order used by `inspect` (see ClassC::Core::Util)
    'plugin_base_path',
    'loaded_plugins',
  ];
}

sub load_plugin {
  my ($self, $plugin_name, $configuration) = @_;
  my $loaded_plugins = $self->{loaded_plugins};
  my $plugin         = "$self->{plugin_base_path}::$plugin_name";
  my $plugin_path    = $plugin =~ s/::/\//gr;

  $logger->debug("Loading plugin $plugin");
  require "$plugin_path.pm";
  push @$loaded_plugins, $plugin->new($configuration);
}

sub load_plugins {
  my ($self, $configuration) = (shift, {});

  # Configuration can be either first or last argument
  if (ref($_[0]) eq 'HASH') {
    $configuration = shift @_;
  } elsif (ref($_[-1]) eq 'HASH') {
    $configuration = pop @_;
  }

  for my $plugin (@_) {
    $self->load_plugin($plugin, $configuration->{$plugin} // {});
  }
  $logger->debug("Loaded ${\( scalar @_ )} plugins total");
}

sub apply_plugins {
  my ($self, $data) = @_;
  $data //= {};

  my $plugins = $self->{loaded_plugins};
  for my $plugin (@$plugins) {
    $logger->debug("Applying plugin ${\( blessed($plugin) )}");
    $data = $plugin->plug_in($data);
  }
  return $data;
}

1;

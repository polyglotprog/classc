package ClassC::Plugin::Inheritance;

use v5.38;

use ClassC::Core::Logging::Logger;

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

sub new {
  my $class = shift;
  return bless {}, $class;
}

sub resolve_inheritance {
  $logger->warning("TODO: Implement inheritance!");
}

1;

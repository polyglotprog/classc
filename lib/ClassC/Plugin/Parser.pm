package ClassC::Plugin::Parser;

use v5.38;

use ClassC::Core::Logging::Logger;
use ClassC::Core::Util qw(inspect);
use Cwd                qw(abs_path);
use Data::Dumper;
require File::Find;
require File::Spec;
require ClassC::Plugin::Parser::Header;

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

my %default_options = (input_dir => 'in',);

sub new {
  my $class = shift;

  # Options as hash ref
  if (ref($_[0]) eq 'HASH') {
    return bless { %default_options, %{ $_[0] } }, $class;
  }

  # Options as list
  my %options = (%default_options, @_);
  return bless \%options, $class;
}

sub __fields {
  return [
    # Field order used by `inspect` (see ClassC::Core::Util)
    'input_dir',
  ];
}

sub parse {
  my ($self, $data) = @_;
  $data //= {};

  my $input_dir = $self->{input_dir};
  $data->{input_dir} = $input_dir;
  $logger->info("Parsing classes in $input_dir");

  my $classes = {};
  File::Find::find(
    {
      no_chdir => 1,
      wanted   => sub {
        if ($_ =~ m/\.h$/) {
          my $class = ClassC::Plugin::Parser::Header::parse_header($_,
            relative_to => $input_dir);
          $classes->{ $class->{full_name} } = $class;
        }
      },
    },
    $input_dir
  );

  $data->{classes} = $classes;

  if ($logger->is_trace_enabled()) {
    $logger->trace("Parsed data:", inspect($data));
  }
  return $data;
}

1;

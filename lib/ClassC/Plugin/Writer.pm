package ClassC::Plugin::Writer;

use v5.38;

use ClassC::Core::Logging::Logger;
use Cwd qw(abs_path);
use Data::Dumper;
use File::Path qw(make_path rmtree);
use File::Spec;

require ClassC::Plugin::Writer::Header;

my $logger = ClassC::Core::Logging::Logger->new(level => TRACE);

my %default_options = (output_dir => 'out',);

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
    'output_dir',
  ];
}

sub write {
  my ($self, $data) = @_;
  $data //= {};

  my $output_dir = $self->{output_dir};
  $data->{output_dir} = $output_dir;

  $logger->info("Writing classes to $output_dir");
  rmtree($output_dir);       # remove output directory
  make_path($output_dir);    # recreate

  my $classes             = $data->{classes};
  my $files_written_count = 0;
  my %paths               = ();                 # set of created directory paths
  foreach my $class (values %$classes) {

    # Create class directory if it doesn't exist
    my $path = $class->{full_name};
    if (not exists $paths{$path}) {
      my $new_path = File::Spec->catfile($output_dir, $path);
      # make_path($new_path)
      #     or die "Couldn't create $new_path";
      $paths{$path} = undef;    # add to set
    }

    # Write header file
    my $header_file = File::Spec->catfile($output_dir, $class->{header_file});
    ClassC::Plugin::Writer::Header::write_header($header_file, $class);
    $files_written_count++;
  }

  $data->{files_written_count} = $files_written_count;
  my $file_label = $files_written_count == 1 ? 'file' : 'files';
  $logger->debug("Wrote $files_written_count $file_label.");

  return $data;
}

1;

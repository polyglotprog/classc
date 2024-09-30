package ClassC::Core::Console::AnsiStyles;

###############################################################################
# We could use Term::ANSIColor but that is overkill for our needs. See:
#
#   https://perldoc.perl.org/Term::ANSIColor
#
# Also see the following for documentation on ANSI escape codes:
#
#   https://chrisyeh96.github.io/2020/03/28/terminal-colors.html
#   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
#
# Most of the below colors/styles are not used in this project but are included
# for completeness.
###############################################################################

use v5.38;

require Exporter;

our @ISA    = 'Exporter';
our @EXPORT = qw(
    $RESET
    $BOLD
    $ITALIC
    $DIM
    $UNDERLINE
    $BLINKING
    $INVERSE
    $HIDDEN
    $STRIKETHROUGH

    $BLACK
    $RED
    $GREEN
    $YELLOW
    $BLUE
    $MAGENTA
    $CYAN
    $WHITE
    $DEFAULT

    $BACKGROUND_BLACK
    $BACKGROUND_RED
    $BACKGROUND_GREEN
    $BACKGROUND_YELLOW
    $BACKGROUND_BLUE
    $BACKGROUND_MAGENTA
    $BACKGROUND_CYAN
    $BACKGROUND_WHITE

    $BRIGHT_BLACK
    $BRIGHT_RED
    $BRIGHT_GREEN
    $BRIGHT_YELLOW
    $BRIGHT_BLUE
    $BRIGHT_MAGENTA
    $BRIGHT_CYAN
    $BRIGHT_WHITE

    $BRIGHT_BACKGROUND_BLACK
    $BRIGHT_BACKGROUND_RED
    $BRIGHT_BACKGROUND_GREEN
    $BRIGHT_BACKGROUND_YELLOW
    $BRIGHT_BACKGROUND_BLUE
    $BRIGHT_BACKGROUND_MAGENTA
    $BRIGHT_BACKGROUND_CYAN
    $BRIGHT_BACKGROUND_WHITE

    reset
    bold
    italic
    dim
    underline
    blinking
    inverse
    hidden
    strikethrough

    black
    red
    green
    yellow
    blue
    magenta
    cyan
    white
    default

    set_rgb
    set_color

    background_black
    background_red
    background_green
    background_yellow
    background_blue
    background_magenta
    background_cyan
    background_white

    set_background_rgb
    set_background_color

    bright_black
    bright_red
    bright_green
    bright_yellow
    bright_blue
    bright_magenta
    bright_cyan
    bright_white

    bright_background_black
    bright_background_red
    bright_background_green
    bright_background_yellow
    bright_background_blue
    bright_background_magenta
    bright_background_cyan
    bright_background_white
);

# Begin ANSI Escape Sequence
my $ESC = "\x1b";

# Styles
our $RESET         = "$ESC\[0m";
our $BOLD          = "$ESC\[1m";
our $DIM           = "$ESC\[2m";
our $ITALIC        = "$ESC\[3m";
our $UNDERLINE     = "$ESC\[4m";
our $BLINKING      = "$ESC\[5m";
our $INVERSE       = "$ESC\[7m";
our $HIDDEN        = "$ESC\[8m";
our $STRIKETHROUGH = "$ESC\[9m";

# Foreground Colors
our $BLACK   = "$ESC\[30m";
our $RED     = "$ESC\[31m";
our $GREEN   = "$ESC\[32m";
our $YELLOW  = "$ESC\[33m";
our $BLUE    = "$ESC\[34m";
our $MAGENTA = "$ESC\[35m";
our $CYAN    = "$ESC\[36m";
our $WHITE   = "$ESC\[37m";
our $DEFAULT = "$ESC\[38m";

# Set Colors (Non-Standard)
our $SET_RGB   = "$ESC\[38m;2;";    # non-standard
our $SET_COLOR = "$ESC\[38m;5;";    # non-standard

# Background Colors
our $BACKGROUND_BLACK   = "$ESC\[40m";
our $BACKGROUND_RED     = "$ESC\[41m";
our $BACKGROUND_GREEN   = "$ESC\[42m";
our $BACKGROUND_YELLOW  = "$ESC\[43m";
our $BACKGROUND_BLUE    = "$ESC\[44m";
our $BACKGROUND_MAGENTA = "$ESC\[45m";
our $BACKGROUND_CYAN    = "$ESC\[46m";
our $BACKGROUND_WHITE   = "$ESC\[47m";

# Set Background Colors (Non-Standard)
our $SET_BACKGROUND_RGB   = "$ESC\[48m;2;";    # non-standard
our $SET_BACKGROUND_COLOR = "$ESC\[48m;5;";    # non-standard

# Bright Foreground Colors (Non-Standard)
our $BRIGHT_BLACK   = "$ESC\[90m";
our $BRIGHT_RED     = "$ESC\[91m";
our $BRIGHT_GREEN   = "$ESC\[92m";
our $BRIGHT_YELLOW  = "$ESC\[93m";
our $BRIGHT_BLUE    = "$ESC\[94m";
our $BRIGHT_MAGENTA = "$ESC\[95m";
our $BRIGHT_CYAN    = "$ESC\[96m";
our $BRIGHT_WHITE   = "$ESC\[97m";

# Bright Background Colors (Non-Standard)
our $BRIGHT_BACKGROUND_BLACK   = "$ESC\[100m";
our $BRIGHT_BACKGROUND_RED     = "$ESC\[101m";
our $BRIGHT_BACKGROUND_GREEN   = "$ESC\[102m";
our $BRIGHT_BACKGROUND_YELLOW  = "$ESC\[103m";
our $BRIGHT_BACKGROUND_BLUE    = "$ESC\[104m";
our $BRIGHT_BACKGROUND_MAGENTA = "$ESC\[105m";
our $BRIGHT_BACKGROUND_CYAN    = "$ESC\[106m";
our $BRIGHT_BACKGROUND_WHITE   = "$ESC\[107m";

#
# Styles
#

sub bold {
  my ($string) = @_;
  return "${BOLD}${string}";
}

sub dim {
  my ($string) = @_;
  return "${DIM}${string}";
}

sub italic {
  my ($string) = @_;
  return "${ITALIC}${string}";
}

sub underline {
  my ($string) = @_;
  return "${UNDERLINE}${string}";
}

sub blinking {
  my ($string) = @_;
  return "${BLINKING}${string}";
}

sub inverse {
  my ($string) = @_;
  return "${INVERSE}${string}";
}

sub hidden {
  my ($string) = @_;
  return "${HIDDEN}${string}";
}

sub strikethrough {
  my ($string) = @_;
  return "${STRIKETHROUGH}${string}";
}

sub reset {
  my ($string) = @_;
  return "${string}${RESET}";
}


#
# Colors
#

sub black {
  my ($string) = @_;
  return "${BLACK}${string}";
}

sub red {
  my ($string) = @_;
  return "${RED}${string}";
}

sub green {
  my ($string) = @_;
  return "${GREEN}${string}";
}

sub yellow {
  my ($string) = @_;
  return "${YELLOW}${string}";
}

sub blue {
  my ($string) = @_;
  return "${BLUE}${string}";
}

sub magenta {
  my ($string) = @_;
  return "${MAGENTA}${string}";
}

sub cyan {
  my ($string) = @_;
  return "${CYAN}${string}";
}

sub white {
  my ($string) = @_;
  return "${WHITE}${string}";
}

sub default {
  my ($string) = @_;
  return "${DEFAULT}${string}";
}

# Non-Standard
sub set_rgb {
  my ($red, $green, $blue) = @_;
  return "${ESC}\[38;2;${red};${green};${blue}m";
}

# Non-Standard
sub set_color {
  my ($value) = @_;
  return "${ESC}\[38;5;${value}m";
}


#
# Background Colors
#

sub background_black {
  my ($string) = @_;
  return "${BACKGROUND_BLACK}${string}";
}

sub background_red {
  my ($string) = @_;
  return "${BACKGROUND_RED}${string}";
}

sub background_green {
  my ($string) = @_;
  return "${BACKGROUND_GREEN}${string}";
}

sub background_yellow {
  my ($string) = @_;
  return "${BACKGROUND_YELLOW}${string}";
}

sub background_blue {
  my ($string) = @_;
  return "${BACKGROUND_BLUE}${string}";
}

sub background_magenta {
  my ($string) = @_;
  return "${BACKGROUND_MAGENTA}${string}";
}

sub background_cyan {
  my ($string) = @_;
  return "${BACKGROUND_CYAN}${string}";
}

sub background_white {
  my ($string) = @_;
  return "${BACKGROUND_WHITE}${string}";
}

# Non-Standard
sub set_background_rgb {
  my ($red, $green, $blue) = @_;
  return "${ESC}\[48;2;${red};${green};${blue}m";
}

# Non-Standard
sub set_background_color {
  my ($value) = @_;
  return "${ESC}\[48;5;${value}m";
}


#
# Strong Foreground Colors (Non-Standard)
#

sub bright_black {
  my ($string) = @_;
  return "${BRIGHT_BLACK}${string}";
}

sub bright_red {
  my ($string) = @_;
  return "${BRIGHT_RED}${string}";
}

sub bright_green {
  my ($string) = @_;
  return "${BRIGHT_GREEN}${string}";
}

sub bright_yellow {
  my ($string) = @_;
  return "${BRIGHT_YELLOW}${string}";
}

sub bright_blue {
  my ($string) = @_;
  return "${BRIGHT_BLUE}${string}";
}

sub bright_magenta {
  my ($string) = @_;
  return "${BRIGHT_MAGENTA}${string}";
}

sub bright_cyan {
  my ($string) = @_;
  return "${BRIGHT_CYAN}${string}";
}

sub bright_white {
  my ($string) = @_;
  return "${BRIGHT_WHITE}${string}";
}


#
# Strong Background Colors (Non-Standard)
#

sub bright_background_black {
  my ($string) = @_;
  return "${BRIGHT_BLACK}${string}";
}

sub bright_background_red {
  my ($string) = @_;
  return "${BRIGHT_RED}${string}";
}

sub bright_background_green {
  my ($string) = @_;
  return "${BRIGHT_GREEN}${string}";
}

sub bright_background_yellow {
  my ($string) = @_;
  return "${BRIGHT_YELLOW}${string}";
}

sub bright_background_blue {
  my ($string) = @_;
  return "${BRIGHT_BLUE}${string}";
}

sub bright_background_magenta {
  my ($string) = @_;
  return "${BRIGHT_MAGENTA}${string}";
}

sub bright_background_cyan {
  my ($string) = @_;
  return "${BRIGHT_CYAN}${string}";
}

sub bright_background_white {
  my ($string) = @_;
  return "${BRIGHT_WHITE}${string}";
}

1;

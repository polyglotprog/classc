package ClassC::Plugin::Parser::Tokens;

use ClassC::Plugin::Parser::Util qw(tokens);
require Exporter;

our @ISA    = qw(Exporter);
our @EXPORT = qw(
    $BLANK_LINE_TOKENS
    $CLASS_TOKENS
    $FIELD_TOKENS
    $INCLUDE_TOKENS
    $METHOD_TOKENS
);

#<<< perltidy: ignore formatting
our $BLANK_LINE_TOKENS = tokens(
  '^\\s*',
  '$',
);

our $INCLUDE_TOKENS = tokens(
  '^\\s*',
  '#include',
  '\\s+',
  '([\\<"]\\w+\\.h[\\>"])',
  '\\s*$',
);

our $CLASS_TOKENS = tokens(
  '^\\s*',
  'class',
  '\\s+',
  '(\\w+)',
  '\\s*(\\{)',
  '\\s*$',
);

our $FIELD_TOKENS = tokens(
  '^\\s*',
  '(\\w+\\*?)',
  '\\s+',
  '(\\*?\\w+)',
  '\\s*;',
  '\\s*$',
);

our $METHOD_TOKENS = tokens(
  '^\\s*',
  '(\\w+\\*?)',
  '\\s+',
  '(\\*?\\w+)',
  '\\(([\\w\\s\\*,]*)\\)',
  '\\s*;',
  '\\s*$',
);
#>>>

1;

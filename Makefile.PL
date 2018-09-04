BEGIN { push @INC, '.' unless $INC[-1] eq '.' }
use inc::Module::Install;

name 'Text-MicroTemplate';
all_from 'lib/Text/MicroTemplate.pm';

license 'perl';

test_requires 'File::Temp';
test_requires 'Test::More';

repository 'https://github.com/kazuho/p5-text-microtemplate';

WriteAll;

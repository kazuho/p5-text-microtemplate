use inc::Module::Install;

name 'Text-MicroTemplate';
all_from 'lib/Text/MicroTemplate.pm';

license 'perl';

test_requires 'File::Temp';
test_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;

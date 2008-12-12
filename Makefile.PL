use inc::Module::Install;

name 'Text-MicroTemplate';
all_from 'lib/Text/MicroTemplate.pm';

test_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;

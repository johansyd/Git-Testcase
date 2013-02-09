use strict;
use warnings;
use inc::Module::Install;

perl_version '5.008008';
author 'Johan Sydseter <johan.sydseter@startsiden.no>';
name 'Git-Testcase';
abstract 'The module uses git to pull configuration from conf files.';
license 'GNU';

all_from 'lib/Git/Testcase.pm';

requires 'Log::Log4perl';
requires 'Moose';
requires 'FindBin' => '1.47';
test_requires 'Test::More' => '0.62';
test_requires 'Pod::Coverage::CountParents';
test_requires 'Test::Warn';
test_requires 'Test::Differences';
test_requires 'Template';
test_requires 'Parallel::Iterator';
test_requires 'Devel::Cover';

WriteAll;

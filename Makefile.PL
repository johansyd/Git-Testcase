use strict;
use warnings;
use inc::Module::Install;

perl_version '0.01';
author 'Johan Sydseter <johan.sydseter@startsiden.no>';
name 'Git-Testcase';
abstract 'The module uses git to pull configuration from conf files.';
license 'GNU';

all_from 'lib/Git/Testcase.pm';

requires 'Log::Log4perl';
requires 'Moose';

test_requires 'Test::More';

writeAll;

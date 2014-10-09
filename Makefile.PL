# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Output text subroutines for Error::Pure.';
author 'Michal Spacek <skim@cpan.org>';
license 'bsd';
name 'Error-Pure-Output-Text';
readme_from 'Text.pm';
requires 'Exporter' => 0;
requires 'Readonly' => 0;
requires 'perl' => '5.6.2';
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Error-Pure-Output-Text';
resources 'homepage' => 'https://github.com/tupinek/Error-Pure-Output-Text';
resources 'repository' => 'git://github.com/tupinek/Error-Pure-Output-Text';
test_requires 'Cwd' => 0;
test_requires 'English' => 0;
test_requires 'File::Spec::Functions' => 0;
test_requires 'FindBin' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.18';

# Run.
WriteAll();

# Pragmas.
use strict;
use warnings;

# Modules.
use Error::Pure::Output::Text qw(err_bt_pretty_rev);
use Test::More 'tests' => 6;
use Test::NoWarnings;

# Test.
my @errors = (
	{
		'msg' => ['Error.'],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
		],
	},
);
my $right_ret = <<"END";
ERROR: Error.
main  err  ./example.pl  12
END
my $ret = err_bt_pretty_rev(@errors);
is($ret, $right_ret, 'Reverse backtrace print in simple error (scalar mode).');

# Test.
my @right_ret = (
	'ERROR: Error.',
	'main  err  ./example.pl  12',
);
my @ret = err_bt_pretty_rev(@errors);
is_deeply(
	\@ret,
	\@right_ret,
	'Reverse backtrace print in simple error (array mode).'
);

# Test.
@errors = (
	{
		'msg' => ['Error.'],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
			{
				'args' => '',
				'class' => 'main',
				'line' => '10',
				'prog' => './example.pl',
				'sub' => 'eval {...}',	
			},
		],
	},
);
$right_ret = <<"END";
ERROR: Error.
main  err         ./example.pl  12
main  eval {...}  ./example.pl  10
END
$ret = err_bt_pretty_rev(@errors);
is($ret, $right_ret, 'Reverse backtrace print in complicated error.');

# Test.
@errors = (
	{
		'msg' => ['Error 1.'],
		'stack' => [
			{
				'args' => '(\'Error 1.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
			{
				'args' => '',
				'class' => 'main',
				'line' => '10',
				'prog' => './example.pl',
				'sub' => 'eval {...}',	
			},
		],
	},
	{
		'msg' => ['Error 2.'],
		'stack' => [
			{
				'args' => '(\'Error 2.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
			{
				'args' => '',
				'class' => 'main',
				'line' => '10',
				'prog' => './example.pl',
				'sub' => 'eval {...}',	
			},
		],
	},
);
$right_ret = <<"END";
ERROR: Error 2.
main  err         ./example.pl  12
main  eval {...}  ./example.pl  10
ERROR: Error 1.
main  err         ./example.pl  12
main  eval {...}  ./example.pl  10
END
$ret = err_bt_pretty_rev(@errors);
is($ret, $right_ret, 'Reverse backtrace print in more errors.');

# Test.
@errors = (
	{
		'msg' => [
			'Error.',
			'first', 0,
			'second', -1,
			'third', 1,
			'fourth', undef,
		],
		'stack' => [
			{
				'args' => '(\'Error.\')',
				'class' => 'main',
				'line' => '12',
				'prog' => './example.pl',
				'sub' => 'err',	
			},
		],
	},
);
$right_ret = <<"END";
ERROR: Error.
first: 0
second: -1
third: 1
fourth
main  err  ./example.pl  12
END
$ret = err_bt_pretty_rev(@errors);
is($ret, $right_ret, 'Reverse backtrace print in different key=value pairs.');

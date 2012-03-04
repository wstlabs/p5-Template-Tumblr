use ExtUtils::MakeMaker;

WriteMakefile(
    'AUTHOR'  => 'highlinelabs (nobody@null.org)',
    'NAME'		=> 'Template-Tumbler',
    'VERSION_FROM'	=> 'lib/Template/Tumblr.pm',
    'PREREQ_PM'		=> {
		'Template' => 0,
        'HTML::Parser' => 0,
        'Assert::Types' => 0,
        'Log::Inline' => 0,
	},
);



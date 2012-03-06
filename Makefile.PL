use ExtUtils::MakeMaker;

WriteMakefile(
    'AUTHOR'  => 'WST (nobody@null.org)',
    'NAME'		=> 'Template-Tumbler',
    'VERSION_FROM'	=> 'lib/Template/Tumblr.pm',
    'PREREQ_PM'		=> {
		'Template' => 0,
        'HTML::Parser' => 0,
        'Assert::Types' => 0,
        'Log::EZ' => 0,
	},
);



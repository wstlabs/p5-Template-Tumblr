use ExtUtils::MakeMaker;

WriteMakefile(
    'AUTHOR'  => 'WST (nobody@null.org)',
    'NAME'		=> 'Template-Tumbler',
    'VERSION_FROM'	=> 'lib/Template/Tumblr.pm',
    'PREREQ_PM'		=> {
		'Template' => 2.22,
        'HTML::Parser' => 3.68,
        'Assert::Std' => 0.001,
        'Log::EZ' => 0.001,
	},
);



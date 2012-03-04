
Simple demos / de-facto unit tests of the Template::Tumbler parser. 


Usage
=====

Sample commands showing how the various files in the dirs below were 
generated.  Note that if you re-run these commands verbatim, you'll clobber 
those files of course - so you do run these scripts, you might want to 
pipe to different output files, eg 'data2.yaml', 'page2.html', etc.

Simple end-to-end test of the process() method on a Tumblr template, 
acting on a suggested internal DAO structure:

    % perl proc.pl input/theme.tblr input/data.yaml > output/page.htm

Note that you can effectively unit test the process() method by
doing a simple diff on the generated HTML versus captured live HTML
from the ToE tumblr 
  
    % diff -c output/page.htm pages/theoryofeverything.htm > output/diff.txt

If all goes well then the diff should consist strictly of "lint" 
(whitespace, capitalization cruft, etc) as well as that blurb of 
dynamic HTML that the tumblr site slips in a at the bottom.

Intermediate processing steps can be demonstrated as follows: 

To generate a YAML serialization of that DAO structure,

    % perl emit.pl > input/data.yaml

Emit the results of the intermediate 'ovelay_meta' stage (that merges 
scraped 'meta' declarations onto the raw DAO structure, with appropriate
munging for namespaces, special chars, etc):

    % perl meta.pl input/theme.tblr input/data.yaml > output/merged.yaml

Emit the intermediate TT template, showing how Tumblr markup gets
parsed into TT markup, with approriate syntax mods:

    % perl parse.pl -o input/theme.tblr input/data.yaml > output/template.tt

Note that the above commands have been rolled into a simple csh script:
  
    % source make.rc

generating output to the (presumed empty) directory 'output'; when compared to the existing snapshots in 'sample', it serves as a de-facto unt test.








use strict;
use warnings;
use Template::Tumblr::Parser; 
use Getopt::Long;
use Log::EZ;

GetVerbose();

GetOptions('q' => \our $q); # quiet

my $parser = Template::Tumblr::Parser->new;

my $tblr;
{
    local $/;
    $tblr = <>
}
trace "got ".(length $tblr)." bytes.";


my $tmpl = $parser->parse($tblr);
trace "parse'd.";

unless ($q)  {
    print $tmpl
}



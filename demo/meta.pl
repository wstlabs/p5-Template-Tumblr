use strict;
use warnings;
use Template::Tumblr;
use Getopt::Long;
use YAML;
use Carp;

# XXX logging disabled for now 
# use Trace;
sub trace {}
# GetVerbose;

GetOptions('o' => \our $o);
my ($tfile,$vfile) = @ARGV;
confess "need a theme" unless defined $tfile;

my $tumblr = Template::Tumblr->new;
my $vars = YAML::LoadFile($vfile) if $vfile;

my $tblr;
{
    local $/;
    local *IN;
    open(IN,"<$tfile") || confess "can't read $tfile, reason: $!";
    $tblr = <IN>
}
trace "got ".(length $tblr)." bytes.";

my $meta = Template::Tumblr::extract_meta(\$tblr);
trace "meta = ",$meta;

if ($vars)  {
	Template::Tumblr::overlay_meta($vars,$meta);
	print Dump $vars
}






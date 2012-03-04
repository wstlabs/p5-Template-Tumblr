use strict;
use warnings;
use YAML;
use Template::Tumblr;
use Getopt::Long;
use Carp;

# logging disabled for now
# use Trace;
sub trace {}

# GetVerbose;
GetOptions('o' => \our $o);

my ($tfile,$vfile) = @ARGV;
confess "need a theme" unless defined $tfile; 
confess "need a dataset" unless defined $vfile; 

#
# config is empty for now - but is intended to be 'meta', applying
# to -how- the template is processed (rather than to the content of 
# either the theme or the data it acts on). 
#
my $tumblr = Template::Tumblr->new({});
my $vars = YAML::LoadFile($vfile);

my $tblr;
{
	local $/;
	local *IN;
	open(IN,"<$tfile") || confess "can't read $tfile, reason: $!";
	$tblr = <IN>
}
trace "got ".(length $tblr)." bytes.";

#
# tweak as desired: 
# 
#   $vars->{main}->{Title} = 'Beware of the Blog';
#   $vars->{opt}->{ShowPostNotes} = '';
#

my $html = $tumblr->process(\$tblr,$vars);
trace "parse'd.";

if ($o)  {
	print $html
}





#
# grab-bag of simple HTML scraping functions, based on HTML::Parser
#
package Template::Tumblr::Scrape;
use strict;
use warnings;
use HTML::Parser;
use Assert::Std qw(:types);
use Carp;

use base 'Exporter';
our @EXPORT = qw/
	extract_attr
	extract_attr_where
/;


sub extract_attr  {
	my ($html,$tag) = @_;
	confess "need a tag" unless defined $tag;
	extract_attr_where ($html, sub { $_[0] eq $tag })
}

sub extract_attr_where  {
	my ($html,$visit) = @_;
	assert_scalar_ref($html);
	assert_code_ref($visit);
	my @attr;
	my $p = HTML::Parser->new( 
		api_version => 3,
		start_h => [ 
            sub { 
			    push @attr, $_[1] if $visit->(@_) 
		    }, 'tagname,attr' 
        ],
		marked_sections => 1
	);
	$p->parse($$html);
	\@attr
}

1;

__END__


#
# a simple parser for Tumblr templates (basically a wrapper to TT).
# partially functional, but hits most of the bases.
#
package Template::Tumblr; 
use strict;
use warnings;
use Template;
use Template::Tumblr::Parser;
use Template::Tumblr::Scrape;
use Carp;

our $VERSION = '0.001';

sub new {
    my ($proto,$cfg) = @_;
    my $class = ref $proto || $proto;
    bless {
        'PARSER' => Template::Tumblr::Parser->new,
        'TT'     => Template->new 
    }, $class
}

#
# similar in usage to the process method in TT, except: 
#
#  - currently munges $vars hash, by overlaying meta decls onto it. 
#    (in the future this can be disabled by an opts directive).
#
#  - confess on errors (rather than setting error string).
# 
sub process {
    my ($self, $tblr, $vars, $outs) = (shift,shift,shift,shift); 
    my $opts = 
	    @_ == 1 && UNIVERSAL::isa($_[0], 'HASH') ? $_[0] : 
	    @_ % 2 ? { @_, undef } : # avoids warning on odd-numbered hashes 
	    { @_ };
    # (binmode) 
    my $tt = $self->{TT};
    my $meta = extract_meta($tblr);
    overlay_meta($vars,$meta);
    my $tmpl = $self->{PARSER}->parse($$tblr);
    $tt->process( \$tmpl, $vars, $outs, $opts ) 
        || confess "TT error:  ".$tt->error
}

#
# extract tumblr-ized attr pairs from <meta ..> declarations
# for now this means anything where the name attr is of the form 
# "foo:bar" and the content attr is at least present. 
#
sub extract_meta  {
    my $html = shift;
    my $meta = extract_attr($html,'meta');
    return {
        map {
            my $name    = $_->{name};
            my $content = $_->{content};
            defined $name && defined $content && $name =~ /^\S+?:/ ? 
                ( $name => $content ) : ()
        } @$meta 
    }
}

#
# overlays applicable meta declarations onto vars hash,
# selecting appropriate namespace + munging key/val pairs 
# to either match Tumblr syntax, e.g. 
#
#   <meta name="if:Show post notes" content="1"/> 
#
# results in the assignment { ShowPostNotes => 1 } in
# the 'opt' namespace; and in the 'color' namespace, 
# declarations with embedded ' ' or '_' characters are
# made TT safe (by munging these to underscores).
#
sub overlay_meta  {
    my ($vars, $meta) = @_;
    $vars->{opt}   = {} unless $vars->{opt};
    $vars->{color} = {} unless $vars->{color};
    # sort is necessary to avoid non-reproducible behaviors (bugs)
    # which would result if subsequent declarations under matching
    # or case-equivalent declarations were to be processed in 
    # random order each time the template parses.
    for my $name (sort keys %$meta)  {
        my $content = $meta->{$name};
        my ($dec,$val) = $name =~ /^(\w+)\:(.*)$/ ? ($1,$2) :
        confess "malformed meta declaration '$name'";
        $dec = lc($dec);
        if ($dec eq 'if')  {
            $vars->{opt}->{camelcase($val)} = $content
        }
        elsif ($dec eq 'color')  {
            $val =~ s/ /_/g;
            $content =~ s/[\- ]/_/g;
            $vars->{color}->{$val} = $content
        }
        else { } # ignore for now 
    }
}

#
# everybody's favorite naming convention.
#
sub camelcase  {
    my $w = shift;
    confess "need a string" unless defined $w;
    join '', map { ucfirst($_) } split /\s+/, $w
}


1



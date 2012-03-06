#
# an ultra-thin Tumbler-to-TT2 adapter layer. 
#
# this is off the cuff, proof of concept impl; not entirely robust.
# but seems to work as of the mid-2009 specification.
#
# but the basic idea is simple enough:  slippery though the tumblr 
# syntax is, basically every 'block' declaration is interpreted as
# either an "if" switch or a "for" loop; and everything else is just 
# a straightfoward "print this" statement.  in particular:
#
#   - 'block' declarations are usually mappable to IF decls in TT,
#     taking care to mind the appropriate namespace / context.
#
#   - 'block:Posts' decls are different, in that they (1) result
#     in a FOR block rather than an IF/END in TT, and (2) toggle
#     the ctx to 'p' (the iterator elt under the 'posts' namespace).
# 
#   - most everything else - {color:foo}, {if:foo} and flat {foo} tags --
#     results in a 'unary' declaration, ie we simply emit as a TT scalar 
#     under an appropriately munged namespace, per context.
#
# the final caveat is that whitespaces, and certain special chars (-)
# will mess up the TT parsing (unless perhaps escaped properly).
# eventually we'll come up with a proper treatment for these, but 
# for now we just munge these to underscores.
#
# also note that for now we only treat tags of the form
#
#   block:foo   /block:foo   color:foo  if:foo
#
# or flat tags (absent :), because these are the only forms 
# that I'm aware of.
#
package Template::Tumblr::Parser;
use strict;
use warnings;
use Log::EZ;
use Carp;

sub new {
    my $class = shift;
    bless {
        's' => [], 'ctx' => 'main'
    }, $class
}

# main challenge in parsing Tumblr markup is to distinguish it from 
# inline CSS; ultimately this would have to come down to keyword matching.
# our approach for now blindly asssumes that anything with NO embedded 
# spaces, e.g. 
#
#   {foo:bar} 
#
# is tumbler markdown, whereas if there's at least one space inside
# the brackets:
#
#    { foo: bar }
# 
# it's assumed to be a CSS declaration.
# 
sub parse {
my ($self,$text,$info) = @_;
    $text =~ s{\{(
        \/?\w+ | \/?\w+\:\w+
    )\}}{&_handle($self,$1)}gxmse;
    $text
}

sub _handle  {
    my ($self,$tag) = @_;
    trace "tag = [$tag]";
    confess "need a tag" unless defined $tag;
    my ($tt, $s) = ( 'NOTSET', $self->{s} );
    if ( $tag =~ m{\A ([\/]?\w+):([^\n]*) \z}xms)  {
        my ($dec,$val) = (lc($1),$2);
        if ($dec eq 'block')  {
            push @$s, $val;
            if ($val eq 'Posts')  {
                # XXX probably shouldn't allow nested 'Posts' 
                # declarations, but not sure how to handle this
                $tt = "FOREACH p = posts";
                $self->{ctx} = 'p'
            }  else  {
                #
                # munge 'block:If' declarations into 'opt' namspace
                #
                $tt = $val =~ m{\A if([\n]*)$ \z}xmsi ? "IF opt.$1" : 
                # else use ctx as namespace
                "IF $self->{ctx}.$val" 
            }
        }
        elsif ($dec eq '/block')  {
            my $top = @$s ? pop @$s : 
            confess "invalid closing tag $tag:  stack empty";
            confess "block mismatch:  val = $val, s = [$top, @$s]" 
            unless $val eq $top;
            $self->{ctx} = 'main' if $val eq 'Posts';
            $tt = 'END';
        }
        elsif ($dec eq 'color')  {
            $val =~ s{[\- ]}{_}gxms;
            $tt = "color.$val"
        }
        else  {  confess "invalid level-2 tag '$tag'"  }
    }
    elsif ( $tag =~ m{\A ([\-\w]+) \z}xms) {
        $tag =~ s{/\-}{_}gxms; # TT-safe
        $tt = "$self->{ctx}.$tag"
    }
    else {  confess "bad tag [$tag]"  } 
    "[% $tt %]"
}


1



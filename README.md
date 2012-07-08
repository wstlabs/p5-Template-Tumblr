# NAME

Template::Tumbler - a simple TT-based templating engine for Tumbler themes

# SYNOPSIS

See the directory <code>demos</code>, and in particular the <code>README.md</code> there for sample usage.

# DESCRIPTION 
Proof of concept implementation; see the 'demos' dir for sample scripts 
and test inputs / outputs based on the ToE blog:
  
  <http://theoryofeveryting.tumblr.com>

The idea is to provide a simple "shim" layer that maps Tumblr markup
to TT markup, leveraging the latter's many strengths and features. 

Right now the parsing is very simple -- just a few regex subs -- 
but we were able to generate a working prototype very quickily (in about
6 hours of hacking).

More info available in the comments to the main parser class: 

    lib/Template/Tumbler/Parser.pm

# CAVEATS

Basically, this is a just toy implementation, and most likely won't be released to CPAN.  Also, its workings (limited though they are) are tied to the vintage 2009 Tumbler service, and most likely quite a few things have changed since then. 



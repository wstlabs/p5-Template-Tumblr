
Template::Tumbler - a simple TT-based templating engine for Tumbler themes

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

Installation
============

Follows the usual CPAN installation pattern:
  
   perl Makefile.PL
   make test
   make install

Prerequisites
=============
  
  HTML::Parser
  Template-Toolkit
  YAML (for the demos) 
  Log::EZ;
  Assert::Types 
  Carp







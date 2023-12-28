#!F:/Perl/perl/bin/perl.exe

use strict;
use warnings;
use CGI;
use utf8;

my $cgi = CGI->new;
my $search = $cgi->param("search");
my $link = "https://google.com/search?q=$search&tbm=isch";
print $cgi->redirect($link);


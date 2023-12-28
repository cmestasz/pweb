#!F:/Perl/perl/bin/perl.exe

use strict;
use warnings;
use CGI;
use utf8;

my $cgi = CGI->new;
my $link = "https://google.com/search?";
my $search_all = $cgi->param("all");
my $search_exact = $cgi->param("exact");
my $search_none = $cgi->param("none");
if ($search_all) {
    $link = $link."as_q=$search_all&";
}
if ($search_exact) {
    $link = $link."as_epq=\"$search_exact\"&";
}
if ($search_none) {
    $link = $link."as_eq=$search_none&";
}
print $cgi->redirect($link);




#C:/Perl/perl/bin/perl
use strict;
use warnings;
sub invertir {
my $str = $_[0];
my $inv = "";
for (my $i = length($str); $i >= 0; $i--) {
$inv = $inv.substr($str, $i, 1);
}
return $inv;
}
print "Invertido de roma: ";
print invertir("roma");
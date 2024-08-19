#C:/Perl/perl/bin/perl
use strict;
use warnings;
sub promedio {
my $min = 0;
my $max = 0;
my $suma = 0;
for (my $i = 0; $i < @_; $i++) {
$suma += $_[$i];
if ($_[$i] > $_[$max]) {
$max = $i;
}
if ($_[$i] < $_[$min]) {
$min = $i;
}
}
return ($suma + $_[$max] - $_[$min]) / @_;
}
print "Promedio de 12, 15, 17, 14: ";
print promedio(12, 15, 17, 14);
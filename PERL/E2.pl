#C:/Perl/perl/bin/perl
use strict;
use warnings;
sub mayor {
my $mayor = 0;
for (my $i = 1; $i < @_; $i++) {
if ($_[$i] > $_[$mayor]) {
$mayor = $i;
}
}
return $_[$mayor];
}
print "Mayor entre 2, 5, 6, 4, 1, 3: ";
print mayor(2, 5, 6, 4, 1, 3);
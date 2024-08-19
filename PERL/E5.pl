#C:/Perl/perl/bin/perl
use strict;
use warnings;
sub celebridad {
my $candidato = 0;
for (my $i = 0; $i < @_; $i++) {
if ($_[$candidato][$i]) {
$candidato = $i;
}
}
for (my $i = 0; $i < @_; $i++) {
if (!$_[$i][$candidato]) {
return "No hay celebridad";
}
}
return "La celebridad es: $candidato";
}
print <<BLOCK;
Celebridad en la matriz:
1 1 0 0
0 1 0 0
0 1 1 0
1 1 0 1
BLOCK
print celebridad([1, 1, 0, 0], [0, 1, 0, 0], [0, 1, 1, 0], [1, 1, 0, 1]);
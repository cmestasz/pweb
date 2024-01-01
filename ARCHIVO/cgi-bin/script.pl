#!perl\bin\perl.exe

use strict;
use warnings;
use CGI;
use Data::Dumper;

my $cgi = CGI->new;
my $name = $cgi->param("name");
my $period = $cgi->param("period");
my $local = $cgi->param("local");
my $program = $cgi->param("program");
$cgi->charset("UTF-8");

my $idx = 0;
my @results;
open(IN, "<./programas2.csv");
my @lines = <IN>;
for (my $i = 1; $i < @lines; $i++) {
    if ($lines[$i] =~ /(.+?)\|(.+?)\|(?:.+?\|){2}(.+?)\|(?:.+?\|){5}(.+?)\|(?:.+?\|){5}(.+?)\|(.+?)\|/) {
        if ((!$name || $name eq $2) && (!$period || $period eq $3) && (!$local || $local eq $4) && (!$program || $program eq $5)) {
            @results[$idx] = [$1, $2, $3." años", $4, $5, $6];
            # $1.": ".$2.". Licenciada por ".$3." años. Departamento: ".$4.". Programa: ".$5." - ".$6.".";
            $idx++;
        }
    }
}
close(IN);

print($cgi->header("text/html"));
print<<BLOCK;
<!DOCTYPE html>
<html>
    <head>
        <title>Consulta de Universidades Licenciadas</title>
        <link rel="stylesheet" href="../estilo.css" />
    </head>
    <body>
        <div style="padding-block: 5px"></div>
        <a class="minititle" href="../consulta.html">Google</a>
        <div style="padding-block: 5px"></div>
        <div class="content">
            <h1>Programas Encontrados</h1>
            <hr />
            <br />
            <table>
BLOCK
if (@results eq 0) {
    print "<h2>No se han encontrado programas de acuerdo a la búsqueda, revise si los filtros han sido ingresados correctamente.</h2>\n"
} else {
    print<<BLOCK;
                <tr>
                    <th style="width: 75px">Código</th>
                    <th style="width: 300px">Nombre</th>
                    <th style="width: 75px">Periodo</th>
                    <th style="width: 75px">Ciudad</th>
                    <th style="width: 600px">Programa</th>
                    <th style="width: 75px">Tipo</th>
                </tr>
BLOCK
    foreach my $result (@results) {
        print "<tr>\n";
        foreach my $val (@$result) {
            print "<td>".$val." </td>\n";
        }
        print "</tr>\n"
    }
}
print<<BLOCK;
            </table>
        </div>
        <div style="height: 100px;"></div>
    </body>
</html>
BLOCK
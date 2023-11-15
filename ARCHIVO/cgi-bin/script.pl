#!F:/Perl/perl/bin/perl.exe

use strict;
use warnings;
use CGI;
use utf8;

my $cgi = CGI->new;
my $name = $cgi->param("name");
my $period = $cgi->param("period");
my $local = $cgi->param("local");
my $program = $cgi->param("program");

my $idx = 0;
my @results;
open(IN, "<./programas.csv");
my @lines = <IN>;
for (my $i = 0; $i < @lines; $i++) {
    if ($lines[$i] =~ /(.*?)\|(.*?)\|(?:.*?\|){2}(.*?)\|(?:.*?\|){5}(.*?)\|(?:.*?\|){5}(.*?)\|(.*?)\|/) {
        if ((!$name || $name eq $2) && (!$period || $period eq $3) && (!$local || $local eq $4) && (!$program || $program eq $5)) {
            @results[$idx] = $1.": ".$2.". Licenciada por ".$3." años. Departamento: ".$4.". Programa: ".$5." - ".$6.".";
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
        <div class="minititle">Google</div>
        <div style="padding-block: 5px"></div>
        <div class="content">
            <h1>Programas Encontrados</h1>
            <hr />
            <br />
            <ul>
BLOCK
if (@results eq 0) {
    print "<h2>No se han encontrado programas de acuerdo a la búsqueda, revise si los filtros han sido ingresados correctamente.</h2>\n"
} else {
    for (my $i = 0; $i < @results; $i++) {
        print "<li>".$results[$i]." </li>\n";
    }
}
print<<BLOCK;
            </ul>
        </div>
    </body>
</html>
BLOCK
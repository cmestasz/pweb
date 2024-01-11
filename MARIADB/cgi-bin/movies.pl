#!perl/bin/perl.exe

use strict;
use warnings;
use CGI;
use DBI;
use Encode;

my $cgi = CGI->new;
my $user = "user_01";
my $password = "dGF2K4YjRHc7-R]9";
my $dsn = "dbi:mysql:database=pweb;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $user, $password);
my $query = "SELECT * FROM ";

sub print_row {
    print "<tr>\n";
    foreach my $val (@_) {
        my $eval = encode("UTF-8", $val);
        print "<td>$eval</td>\n";
    }
    print "</tr>\n"
}

my $year = $cgi->param("year");
my $score = $cgi->param("score");
my $votes = $cgi->param("votes");
$query = $query."movie WHERE ";
if ($year) {
    $query = $query."Year = $year ";
}
if ($score) {
    if ($year) {
        $query = $query."AND ";
    }
    $query = $query."Score > $score ";
}
if ($votes) {
    if ($year || $score) {
        $query = $query."AND ";
    }
    $query = $query."Votes > $votes ";
}
my $sth = $dbh->prepare($query);
$sth->execute;

$cgi->charset("UTF-8");
print($cgi->header("text/html"));
print<<BLOCK;
<!DOCTYPE html>
<html>
    <head>
        <title>Consulta de Cine</title>
        <link rel="stylesheet" href="../estilo.css" />
    </head>
    <body>
        <div style="height: 15px;"></div>
        <a class="minititle" href="../consulta.html">Google</a>
        <div style="height: 15px;"></div>
        <div class="content">
BLOCK
my @first_row = $sth->fetchrow_array;
if (!@first_row) {
    print<<BLOCK;
            <h1>Películas No Encontradas</h1>
            <hr />
            <br />
            <h2>No se han encontrado resultados de acuerdo a la búsqueda, revise si los datos han sido ingresados correctamente.</h2>
BLOCK
} else {
    print<<BLOCK;
            <h1>Películas Encontradas</h1>
            <hr />
            <br />
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Año</th>
                    <th>Puntaje</th>
                    <th>Votos</th>
                </tr>
BLOCK
    print_row(@first_row);
    while (my @row = $sth->fetchrow_array) {
        print_row(@row);
    }
}
print<<BLOCK;
            </table>
        </div>
    </body>
</html>
BLOCK

$dbh->disconnect;
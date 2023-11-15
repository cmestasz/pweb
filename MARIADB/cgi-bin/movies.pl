#!F:/Perl/perl/bin/perl.exe

use strict;
use warnings;
use CGI;
use DBI;
use utf8;

my $cgi = CGI->new;
my $user = "user01";
my $password = "959869678";
my $dsn = "dbi:mysql:database=pweb;host=127.0.0.1";
my $dbh = DBI->connect($dsn, $user, $password);
my $query = "SELECT * FROM ";

sub print_row {
    print "<li>$_[0]";
        for (my $i = 1; $i < @_; $i++) {
            print " - ".$_[$i];
        }
    print "</li>\n";
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

print($cgi->header("text/html"));
print<<BLOCK;
<!DOCTYPE html>
<html>
    <head>
        <title>Consulta de Cine</title>
        <link rel="stylesheet" href="../estilo.css" />
    </head>
    <body>
        <div style="padding-block: 5px"></div>
        <div class="minititle">Google</div>
        <div style="padding-block: 5px"></div>
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
            <ul>
BLOCK
    print_row(@first_row);
    while (my @row = $sth->fetchrow_array) {
        print_row(@row);
    }
    print "</ul>";
}
print<<BLOCK;
        </div>
    </body>
</html>
BLOCK

$dbh->disconnect;
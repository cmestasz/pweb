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
    print "<h2>$_[0]";
        for (my $i = 1; $i < @_; $i++) {
            print " - ".$_[$i];
        }
    print "</h2>\n";
}

my $id = $cgi->param("id");
$query = $query."actor WHERE ID=$id";
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
            <h1>Actor No Encontrado</h1>
            <hr />
            <br />
            <h2>No se ha encontrado un actor de acuerdo a la búsqueda, revise si el ID ha sido ingresado correctamente.</h2>
BLOCK
} else {
    print<<BLOCK;
            <h1>Actor Encontrado</h1>
            <hr />
            <br />
BLOCK
    print_row(@first_row);
    while (my @row = $sth->fetchrow_array) {
        print_row(@row);
    }
}
print<<BLOCK;
        </div>
    </body>
</html>
BLOCK

$dbh->disconnect;
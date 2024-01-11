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

my $id = $cgi->param("id");
$query = $query."actor WHERE ID=?";
my $sth = $dbh->prepare($query);
$sth->execute($id);

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
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
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
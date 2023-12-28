#!F:/Perl/perl/bin/perl.exe

use strict;
use warnings;
use CGI;
use utf8;

my $cgi = CGI->new;
my $operation = $cgi->param("operation");

sub evaluate {
    my $result = "(".$_[0].")";
    $result =~ s/\s//g;
    while ($result =~ /\(([\d\.]+(?:[\+\-\*\/\%][\d\.]+)+)\)/) {
        my $subresult = subresult($1);
        if ($subresult =~ /^Error:/) {
            return $subresult;
        }
        $result =~ s/\([\d\.]+(?:[\+\-\*\/\%][\d\.]+)+\)/$subresult/;
    }
    if ($result =~ /^\d*\.?\d*?$/) {
        return $result;
    }
    return "Error: Formato no valido";
}

sub subresult {
    my $result = $_[0];
    while ($result =~ /([\d\.]+)([\*\/\%])([\d\.]+)/) {
        my $subresult;
        if ($2 eq "*") {
            $subresult = $1 * $3;
        } elsif ($2 eq "/") {
            if ($3 == 0) {
                return("Error: Division entre 0");
            }
            $subresult = $1 / $3;
        } else {
            if ($3 == 0) {
                return("Error: Modulo entre 0");
            }
            $subresult = $1 % $3;
        }
        $result =~ s/[\d\.]+[\*\/\%][\d\.]+/$subresult/;
    }
    while ($result =~ /([\d\.]+)([\+\-])([\d\.]+)/) {
        my $subresult;
        if ($2 eq "+") {
            $subresult = $1 + $3;
        } elsif ($2 eq "-") {
            $subresult = $1 - $3;
        }
        $result =~ s/[\d\.]+[\+\-][\d\.]+/$subresult/;
    }
    return $result;
}

my $result = evaluate($operation);

print $cgi->header("text/html");
print<<BLOCK;
<!DOCTYPE html>
<html>
    <head>
        <title>Calculadora</title>
        <link rel="stylesheet" href="../css/estilo.css" />
    </head>
    <body>
        <div style="padding-block: 55px"></div>
        <div class="title">
            Google
            <div class="subtitle">Calculadora</div>
        </div>
        <div style="padding-block: 20px"></div>
        <form action="./script.pl" method="get">
            <input type="text" name="operation" value="$result" />
            <div style="padding-block: 15px"></div>
            <input type="submit" value="Calcular" />
        </form>
    </body>
</html>
BLOCK
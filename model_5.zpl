set I := {1..24};
set I0 := {0..24};
set P := {1..5};

param DEMANDAS[I*P] := read "demandas.dat" as "n+";

var X[I*P] integer >= 0; 
var S[I0*P] integer >= 0;
var W[I*P] integer >= 0;
var T[I*P] integer >= 0;
var T2[I*P] binary;

var A integer >= 0; # Stock minimo para factibilidad

minimize fobj: A;

subto stock_max: forall <i> in I: sum <p> in P: S[i, p] <= A;

subto prod_max_i: forall <i> in I: forall <p> in P: X[i, p] <= 120;

subto demandas: forall <i> in I: forall <p> in P: S[i, p] == S[i-1, p] + X[i, p] + T[i,p] - DEMANDAS[i, p];

subto stock_inicial: forall <p> in P: S[0, p] == 0;

subto decenas: forall <i> in I: forall <p> in P: W[i, p] == X[i, p] / 10;

subto prod_max_total: forall <i> in I: sum <p> in P: X[i, p] <= 300;

subto terc_max_total: forall <i> in I: sum <p> in P: T[i, p] <= 200;

subto tercerizacion_minima: forall <i> in I: forall <p> in P: T[i, p] >= 20 * T2[i, p];

subto tercerizacion_maxima: forall <i> in I: forall <p> in P: T[i, p] <= 1000000 * T2[i, p];
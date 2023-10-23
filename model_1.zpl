set I := {1..24};
set I0 := {0..24};
set P := {1..5};

param DEMANDAS[I*P] := read "demandas.dat" as "n+";

var X[I*P] integer >= 0; 
var S[I0*P] integer >= 0;
var W[I*P] integer >= 0;

minimize fobj: sum <p> in P: sum <i> in I: 370 * X[i, p];

subto stock_max: forall <i> in I: sum <p> in P: S[i, p] <= 900;

subto prod_max: forall <i> in I: forall <p> in P: X[i, p] <= 120;

subto demandas: forall <i> in I: forall <p> in P: S[i, p] == S[i-1, p] + X[i, p] - DEMANDAS[i, p];

subto stock_inicial: forall <p> in P: S[0, p] == 0;

subto decenas: forall <i> in I: forall <p> in P: W[i, p] == X[i, p] / 10;
program math;

const MAX = 10;

Type Mat = Array[1..MAX,1..MAX] of Real;
Type Mat2 = Array[1..MAX] of Real;   


var matrice : Mat;
var nbi, i, j : Integer;

BEGIN


	writeln('Taille de la matrice');
	readln(nbi);
	for i := 1 to nbi do
		for j := 1 to nbi do
			begin
				writeln('Valeur de a',i,j);
				readln(matrice[i][j]);
			end;
			
			
	for i := 1 to nbi do
		begin
			for j := 1 to nbi do
				write(matrice[i][j]:2);
			writeln;
		end;


END.

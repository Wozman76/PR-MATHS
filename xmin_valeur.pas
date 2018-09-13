program xmin_valeur;

var Xmin : Real;

BEGIN
	
	Xmin := 1;
	while Xmin / 2 <> 0 do
		Xmin := Xmin / 2;
		
	write('Valeur de Xmin : ');
	writeln(Xmin);


end.

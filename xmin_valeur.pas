program xmin_valeur;

var Xmin : Real;

BEGIN
	///Ce programme permet de determiner le plus petit reel positif pris en compte par le langage.
	
	Xmin := 1;
	
	while Xmin / 2 > 0 do ///Arret de la bloucle lorsque le logiciel considerera Xmin comme etant egal a 0.
		Xmin := Xmin / 2;
		
	write('Valeur de Xmin : ');
	writeln(Xmin);


END.

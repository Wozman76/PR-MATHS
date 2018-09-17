program epsilon;

var epsi : Real;

BEGIN

	///Ordre de grandeur
	epsi := 1.0;
	while 1.0 + epsi / 10 > 1.0 do
		epsi := epsi / 10;
		
	write('Ordre de grandeur de ε : ');
	writeln(epsi);
	
	
	///Valeur plus precise	
	epsi := 1.0;
	while 1.0 + epsi / 2 > 1.0 do
		epsi := epsi / 2;
		
	write('Valeur de ε : ');
	writeln(epsi);

	
END.

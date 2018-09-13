program epsilon;

var epsi : Real;

BEGIN
	epsi := 1.0;
	while 1.0 + epsi / 10 <> 1.0 do
		epsi := epsi / 10;
		
	write('Ordre de grandeur de ε : ');
	writeln(epsi);
		
	epsi := 1.0;
	while 1.0 + epsi / 2 <> 1.0 do
		epsi := epsi / 2;
		
	write('Valeur de ε : ');
	writeln(epsi);

	
end.

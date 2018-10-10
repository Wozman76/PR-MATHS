program ProjetMath;

{Ce programme permet de résoudre un système d'équation à l'aide de la décomposition LU}
uses crt;

const MAX=30;
const EPSILON=1E-1000;

Type Matrice=Array[1..MAX,1..MAX] of Real;
Type Vecteur=Array[1..MAX] of Real;

procedure LireMatrice(var A:Matrice; n:integer);
{Cette procédure permet de rentrer les coefficients des équations}
{ Cette procédure permet donc de rentrer la matrice A}
	var i,j:integer;
begin
	for i:=1 to n do
	begin
		clrscr;
		writeln('Coefficients de l''equation ',i,' (les inconnus toujours dans le meme ordre): ');
		For j:=1 to n do read(A[i,j]);
	end;
end;



procedure EcrireMatriceInverse(X:Matrice; n:integer);
{ Cette procédure permet d'écrire la résolution du système}
{Elle est donc appelée à la fin du programme, quand la résolution a été effectuée}
	var i,j:integer;
begin
	clrscr;
	writeln('la matrice inverse de A est:');
	writeln;writeln;
	for i:=1 to n do 
		begin
		for j:=1 to n do write(X[i,j]:15:15,'  ');
		writeln(' ');
		end;
end;


procedure FormerMatrice(var A:Matrice; var n:integer);
{Cette procédure nous demande de donner le nombre d'équations du systeme, soit l'ordre de la matrice}
{Elle appelle ensuite les procédures permettant de rentrer les équations à résoudre et leurs solutions}
begin
	repeat 
		write('Ordre du systeme (1 a ',MAX,') : ');
		read(n); 
		writeln();
	until (n>0) and (n<=MAX);
	
	writeln('Donnez les coefficients de A:');
	LireMatrice(A,n);
end;

procedure FormerMatriceTriangulaire(A:Matrice; B:Vecteur; n:integer; var U:Matrice; var B2:Vecteur);
	var i,j,k:integer;
		somme : real;
		ll,l:matrice;  {ll est la matrice inverse de l}
begin
	i:=1;
	repeat
		for j:=i to n do
		begin
		{ici,cette boucle permet de calculer U}
		{On commence par calculer le haut de la matrice}
		{car les lignes supérieures sont nécessaires pour calculer les lignes suivantes de la matrice}
			somme:=a[i,j];
			for k :=1 to i-1 do somme:=somme-a[i,k]*a[k,j];
			
			a[i,j]:=somme;
		end;

		begin
		{dans cette boucle, on calcule les coeficiens de L}
		{De la même façon on calcule les lignes supérieures en premier}
			for j :=i+1 to n do
			begin
				somme:=a[j,i];
				for k:=1 to i-1 do somme := somme-a[j,k]*a[k,i];
				a[j,i]:=somme/a[i,i];
			end;
		end;
		i:=i+1;
	until (i>n);
	
	{création de L}
	for i:=1 to n do
	for j :=1 to n do
	begin
		l[i,j] := 0;
	end;
	
	for i:=1 to n do
	begin
		for j:=1 to i-1 do
		l[i,j]:=a[i,j];
	end;
			
	for i:=1 to n do
	for j:=1 to n do
	begin
		if j=i then
		l[i,j]:=1;
	end;
	
	{création de U}
	
	for i:=1 to n do
		begin
			for j:=1 to i-1 do 
			u[i,j]:=0;
			for j:=i to n do
			u[i,j]:=a[i,j];
		end;
		
			{On initialise la matrice inverse L'}
		for i:=1 to n do
		for j :=1 to n do
		begin
			ll[i,j] := 0;
		end;
		
		{Avant de continuer, il est nécessaire de préciser que l'inverse d'une matrice triangulaire inférieure est elle aussi triangulaire inférieure}
		{On le voit en posant le calcul matriciel entre deux matrice triangulaire inférieure}		
				
		{Les coefficients sur la diagonale sont simples à calculer et sont nécessaires pour la suite de l'algorythme}
		{On a ll[i,j]= 1/l[i,j], cela se voit facilement quand on pose le calcul matriciel}	
		for i:=1 to n do
		for j:=1 to n do
		begin
			if j=i then
			ll[i,j]:=1/l[i,j];
		end;

		{Ensuite, c'est la partie la plus complexe de cet algorythme, il faut résoudre un système d'équation}
		{Pour calculer les coefficients de chaque diagonale, on a besoin des coefficients de la diagonale d'au dessus}
		{Donc pour résoudre le système, on traite diagonale après diagonale}
		for i:=2 to n do
		for j:=1 to i-1 do
		begin
			for k:=j to  i-1 do
			begin
				somme:=l[i,k]*ll[k,j];
				ll[i,j] := ll[i,j]+((-1)*somme)/l[i,i];
            end;
		end;
			
		{Ensuite, on crée le vecteur B2, égal à B*L'}
		for i:=1 to n do
		{On initialise le vecteur}
		begin
			B2[i]:=0;
		end;
		
		for i:=1 to n do
		for j:= 1 to n do
		{On calcul le vecteur en effectuant le produit matriciel}
		B2[i]:=B2[i]+ll[i,j]*B[j];

end;

procedure MethodeDeGauss(var U:Matrice; B2:Vecteur;z,n:integer;var Ain:Matrice);
var i,k:integer;
{A ce stade, on a UX=B2}
{Grâce au produit UX, on obtient un système triangulaire égal au vecteur B2}
{On a donc un système simple à résoudre en remontant dans les équations}
begin
	clrscr; writeln('Resolution de U.X=B'' (Gauss)');
	writeln('Resolution en cours...');
	{On commence par calculer le dernier chiffre du vecteur X (la solution)}
	{En effet c'est le bas de la pyramide, c'est donc la solution la plus simple à calculer}
	{De plus, elle est nécessaire pour calculer les solutions suivantes}
	Ain[n,z]:=B2[n]/U[n,n];
	for i:=n-1 downto 1 do
	{Ensuite on remonte dans la pyramide et on cacule solution par solution}
	{n effet, toutes les solutions calculées deviendront nécessaires pour la suite du calcul} 
	begin
	Ain[i,z]:=B2[i];
		for k:=i+1 to n do
		begin
			Ain[i,z]:=(Ain[i,z]-U[i,k]*Ain[k,z]);
		end;
		Ain[i,z]:=Ain[i,z]/U[i,i];
	end;
	{Et une fois les calculs terminés, on affiche la solution finale}

end;

var A,Ain,U:Matrice; 
	B,B2:Vecteur; 
	n,y,z:integer;
begin
{Et enfin le programme principal}
{On rentre donc tout d'abord les coefficients et les solutions de l'équation}
	FormerMatrice(A,n);
{Ensuite, à partir de l'équation AX=B rentrée, on va arriver au système UX=B2}
{Avec A=LU, L'=1/L, et B2=BL'}
for z:=1 to n do
	begin
	for y:=1 to n do B[y]:=0;
	B[z]:=1;
	FormerMatriceTriangulaire(A,B,n,U,B2);
{Ensuite on termine les calculs en effectuant la méthode de Gauss et enfin on affiche le résultat}
	MethodeDeGauss(U,B2,z,n,Ain);
	
	end;
EcrireMatriceInverse(Ain,n);
end.

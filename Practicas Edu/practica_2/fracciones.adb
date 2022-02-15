with Ada.Text_Io;use Ada.Text_Io;

package body Fracciones is




--CMD
function mcd(X: Fraccion) return Integer is

	var1,var2,varAux,res: Integer;

	begin
		var1 := abs X.Num; --Lo ponemos en valor absoluto para poder operar
		var2 := X.Den;
		res := 1;--Le damos un valor cualquiera para que entre en el bucle sin dar error

		if (var1 < var2) then --Hacemos este if para dividir el mas grade entre el mas pequeño

			varAux := var1;
			var1 := var2;
			var2 := varAux;
		end if;

		while res /= 0 loop

			res := var1 mod var2;
			var1 := var2;
			var2 := res;
		end loop;
	return var1;
end mcd;




--REDUCIR
function simpli(X: Fraccion) return Fraccion is

	min: Integer;
	fracAux: Fraccion;

	begin
		if(X.Num = 0) then

			return X;
		else
			min := mcd(X);

			fracAux.Num := X.Num/min;--Obtenemos la fraccion simplificada
			fracAux.Den := X.Den/min;
			return fracAux;
		end if;
end simpli;




--CREAR
function "/" (X, Y: Integer) return Fraccion is

	fracAux: Fraccion;

	begin
		if (Y < 0) then --Comprueba que el denominador no es negativo

			fracAux.Num := X * (-1);--Si es negativo cambiamos de signo a ambos 
			fracAux.Den := Y * (-1);--para mantener el signo de la fraccion
		
		else

			fracAux.Num := X;
			fracAux.Den := Y;
		end if;
	return fracAux;
end "/";




--SUMA
function "+" (X, Y: Fraccion) return Fraccion is
	
	fracAux: Fraccion;
	
	begin
	
		fracAux.Num := X.Num*Y.Den + Y.Num*X.Den;--Realizamos la suma
		fracAux.Den := X.Den*Y.Den;

	return simpli(fracAux);
end "+";




--NUMERADOR
function Numerador (F: Fraccion) return Integer is
	
	begin

	return simpli(F).Num;--Devolvemos el numerador simplificado
end Numerador;




--DENOMINADOR
function Denominador(F: Fraccion) return Positive is

	begin

	return simpli(F).Den;--Devolvemos el denominador simplificado
end Denominador;




--CAMBIO SIGNO
function "-" (X: Fraccion) return Fraccion is

	fracAux: Fraccion;

	begin
	
		fracAux.Num := X.Num * (-1);--Cambiamos de signo a la fraccion

	return simpli(fracAux);
end "-";




--RESTA
function "-" (X, Y: Fraccion) return Fraccion is
	
	fracAux: Fraccion;
	
	begin
	
		fracAux.Num := X.Num*Y.Den - Y.Num*X.Den;--Restamos la fracciones
		fracAux.Den := X.Den*Y.Den;

	return simpli(fracAux);
end "-";




--MULTIPLICAR
function "*" (X, Y: Fraccion) return Fraccion is
	
	fracAux: Fraccion;
	
	begin
	
		fracAux.Num := X.Num*Y.Num;--Multiplicamos las fracciones
		fracAux.Den := X.Den*Y.Den;

	return simpli(fracAux);
end "*";




--DIVIDIR
function "/" (X, Y: Fraccion) return Fraccion is
	
	den,num: Integer;
	fracAux: Fraccion;
	
	begin
	
		num := X.Num*Y.Den;
		den := X.Den*Y.Num;
	
		if (den < 0) then--Comprobamos si el Denominador al hacer la division es negativo

			fracAux.Den := den * (-1);
			fracAux.Num := num * (-1);

		else
		
			fracAux.Den := den;
			fracAux.Num := num;
		end if;

	return simpli(fracAux);
end "/";




--COMPARAR
function "=" (X, Y: Fraccion) return Boolean is

	igual: Boolean;
	fracAux1,fracAux2: Fraccion;
	begin
		fracAux1 := simpli(X);
		fracAux2 := simpli(Y);
		
		if (fracAux1.Num = fracAux2.Num) then
		
			if (fracAux1.Den = fracAux2.Den) then

				igual := True; --Si ambos numeradores y denominadores coinciden
						--podemos decir que tienen el mismo valor
			else 

				igual := False;	
			end if;
		else 
		
			igual := False;
		end if;
	return igual;
end "=";




--METER NUEVA FRACCION
procedure Leer (F: out Fraccion) is 

	num,den: Integer;

	package Comp_Es is new Ada.Text_Io.Integer_Io(Integer);

	begin

		Put("Escribe un numerador ---->");
		Comp_Es.Get(num);--Obtenemos el numerador
		Put("Escribe un denominador -->");
		Comp_Es.Get(den);--Obtenemos el denominador

		while den = 0 loop--Comprobamos que el denominador no sea 0 
				  --ya que seria una indeterminadion
			Put_Line("El denominador no puede ser 0");
			New_Line;
			Put("Escribe un denominador -->");
			Comp_Es.Get(den);--Obtenemos un nuevo denominador
		end loop;

		F.Num := num;
		F.Den := den;

		F := simpli(F);
end Leer;




--MOSTRAR LA FRACCION
procedure Escribir (F: Fraccion) is

	begin
		
		Put(Integer'image(F.Num));--Mostramos el numerador
		Put("/");
		Put_Line(Integer'image(F.Den));--Mostramos el denominador
end Escribir;
		
end fracciones;


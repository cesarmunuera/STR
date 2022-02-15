with Ada.Text_Io, Fracciones;
use Ada.Text_Io, Fracciones;

procedure Prueba is

	package Integer_Es is new Integer_Io (Integer);
	use Integer_Es;
	Practica_no_Apta: exception;

	procedure Error is

		begin

			raise Practica_no_Apta;
		end Error;
	A: Fraccion := 2/3;
	B: Fraccion := -9/18;
	P: Fraccion;

	begin

	if Numerador (B) /= -1 or Denominador (B) /= 2 then

		raise Constraint_Error;
	end if;

	if B /= 1/(-2) then Error; end if;
	if A+B /= 1/6 then Error; end if;
	if -A /= -2/3 then Error; end if;
	if A-B /= 7/6 then Error; end if;
	if A*B /= -1/3 then Error; end if;
	if A/B /= -4/3 then Error; end if;
	if A-B /= 7/6 then Error; end if;

	P := 1/1;
	for I in 1..10 loop

		P := P*B;
	end loop;
	if P /= 1/1024 then Error; end if;
	Put_Line ("Práctica␣apta");
	exception 
	
	when Practica_no_Apta =>
		Put_Line ("Práctica␣no␣apta.");
	when Constraint_Error =>
		Put_Line ("Práctica␣no␣apta:");
		Put_Line ("Las␣fracciones␣tienen␣que␣representarse␣mediante");
		Put_Line ("fracciones␣irreductibles.");
		Put_Line ("Es␣necesario␣reducir␣las␣fracciones.");

end Prueba;

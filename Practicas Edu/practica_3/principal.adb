with Ada.Text_Io, Colas;
use Ada.Text_Io;

procedure Principal is 

	package Colas_de_Integer is new Colas (Integer);
	use Colas_de_Integer;
	Practica_no_Apta: exception;

	C1,C2,C3: Cola;
	E: Integer;

	begin

		for I in 1..10 loop
			Poner(I,C1);
		end loop;

		for I in 11..20 loop
			Poner(I,C2);
		end loop;

		if C1 /= C1 then raise Practica_no_Apta; end if;
		if C1 = C2 then raise Practica_no_Apta; end if;

		Poner (1, C3); Copiar (C2, C3);
		if C2 /= C3 then raise Practica_no_Apta; end if;

		while not Esta_Vacia (C3) loop
			Quitar (E, C3); Poner (E, C1);
		end loop;

		while not Esta_Vacia (C2) loop
			Quitar(E, C2);
		end loop;

		for I in 1..20 loop
			Poner(I, C2);
		end loop;

		if C1 /= C2 then raise Practica_no_Apta; end if;

		for I in 1..1e7 loop
			begin
				Poner (1,C1); Quitar(E,C1);
			exception
				when Storage_Error =>
					Put_Line ("Práctica␣no␣apta:");
					Put_Line ("La␣función␣Quitar␣no␣libera␣memoria.");
			end;
		end loop;
		Put_Line ("Practica␣apta.");
		exception
			when Practica_no_Apta =>
				Put_Line ("Práctica␣no␣apta:");
				Put_Line ("Alguna␣operación␣no␣está␣bien␣implementada.");
			when Storage_Error =>
				Put_Line ("Práctica␣no␣apta:");
				Put_Line ("Posible␣recursión␣infinita.");
end Principal;





























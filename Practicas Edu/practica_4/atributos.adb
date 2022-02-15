with Ada.Text_Io; use Ada.Text_Io;

procedure atributos is
	package Ent_Es is new Ada.Text_Io.Integer_Io(Integer);
	package Float_Es is new Ada.Text_Io.Float_Io(Float);

begin
	New_Line;
	put ("Numero entero mas pequenyo: ");
	Ent_Es.Put (Integer'first);

	New_Line;
	Put ("Numero entero mas grande: ");
	Ent_Es.Put (Integer'last);

	New_Line;
	Put("Numero natural mas pequenyo: ");
	Ent_Es.Put (Natural'first);

	New_Line;
	Put("Numero positivo mas pequenyo: ");
	Ent_Es.Put (Positive'first);

	New_Line;
	Put("Numero de digitos significativos de numeros reales: ");	
	Ent_ES.Put (Float'Digits);

end atributos;

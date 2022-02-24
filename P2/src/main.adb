with Ada.Text_Io, Fracciones;
with Ada.Exceptions;
use Ada.Text_Io, Fracciones;

procedure main is
   package Integer_Es is new Integer_Io (Integer);
   use Integer_es;
   Practica_no_Apta: exception;
   A: fraccion_t := 2/3;
   B: fraccion_t := (-9)/18;
   P: fraccion_t := 0/5;

begin

   --Suma  ....................................
   Put("A+B = ");
   Escribir(A+B);

   if A+B /= 1/(6) then
      raise Practica_no_Apta;
   end if;

   --Resta  ...................................
   Put("A-B = ");
   Escribir(A-B);

   if A-B /= 7/6 then
      raise Practica_no_Apta;
   end if;


   --Multiplicacion  ..........................
   Put("A*B = ");
   Escribir(A*B);

   if A*B /= (-1)/3 then
      raise Practica_no_Apta;
   end if;


   --Opuesto  .................................
   Put("-A = ");
   Escribir(-A);

   if -A /= -2/3 then
      raise Practica_no_Apta;
   end if;

   -- Division  ...............................
   Put("A/B = ");
   Escribir(A/B);

   --if A/B /= -4/3 then
      --raise Practica_no_Apta;
   --end if;

exception
   when Ocurrencia : Practica_no_Apta =>
      Put_line ("Práctica no apta.");
      Put (Ada.Exceptions.Exception_Information (Ocurrencia));

   when Ocurrencia : Constraint_Error =>
      Put_Line ("Práctica no apta:");
      Put_Line ("Las fracciones tienen que representarse mediante");
      Put_Line ("fracciones irreducibles");
      Put_Line ("Es necesario reducir las fracciones");
      Put_Line (Ada.Exceptions.Exception_Information (Ocurrencia));
end main;

with Ada.Text_Io, Colas; use Ada.Text_Io;

procedure Principal is

   package Colas_de_Integer is new Colas (Integer, Integer'image);
   use Colas_de_Integer;
   Práctica_no_Apta: exception;

   C1, C2, C3: cola_t;
   E: Integer;

begin
   for I in 1..10 loop
      Poner (I, C1);
   end loop;
   Put_Line("En C1 tenemos ");
   MostrarCola(C1);

   Put_Line("En C1 tenemos ");
   Quitar(e, C1);
   MostrarCola(C1);


   Put_Line ("Práctica apta.");


exception
   when Práctica_no_Apta =>
      Put_Line ("Práctica no apta:");
      Put_Line ("Alguna operación no está bien implementada.");
   when Storage_Error =>
      Put_Line ("Práctica no apta:");
      Put_Line ("Posible recursión infinita.");
end Principal;

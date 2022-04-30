with Ada.Text_Io, Plan, Proc;
use Ada.Text_Io, Plan, Proc;

procedure main is
   Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
   Tiempos: array_Tiempos_t (Procedimientos'Range);

begin

   Medir (Procedimientos, Tiempos);
   Put_Line("Vamos a ver los tiempos:");
   Put_Line("El tiempo de P1 es " & Tiempos(1)'Image);
   Put_Line("El tiempo de P2 es " & Tiempos(2)'Image);
   Put_Line("El tiempo de P3 es " & Tiempos(3)'Image);
   Put_Line("El tiempo de P4 es " & Tiempos(4)'Image);


end main;

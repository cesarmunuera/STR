with Ada.Text_Io, Plan, Proc;
use Ada.Text_Io, Plan, Proc;

procedure main2 is
   Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
   Tiempos: array_Tiempos_t (Procedimientos'Range);

begin

   Medir (Procedimientos, Tiempos);
   Put_line ("+--------------------------+");
   Put_Line ("| Procedimiento  T.Computo |");
   Put_line ("|--------------------------|");
   for i in Tiempos'Range loop
      Put ("|    ");
      Put (i'Image);
      Put ("            ");
      Put (Tiempos(i)'Image);
      Put ("    |");
      New_Line;
   end loop;
   Put_line ("+--------------------------+");

end main2;

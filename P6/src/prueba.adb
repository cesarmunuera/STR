with Ada.Text_Io, Plan, Proc;
use Ada.Text_Io, Plan, Proc;

procedure prueba is
   Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
   Tiempos: array_Tiempos_t (Procedimientos'Range);

begin

   Put_Line("Hola buenas");

   --Creamos punteros a tareas
    --ptr_Proc1: ref_Procedimiento_t := P1'Access;
    --ptr_Proc2: ref_Procedimiento_t := P2'Access;
    --ptr_Proc3: ref_Procedimiento_t := P3'Access;
    --ptr_Proc4: ref_Procedimiento_t := P3'Access;

   --Se los pasamos al array
    --Procedimientos[1] := ptr_Proc1;
    --Procedimientos[2] := ptr_Proc2;
    --Procedimientos[3] := ptr_Proc3;
    --Procedimientos[4] := ptr_Proc4;


   --Medir (Procedimientos, Tiempos);
   Put_line ("+--------------------------+");
   Put_Line ("| Procedimiento T.computo |");
   Put_line ("|--------------------------|");
   for I in Tiempos'Range loop
      Put ("| ");Put (I, Width=>13); Put (" ");
      Put (Tiempos(I), Width=> 9); Put (" |");
      New_Line;
   end loop;
   Put_line ("+--------------------------+");

end prueba;

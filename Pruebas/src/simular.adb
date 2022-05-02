with Ada.Text_Io, Plan;
use Ada.Text_Io, Plan;

procedure Simular is
   type ref_Procedimiento_t is access procedure;

begin

   task type Tarea_t (Nombre : Natural;
                      T : Natural;
                      D : Natural;
                      C : Natural;
                      P : Natural;
                      Codigo_Ciclico: ref_Procedimiento) is
      pragma Priority (P);
   end Tarea_t;
   Tarea1: Tarea_t (1, 2400, 600, ?, ?, P1'Access);
   Tarea2: Tarea_t (2, 3200, 1200, ?, ?, P2'Access);
   Tarea3: Tarea_t (3, 3600, 2000, ?, ?, P3'Access);
   Tarea4: Tarea_t (4, 4000, 3200, ?, ?, P4'Access);

end main;

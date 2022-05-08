with Ada.Text_Io, Plan, Proc, Ada.Calendar;
use Ada.Text_Io, Plan, Proc, Ada.Calendar;

procedure main is
   type ref_Procedimiento_t is access procedure;

   task type Tarea_t (Nombre : Natural;
                      T : Natural;
                      D : Natural;
                      C : Natural;
                      P : Natural;
                      Codigo_Ciclico : ref_Procedimiento_t) is
      pragma Priority (P);
   end Tarea_t;

   stop : Boolean;
   task body Tarea_t is
      tcomienzo, tfin : Time;
      tiempo : Float;
   begin
      stop := false;

      while (not stop) loop
         tcomienzo := Clock;
         Tarea_t.Codigo_Ciclico.all;
         tfin := Clock;
         --Tomamos tiempos de referencia cuando mandamos a ejecutar un proceso

         --Ahora checkeamos si los deadline se cumplen
         tiempo := Float(Seconds(tfin)) - Float(Seconds(tcomienzo));
         if tiempo > Float(Tarea_t.D) then
            Put_Line("La tarea no es planificable!");
         end if;

      end loop;

   end Tarea_t;

   Tarea1: Tarea_t (1, 2400, 600, 410, 4, P1'Access);
   Tarea2: Tarea_t (2, 3200, 1200, 609, 3, P2'Access);
   Tarea3: Tarea_t (3, 3600, 2000, 809, 2, P3'Access);
   Tarea4: Tarea_t (4, 4000, 3200, 813, 1, P4'Access);

begin

   Put_Line("La tarea padre acaba de comenzar");

   delay 50.0;
   stop := true;

   Put_Line("Terminamos la ejecucion de 50s");

end main;

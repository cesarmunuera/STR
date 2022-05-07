with Ada.Text_Io, Plan;
use Ada.Text_Io, Plan;

procedure main is
   package Integer_Es is new Integer_Io (Integer);
   use Integer_Es;
   Tareas: array_reg_Planificacion_t := (
                                         -- -------------------------------------------------
                                         -- Tarea T D C P R Planificable
                                         -- -------------------------------------------------
                                           ( 1, 2400, 600, 3, 1, 0, False ),
                                         ( 2, 3200, 1200, 3, 1, 0, False ),
                                         ( 3, 3600, 2000, 3, 1, 0, False ),
                                         ( 4, 4000, 3200, 4, 1, 0, False )
                                         -- -------------------------------------------------
                                        );
begin
   PuntoFinal (Tareas);

end main;

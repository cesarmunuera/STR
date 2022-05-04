package plan is
   type ref_Procedimiento_t is access procedure;
   type array_ref_Procedimiento_t is array (Positive range <>) of ref_Procedimiento_t;
   type array_Tiempos_t is array (Positive range <>) of Natural;

   procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos : out array_Tiempos_t);

   type reg_Planificacion_t is record
      Nombre : Positive; -- N�mero de la tarea
      T : Natural;       -- Per�odo
      D : Natural;       -- Deadline
      C : Natural;       -- Tiempo de c�mputo
      P : Positive;      -- Prioridad
      R : Natural;       -- Tiempo de respuesta
      Planificable : Boolean;
   end record;
   type array_reg_Planificacion_t is array (Positive range <>) of reg_Planificacion_t;
   type pVector_t is access array_reg_Planificacion_t;

   procedure Planificar (Tareas: in out array_reg_Planificacion_t);

end plan;

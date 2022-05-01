with Ada.Text_IO; use Ada.Text_IO;
with Proc, Ada.Calendar;
use Proc, Ada.Calendar;

package body plan is

   procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos : out array_Tiempos_t) is
      t1, t2 ,t3, t4 : Float;
      t1fin, t2fin, t3fin, t4fin: Time;
      tcomienzo1, tcomienzo2, tcomienzo3, tcomienzo4 : Time;

   begin

      --Medimos el tiempo del procedimiento 1
      tcomienzo1 := Clock;
      Procedimientos(1).all;
      t1fin := Clock;
      t1 := Float(Seconds(t1fin)) - Float(Seconds(tcomienzo1));

      --Medimos el tiempo del procedimiento 2
      tcomienzo2 := Clock;
      Procedimientos(2).all;
      t2fin := Clock;
      t2 := Float(Seconds(t2fin)) - Float(Seconds(tcomienzo2));

      --Medimos el tiempo del procedimiento 3
      tcomienzo3 := Clock;
      Procedimientos(3).all;
      t3fin := Clock;
      t3 := Float(Seconds(t3fin)) - Float(Seconds(tcomienzo3));

      --Medimos el tiempo del procedimiento 4
      tcomienzo4 := Clock;
      Procedimientos(4).all;
      t4fin := Clock;
      t4 := Float(Seconds(t4fin)) - Float(Seconds(tcomienzo4));

      --Rellenamos el array de tiempo
      Tiempos(1) := Integer(t1*1000.00);
      Tiempos(2) := Integer(t2*1000.00);
      Tiempos(3) := Integer(t3*1000.00);
      Tiempos(4) := Integer(t4*1000.00);
   end Medir;




   --En este metodo calculamos los valores de cada tarea que no se proporcionan al crearla,
   --es decir, calculamos su prioridad, su tiempo de respuesta y si es planificable o no.
   procedure Planificar (Tareas : in out array_reg_Planificacion_t) is
      vec : pArray_t;
      valor, posicion, contador: Integer;
      tareas_aux : pVector_t;
      condicion : Boolean;

   begin
      -- +++++++++++++++++++++++++++++ CALCULO DE PRIORIDADES ++++++++++++++++++++++++++++
      contador := 2;
      vec := new array_t (1..4);
      tareas_aux := new array_reg_Planificacion_t (1..4);

      --Primero rellenamos un array provisional
      for i in Tareas'Range loop
         vec(i).Valor := Tareas(i).D;
         vec(i).Posicion := i;
      end loop;

      --Ahora lo ordenamos
      for j in vec'Range loop
         for i in 1..3 loop
            --Put_Line("Estamos en la iteracion " & i'Image);
            if vec(i).Valor < vec(contador).Valor then
               --Put_Line("Es menor!");
               valor := vec(i).Valor;
               posicion := vec(i).Posicion;
               --Si el deadline del siguiente es mayor, intercambiamos posiciones
               vec(i).Valor := vec(i+1).Valor;
               vec(i).Posicion := vec(i+1).Posicion;
               --Actualizamos el siguiente
               vec(i+1).Valor := valor;
               vec(i+1).Posicion := posicion;
            end if;
               contador := contador + 1;
         end loop;
         --Lo repetimos tantas veces como posiciones de array para hacer tantas pasadas
         --2 veces, para poder mover todos los numeros correctamente
         contador := 2;
      end loop;

      --Finalmente, asignamos las prioridades. Bucle en reverse para asignacion correcta
      --de prioridades segun especificaciones
      for i in reverse vec'Range loop
         Tareas(vec(i).Posicion).P := i;
      end loop;

      --Ordenamos el array de las tareas, para tener a las de mayor prioridad las primeras
      for i in  Tareas'Range loop
         tareas_aux(i) := Tareas(vec(i).Posicion);
      end loop;
      for i in  Tareas'Range loop
         Tareas(i) := tareas_aux(i);
      end loop;



      -- ++++++++++++++++++++++++ CALCULO DE TIEMPO DE RESPUESTA ++++++++++++++++++++++++
      condicion := True;
      Tareas(Tareas'Last).R := Tareas(Tareas'Last).C;
      -- 24/43 s04


      -- ++++++++++++++++++++++++++ CHEQUEO DE PLANIFICABILIDAD ++++++++++++++++++++++++
      for i in Tareas'Range loop
         if (Tareas(i).R < Tareas(i).D or Tareas(i).R = Tareas(i).D) then
            Tareas(i).Planificable := True;
         else
            Tareas(i).Planificable := False;
         end if;
      end loop;




   end Planificar;
end plan;

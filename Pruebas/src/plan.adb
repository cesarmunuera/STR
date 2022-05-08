with Ada.Text_IO; use Ada.Text_IO;
with Proc, Ada.Calendar;
use Proc, Ada.Calendar;

package body plan is

   --Medotod al que pasamos una serie de procedimientos, y cuenta el tiempo que tarda en ejecutarse
   --cada uno de ellos.
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
      valor, posicion: Integer;
      tareas_aux : pVector_t;

      condicion : Boolean;
      acuAux1, acuAux2, Wn: Integer;

      type array_reg is record
         Valor : Integer;
         Posicion : Integer;
      end record;

      type array_t is array (Integer range <>) of array_reg;
      type pArray_t is access array_t;
      vec : pArray_t;

   begin
      -- +++++++++++++++++++++++++++++ CALCULO DE PRIORIDADES ++++++++++++++++++++++++++++
      vec := new array_t (Tareas'First..Tareas'Last);
      tareas_aux := new array_reg_Planificacion_t (Tareas'First..Tareas'Last);

      --Primero rellenamos un array provisional
      for i in Tareas'Range loop
         vec(i).Valor := Tareas(i).D;
         vec(i).Posicion := i;
      end loop;

      --Ahora lo ordenamos
      for j in vec'Range loop
         for i in vec'First..vec'Last-1 loop
            --Put_Line("Estamos en la iteracion " & i'Image);
            if vec(i).Valor < vec(i+1).Valor then
               valor := vec(i).Valor;
               posicion := vec(i).Posicion;
               --Si el deadline del siguiente es mayor, intercambiamos posiciones
               vec(i).Valor := vec(i+1).Valor;
               vec(i).Posicion := vec(i+1).Posicion;
               --Actualizamos el siguiente
               vec(i+1).Valor := valor;
               vec(i+1).Posicion := posicion;
            end if;
         end loop;
         --Lo repetimos tantas veces como posiciones de array para hacer tantas pasadas
         --2 veces, para poder mover todos los numeros correctamente
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
      acuAux1 := Tareas(Tareas'Last).C;
      Wn := 0;

      for i in reverse Tareas'First..Tareas'Last-1 loop

         acuAux1 := acuAux1 + Tareas(i).C;
         acuAux2 := acuAux1;

         while condicion loop

            for j in i+1..Tareas'Last loop
               Wn := Wn + Integer(Float'ceiling(Float(acuAux2) / Float(Tareas(j).T))) * Tareas(j).C;
            end loop;
            Wn := Wn + Tareas(i).C;

            if (Wn = acuAux2) then
               condicion := False;
               Tareas(i).R := Wn;
               Wn := 0;
            else
               acuAux2 := Wn;
               Wn := 0;
            end if;

         end loop;
         condicion := True;

      end loop;



      -- ++++++++++++++++++++++++++ CHEQUEO DE PLANIFICABILIDAD ++++++++++++++++++++++++
      for i in Tareas'Range loop
         if (Tareas(i).R < Tareas(i).D or Tareas(i).R = Tareas(i).D) then
            Tareas(i).Planificable := True;
         else
            Tareas(i).Planificable := False;
         end if;
      end loop;



   end Planificar;




   --En este ultimo metodo, he reciclado los main correspondientes al punto 1 y 2, y con ayuda de
   --los metodos anteriores, podemos calcular la prioridad, retardos y planificabilidad de un
   --sistema, simulando los tiempos de computo.
   procedure PuntoFinal (Tareas : in out array_reg_Planificacion_t) is
      Procedimientos: array_ref_Procedimiento_t := (P1'Access, P2'Access, P3'Access, P4'Access);
      Tiempos: array_Tiempos_t (Procedimientos'Range);
   begin
      --Primero calculamos los tiempos de computo, y los imprimimos
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


      --Despues, rellenamos el array de tareas con los tiempos de computo
      for i in 1..4 loop
         Tareas(i).C := Tiempos(i);
      end loop;


      --Una vez que tenemos las tareas preparadas para ser ejecutadas, las ejecutamos
      Planificar(Tareas);

      --Y ahora imprimimos las tareas
      Put_line ("+------------------------------------------------+");
      Put_Line ("|  Tarea   T    D    C    P    R    Planificable |");
      Put_line ("|------------------------------------------------|");
      for I in Tareas'Range loop
         Put ("| ");
         Put (Tareas(I).Nombre'Image); Put ("   ");
         Put (Tareas(I).T'Image); Put (" ");
         Put (Tareas(I).D'Image); Put (" ");
         Put (Tareas(I).C'Image); Put (" ");
         Put (Tareas(I).P'Image); Put (" ");
         Put (Tareas(I).R'Image); Put (" ");
         if Tareas(I).Planificable then
            Put_Line ("        SI      |");
         else
            Put_Line ("        NO      |");
         end if;
      end loop;
      Put_line ("+------------------------------------------------+");
   end PuntoFinal;


end plan;

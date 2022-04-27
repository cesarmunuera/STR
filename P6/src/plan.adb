with Proc, Ada.Calendar;
use Proc, Ada.Calendar;

package body plan is

   procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos : out array_Tiempos_t) is
      t1fin, t1 : Time;
      t2fin, t2 : Time;
      t3fin, t3 : Time;
      t4fin, t4 : Time;
      tcomienzo : Time;

   begin
      tcomienzo := Clock;

      --Medimos el tiempo del procedimiento 1
      Procedimientos[1].all;
      t1fin := Clock;
      t1 := tcomienzo - t1fin;

      --Medimos el tiempo del procedimiento 2
      Procedimientos[2].all;
      t2fin := Clock;
      t2 := tcomienzo - t2fin;

      --Medimos el tiempo del procedimiento 3
      Procedimientos[3].all;
      t3fin := Clock;
      t3 := tcomienzo - t3fin;

      --Medimos el tiempo del procedimiento 4
      Procedimientos[4].all;
      t1fin := Clock;
      t4 := tcomienzo - t4fin;

      --Rellenamos el array de tiempo
      Tiempos[1] := t1;
      Tiempos[2] := t2;
      Tiempos[3] := t3;
      Tiempos[4] := t4;

   end Medir;

end plan

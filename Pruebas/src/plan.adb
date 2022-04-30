with Ada.Text_IO; use Ada.Text_IO;
with Proc, Ada.Calendar;
use Proc, Ada.Calendar;

package body plan is

   procedure Medir (Procedimientos: array_ref_Procedimiento_t; Tiempos : out array_Tiempos_t) is
      t1, t2 ,t3, t4 : Float;
      t1fin, t2fin, t3fin, t4fin, tcomienzo: Time;

   begin
      tcomienzo := Clock;

      --Medimos el tiempo del procedimiento 1
      Procedimientos(1).all;
      t1fin := Clock;
      t1 := Float(Seconds(t1fin)) - Float(Seconds(tcomienzo));

      --Medimos el tiempo del procedimiento 2
      Procedimientos(2).all;
      t2fin := Clock;
      t2 := Float(Seconds(t2fin)) - Float(Seconds(tcomienzo));

      --Medimos el tiempo del procedimiento 3
      Procedimientos(3).all;
      t3fin := Clock;
      t3 := Float(Seconds(t3fin)) - Float(Seconds(tcomienzo));

      --Medimos el tiempo del procedimiento 4
      Procedimientos(4).all;
      t4fin := Clock;
      t4 := Float(Seconds(t4fin)) - Float(Seconds(tcomienzo));


      --Rellenamos el array de tiempo

      Put_Line("El tiempo de P1 es " & t1'Image);
      Put_Line("El tiempo de P2 es " & t2'Image);
      Put_Line("El tiempo de P3 es " & t3'Image);
      Put_Line("El tiempo de P4 es " & t4'Image);


      Tiempos(1) := Integer(t1*10.00);
      Tiempos(2) := Integer(t2*10.00);
      Tiempos(3) := Integer(t3*10.00);
      Tiempos(4) := Integer(t4*10.00);

   end Medir;

end plan;

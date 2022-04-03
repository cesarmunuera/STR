with Ada.Calendar, Ada.Text_Io;
use Ada.Calendar, Ada.Text_Io, Ada.Text_Io;
procedure Main is

   t_inicial : time;
   t_final : time;

   t1, t2, t3 : Float;
begin

   t_inicial := Clock;

   for i in 1..5 loop
      delay 2.5;
   end loop;

   t_final := Clock;

   t1 := Float(seconds(t_inicial));
   t2 := Float(seconds(t_final));

   t3 := t2 - t1;

   Put_Line("T2 es: " & Float'Image(t2));
   Put_Line("T1 es: " & Float'Image(t1));
   Put_Line("T3 es: " & Float'Image(t3));

end Main;

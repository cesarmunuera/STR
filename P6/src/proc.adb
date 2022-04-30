with Ada.Text_Io;
use Ada.Text_Io;

package body proc is
   procedure P1 is
      stop : Boolean := False;
   begin
      Put_Line("Comenzamos con la P1");
      while (stop) loop
         delay 0.4;
         stop := True;
      end loop;
   end P1;


   procedure P2 is
      stop : Boolean := False;
   begin
      Put_Line("Comenzamos con la P2");
      while (stop) loop
         delay 0.6;
         stop := True;
      end loop;
   end P2;


   procedure P3 is
      stop : Boolean := False;
   begin
      Put_Line("Comenzamos con la P3");
      while (stop) loop
         delay 0.8;
         stop := True;
      end loop;
   end P3;


   procedure P4 is
      stop : Boolean := False;
   begin
      Put_Line("Comenzamos con la P4");
      while (stop) loop
         delay 0.8;
         stop := True;
      end loop;
   end P4;

end proc;

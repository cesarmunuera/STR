with Ada.Text_Io;
use Ada.Text_Io;

package body proc is
   procedure P1 is
      stop : Boolean := False;
      while (stop) loop
         delay 0.4;
         stop := True;
      end loop;
   end procedure;


   procedure P2 is
      stop : Boolean := False;
      while (stop) loop
         delay 0.6;
         stop := True;
      end loop;
   end procedure;


   procedure P3 is
      stop : Boolean := False;
      while (stop) loop
         delay 0.8;
         stop := True;
      end loop;
   end procedure;


   procedure P4 is
      stop : Boolean := False;
      while (stop) loop
         delay 0.8;
         stop := True;
      end loop;
   end procedure;

end proc

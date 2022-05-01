with Ada.Text_Io;
use Ada.Text_Io;

package body proc is

   --Igual hay que hacer un delay until. Pillar el tiempo nada mas entrar al Pn, y hacerle delay until ese tiempo + el de computo.
   --De esta forma, se cumple completamente que el computo sea 400ms.

   procedure P1 is
   begin
      Put_Line("Comenzamos con la P1");
      delay 0.4;
   end P1;


   procedure P2 is
   begin
      Put_Line("Comenzamos con la P2");
      delay 0.6;
   end P2;


   procedure P3 is
   begin
      Put_Line("Comenzamos con la P3");
      delay 0.8;
   end P3;


   procedure P4 is
   begin
      Put_Line("Comenzamos con la P4");
      delay 0.8;
   end p4;
end proc;

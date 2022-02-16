with Ada.Text_IO;
use ada.Text_IO;

procedure main is
   type lado is new Float range 0.01..100.00;
   package ES_float is new Ada.Text_Io.Float_Io(lado);

   base : lado;
   altura : lado;

begin
   Put("Introduce la longitud de la base: ");
   ES_float.Get(base);
   set_col(5);
   New_Line(1);
   Put("Introduce la longitud de la altura: ");
   ES_float.Get(altura);
   set_col(5);
   New_Line(3);
   Put("el area del triangulo es: " & Float'Image(Float(base*altura)));
   --ES_float.Put("el area del triangulo es: " & (base*altura));


exception
   when Data_Error =>
     New_Line(2);
   Put("Tienes que introducir un valor válido");


end main;




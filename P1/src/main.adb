with Ada.Text_IO;
use ada.Text_IO;

procedure main is
   type dia_t is range 0..31;
   type mes_t is (enero , febrero , marzo , abril , mayo , junio, julio, agosto, septiembre, octubre, noviembre, diciembre );
   type anio_t is range 1900..2100;
   type temp_t is delta 0.01 range -25.0..75.0;

   package ES_dia is new Ada.Text_Io.Integer_Io(dia_t);
   package ES_mes is new Ada.Text_Io.Enumeration_Io(mes_t);
   package ES_anio is new Ada.Text_Io.Integer_Io(anio_t);
   package ES_temp is new Ada.Text_Io.Fixed_Io(temp_t);

   type fecha_r is record
      Dia : dia_t;
      Mes : mes_t;
      Anio : anio_t;
   end record ;

   type registro_t is record
      Fecha : fecha_r;
      Temperatura : temp_t;
   end record ;
   reg_r : registro_t;

   type vector_t is array (1..2) of registro_t;
   vector : vector_t;


begin
   for i in 1..2 loop
      Put("Primero, introduciremos la fecha ... ");
      New_Line(1);
      Put("Introduce el dia:");
      ES_dia.Get(reg_r.Fecha.Dia);
      New_Line(1);

      Put("Introduce el mes:");
      ES_mes.Get(reg_r.Fecha.Mes);
      New_Line(1);

      Put("Introduce el año:");
      ES_anio.Get(reg_r.Fecha.Anio);
      New_Line(1);

      Put("Ahora, introduce la temperatura de ese dia: ");
      ES_temp.Get(reg_r.Temperatura);
      New_Line(1);

      --Ahora guardamos en el array
      vector(i) := reg_r;
   end loop ;

   Put_Line("Los valores introducidos son:");
   Put_Line("El dia " & vector(1).Fecha.Dia'Image & ", mes " & vector(1).Fecha.Mes'Image & ", año " & vector(1).Fecha.Anio'Image & ", habia una temperatura de " & vector(1).Temperatura'Image);

exception
   when Data_Error =>
     New_Line(2);
     Put("Tienes que introducir un valor válido");


end main;




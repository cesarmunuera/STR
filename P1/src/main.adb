with Ada.Text_IO;
use ada.Text_IO;

procedure main is

   type dia_t is range 0..31;
   type mes_t is (enero , febrero , marzo , abril , mayo , junio, julio, agosto, septiembre, octubre, noviembre, diciembre);
   type anio_t is range 1900..2100;
   type temp_t is delta 0.01 range -25.0..75.0;

   mediaTemperaturas : temp_t;

   package ES_dia is new Ada.Text_Io.Integer_Io(dia_t);
   package ES_mes is new Ada.Text_Io.Enumeration_Io(mes_t);
   package ES_anio is new Ada.Text_Io.Integer_Io(anio_t);
   package ES_temp is new Ada.Text_Io.Fixed_Io(temp_t);
   package Es_IO is new Ada.Text_IO.Integer_IO(Natural);

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

   type array_t is array (integer range <>) of registro_t;
   type pArray_t is access array_t;
   v : pArray_t;
   n : Integer;

   type vectorMaxMin_t is array (1..2) of registro_t;
   vectorTemperaturas : vectorMaxMin_t;




   function calculoMaxMin(vector : pArray_t) return vectorMaxMin_t is
      vectorMaxMin : vectorMaxMin_t; --La posicion 1 es el maximo, y la 2 el minimo
   begin
      vectorMaxMin(1) := vector(1); --MAXIMO
      vectorMaxMin(2) := vector(1); --MINIMO

      for i in 2..vector'Length loop
         if vector(i).Temperatura > vectorMaxMin(1).Temperatura then --MAXIMO
            vectorMaxMin(1) := vector(i);
         elsif vector(i).Temperatura < vectorMaxMin(2).Temperatura then --MINIMO
            vectorMaxMin(2) := vector(i);
         end if;
      end loop;

   return vectorMaxMin;
   end calculoMaxMin;


   function calculoMedia(vector : pArray_t) return temp_t is
      totalTemperaturas, media : temp_t;
   begin
      --Primero sacamos todas las temperaturas
      for i in 1..vector'Length loop
         totalTemperaturas := (totalTemperaturas + vector(i).Temperatura);
      end loop;

      -- Ahora calculamos la media
      media := totalTemperaturas/vector'Length;

   return media;
   end calculoMedia;


   function calculoFechas(vector : pArray_t) return vectorMaxMin_t is
      vectorMaxMin : vectorMaxMin_t; --La posicion 1 es el maximo, y la 2 el minimo
   begin
      vectorMaxMin(1) := vector(1); --MAXIMO
      vectorMaxMin(2) := vector(1); --MINIMO

      for i in 2..vector'Length loop
         if vector(i).Temperatura > vectorMaxMin(1).Temperatura then --MAXIMO
            vectorMaxMin(1) := vector(i);
         elsif vector(i).Temperatura < vectorMaxMin(2).Temperatura then --MINIMO
            vectorMaxMin(2) := vector(i);
         end if;
      end loop;

   return vectorMaxMin;
   end calculoMaxMin;

begin

   Put("Antes de nada, debe indicar cuantas mediciones quiere introducir: ");
   Es_IO.Get(n);
   New_Line(1);
   v := new array_t (1..n);

   for i in 1..n loop
      Put_Line("Primero, introduciremos la fecha ... ");
      Put("Introduce el dia. Del 1 al 31: ");
      ES_dia.Get(reg_r.Fecha.Dia);
      --New_Line(1);

      Put("Introduce el mes. De enero a diciembre: ");
      ES_mes.Get(reg_r.Fecha.Mes);
      --New_Line(1);

      Put("Introduce el año. Del 1900 al 2100: ");
      ES_anio.Get(reg_r.Fecha.Anio);
      --New_Line(1);

      Put("Ahora, introduce la temperatura de ese dia. Desde -25.00 a 75.00 grados: ");
      ES_temp.Get(reg_r.Temperatura);
      New_Line(2);

      --Ahora guardamos en el array
      v(i) := reg_r;

   end loop ;


   Put_Line(" --------------------- Los valores introducidos son:");
   Put_Line("El dia " & v(1).Fecha.Dia'Image & ", mes " & v(1).Fecha.Mes'Image & ", año " & v(1).Fecha.Anio'Image & ", habia una temperatura de " & v(1).Temperatura'Image);
   Put_Line("El dia " & v(2).Fecha.Dia'Image & ", mes " & v(2).Fecha.Mes'Image & ", año " & v(2).Fecha.Anio'Image & ", habia una temperatura de " & v(2).Temperatura'Image);
   New_Line(3);


   Put_Line(" --------------------- Procedemos a los calculos:");
   vectorTemperaturas := calculoMaxMin(v);
   Put_Line("La temperatura maxima fue:" & vectorTemperaturas(1).Temperatura'Image & ", el dia" & vectorTemperaturas(1).Fecha.Dia'Image & " de "
            & vectorTemperaturas(1).Fecha.Mes'Image & " del año" & vectorTemperaturas(1).Fecha.Anio'Image);
   Put_Line("La temperatura minima fue:" & vectorTemperaturas(2).Temperatura'Image & ", el dia " & vectorTemperaturas(2).Fecha.Dia'Image & " de "
            & vectorTemperaturas(2).Fecha.Mes'Image & " del año" & vectorTemperaturas(2).Fecha.Anio'Image);
   New_Line(1);

   mediaTemperaturas := calculoMedia(v);
   Put_Line("La media de las temperaturas es de:" & mediaTemperaturas'Image & " grados.");








exception
   when Data_Error =>
     New_Line(2);
     Put("Tienes que introducir un valor válido");


end main;




with Calefactor, Sensor, Ada.Real_Time;
use Calefactor, Sensor, Ada.Real_Time;

procedure Medir1 is
   temp_e, temp_actual : Temperaturas;
   tiempo_inicial, tiempo_final : Time;
   l_dif_tiempo : Time_Span;
begin
   --Calculamos Te
   Leer(temp_e);


   --Encendemos el horno
   Escribir(1000);


   --Calculamos L
   Leer(temp_actual);
   tiempo_inicial := Clock;
   while not (temp_e - temp_actual > 0.1) loop
      --Esperamos a que arranque
      Leer(temp_actual)
   end loop;
   tiempo_final := Clock;
   --Sacamos el tiempo inicial y luego el tiempo que tarda en variar la temperatura
   --La diferencia, es el tiempo L
   l_dif_tiempo := tiempo_inicial - tiempo_final;


   --Calculamos Cp






end Medir1;

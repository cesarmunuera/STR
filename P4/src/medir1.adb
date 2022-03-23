with Calefactor, Sensor, Ada.Real_Time;
use Calefactor, Sensor, Ada.Real_Time;

procedure Medir1 is
   potencia : Potencias;
   temp_e, temp_actual, temp_aux, Cp : Temperaturas;
   tiempo_inicial, tiempo_final : Time;
   l_dif_tiempo : Time_Span;
begin
   --Calculamos Te
   Leer(temp_e);


   --Encendemos el horno
   potencia := 1000;
   Escribir(potencia);


   --Calculamos L. Mientras que la diferencia de la temperatura ambiente con la del interior no sea notable,
   --seguimos esperando a que el horno siga calentando
   Leer(temp_actual);
   tiempo_inicial := Clock;
   while not (temp_e - temp_actual > 0.1) loop
      --Esperamos a que arranque
      Leer(temp_actual):
   end loop;
   tiempo_final := Clock;
   --Sacamos el tiempo inicial y luego el tiempo que tarda en variar la temperatura. Esto es el tiempo L
   l_dif_tiempo := tiempo_inicial - tiempo_final;


   --Calculamos Cp. Tenemos que esperar a que la diferencia de temperatura en un instante sea minima con
   --el instante anterior, que es cuando la curva se ha estabilizado
   Leer(temp_actual);
   Leer(temp_aux);
   while not (temp_actual - temp_aux < 0.1) loop
      --Esperamos a que llegue al regimen permanente
      --Acualizamos variables
      temp_aux := temp_actual;
      Leer(temp_actual);
   end loop;
   --Calculamos con 0 = P - Cp(T - Te). Cp = (P / T-Te). P = potencia, T = temp_actual, Te = temp_e.
   Cp = (potencia / (temp_actual - temp_e));




end Medir1;

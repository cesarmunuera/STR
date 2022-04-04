with Calefactor, Sensor, Ada.Real_Time, Ada.Text_IO;
use Calefactor, Sensor, Ada.Real_Time, Ada.Text_IO;

procedure Main is

   potencia : Potencias;
   temp_e, temp_actual, temp_aux, temp_despegue, aux: Temperaturas;
   tiempo_inicial, tiempo_final : Time;
   l_dif_tiempo : Time_Span;
   Cp : Float;

begin
   --Calculamos Te.
   Leer(temp_e);
   Put_Line("La temperatura ambiente es: " & temp_e'Image);



   --Encendemos el horno.
   potencia := 1000.0;
   Escribir(potencia);
   Put_Line("LA POTENCIA ES: " & potencia'Image);



   --Calculamos L. Mientras que la diferencia de la temperatura ambiente con la del interior no sea notable,
   --seguimos esperando a que el horno siga calentando. La diferencia va creciendo.
   Leer(temp_actual);
   tiempo_inicial := Clock;
   Put_Line("La temperatura actual es: " & temp_actual'Image);
   while (temp_actual - temp_e < 0.1) loop
      --Esperamos a que arranque
      Leer(temp_actual);
   end loop;
   tiempo_final := Clock;
   temp_despegue := temp_actual;
   --Sacamos el tiempo inicial y luego el tiempo que tarda en variar la temperatura. Esto es el tiempo L.
   l_dif_tiempo := tiempo_final - tiempo_inicial;
   Put_Line("LA TEMPERATURA DE DESPEGUE ES: " & temp_actual'Image);



   --Calculamos Cp. Tenemos que esperar a que la diferencia de temperatura en un instante sea minima con
   --el instante anterior, que es cuando la curva se ha estabilizado. La diferencia decrece.
   --Si volvemos a leer temp_aux, la diferencia en de ambos es 0 y no entramos en el while.
   temp_aux := temp_actual;

   Put_Line("La temperatura aux es: " & temp_aux'Image);
   delay 0.25;
   Leer(temp_actual);
   Put_Line("La temperatura actual es: " & temp_actual'Image);
   aux := temp_actual - temp_aux;
   Put_Line("La diferencia es: " & aux'Image);

   --Este bucle es el tramo del regimen transitorio.
   while (temp_actual - temp_aux > 0.1) loop
      --Esperamos a que llegue al regimen permanente, actualizando variables.
      temp_aux := temp_actual;
      delay 1.5;
      Leer(temp_actual);
      Put_Line("BUCLE La temperatura de actual es: " & temp_actual'Image);
      Put_Line("BUCLE La temperatura aux es: " & temp_aux'Image);
   end loop;

   --Calculamos con 0 = P - Cp(T - Te). Cp = (P / T-Te). P = potencia, T = temp_actual, Te = temp_e.
   Cp := (Float(potencia)) / Float(temp_actual - temp_e);
   Put_Line("Cp ES: " & Cp'Image);



   --Apagamos el horno.
   potencia := 0.0;
   Escribir(potencia);


end Main;
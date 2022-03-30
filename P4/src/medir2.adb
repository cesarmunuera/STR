with Calefactor, Sensor, Ada.Real_Time, Ada.Text_IO;
use Calefactor, Sensor, Ada.Real_Time, Ada.Text_IO;

procedure medir2 is
   temp_actual, temp_anterior, temp_aux, temp_despegue, dif_temp, temp_media, temp_ambiente : Temperaturas;
   potencia : Potencias;
   Cp, pendiente_actual, pendiente_anterior, Ct : Float;
   fin : Boolean;
   dif_tiempo : Time_Span;
   tiempo_anterior, tiempo_actual, tiempo_aux : Time;
begin

   fin := false;
   temp_despegue := 4;
   temp_ambiente :=2;

   --Encendemos el horno
   potencia := 1000;
   Escribir(potencia);

   --Esperamos a que tengamos temperatura distinta de ambiente, y tengamos pendiente
   Leer(temp_actual);
   while (temp_actual < temp_despegue) loop
      Put_Line("Esperando a llegar al regimen transitorio");
      Leer(temp_actual);
      tiempo_anterior := Clock;
   end loop;

   --Calculamos el punto con mayor pendiente
   temp_anterior := temp_actual;
   while (not fin) loop
      Leer(temp_actual);
      tiempo_actual := Clock;

      dif_temp := temp_actual - temp_anterior;
      dif_tiempo := tiempo_actual - tiempo_anterior;

      pendiente_actual := dif_temp/dif_tiempo;
      if (pendiente_actual < pendiente_anterior) then
         fin := true;
      else
         temp_aux := temp_anterior;
         tiempo_aux := tiempo_anterior;

         temp_anterior := temp_actual;
         tiempo_anterior := tiempo_actual;
      end;
   end loop;


   --La temperatura con pendiente maxima es la que se encuentra entre las temperaturas que nos han dado
   --una pendiente maxima. Por ello, hacemos la media entre estas dos temperaturas.
   temp_media := ((temp_anterior - temp_aux)/2) + temp_aux      --Offset = temp_aux

   --Calculamos Ct
   Ct = ((potencia - (Cp*(temp_media - temp_ambiente))) * (tiempo_actual - tiempo_anterior)) / (temp_anterior - temp_aux);

end medir1;

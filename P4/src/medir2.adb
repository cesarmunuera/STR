with Calefactor, Sensor, Ada.Real_Time, Ada.Text_IO;
use Calefactor, Sensor, Ada.Real_Time, Ada.Text_IO;

procedure medir2 is
   temp_actual, temp_anterior, temp_aux, temp_despegue, dif_temp, temp_media, Te : Temperaturas;
   potencia : Potencias;
   Cp, pendiente_actual, pendiente_anterior, Ct : Float;
   fin : Boolean;
   dif_tiempo : Time_Span;
   tiempo_anterior, tiempo_actual, tiempo_aux : Time;
begin

   fin := false;

   --Valores obtenidos en medir1.
   Cp := 4;
   temp_despegue := 4;
   Te :=2;



   --Encendemos el horno.
   potencia := 1000;
   Escribir(potencia);



   --Partimos de la temperatura en la que se supone que entramos en el regimen transitorio.
   --Por tanto, esto simplemente es un checkeo, ya que la actual tiene que ser superior.
   --Tomamos la temperatura ya que este valor ser� el del T1 para sacar la pendiente despues.
   Leer(temp_actual);
   tiempo_anterior := Clock;
   while (temp_actual < temp_despegue) loop
      Put_Line("Esperando a llegar al regimen transitorio");
      Leer(temp_actual);
      tiempo_anterior := Clock;
   end loop;



   --Calculamos el punto con mayor pendiente.
   --Antes hemos sacado el tiempo de esta temperatura, y ahora lo asignamos al anterior, por
   --eso el tiempo lo hemos tomado en su momento. En el bucle, comprobamos la pendiente actual
   --con la anterior. Si es superior, los valores actuales pasan a los anteriores, y los anteriores
   --al auxiliar. De tal forma que cuando lleguemos a una pendiente menor a la anterior,
   --podamos tener los puntos que han sido los maximos. T1 ser� el aux y T2 el anterior.
   temp_anterior := temp_actual;
   while (not fin) loop
      Leer(temp_actual);
      tiempo_actual := Clock;

      dif_temp := temp_actual - temp_anterior;
      dif_tiempo := tiempo_actual - tiempo_anterior;

      pendiente_actual := dif_temp/dif_tiempo;           --Aqui el jaleo de los cast para poder dividir bien
      if (pendiente_actual < pendiente_anterior) then
         fin := true;
      else
         pendiente_anterior := pendiente_actual;

         temp_aux := temp_anterior;
         tiempo_aux := tiempo_anterior;

         temp_anterior := temp_actual;
         tiempo_anterior := tiempo_actual;
      end;
   end loop;



   --La temperatura con pendiente maxima es la que se encuentra entre las temperaturas que nos han dado
   --una pendiente maxima. Por ello, hacemos la media entre estas dos temperaturas. Se calcula el valor
   --intermedio y se le suma el offset, que es la temperatura menor.
   temp_media := ((temp_anterior - temp_aux)/2) + temp_aux;

   --Calculamos Ct con los datos anteriores.
   Ct = ((potencia - (Cp * (temp_media - Te))) * (tiempo_actual - tiempo_anterior)) / (temp_anterior - temp_aux);



   --Apagamos el horno.
   potencia := 0.0;
   Escribir(potencia);

end medir1;

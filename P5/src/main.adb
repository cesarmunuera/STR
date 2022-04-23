with Calefactor, Sensor, Ada.Calendar, Ada.Text_IO;
use Calefactor, Sensor, Ada.Calendar, Ada.Text_IO;

procedure Main is
   temp_despegue, dif_temp, temp_media, Te, temp_estable : Temperaturas;
   potencia : Potencias;
   Cp, pendiente_actual, pendiente_maxima, Ct, dif_tiempo : Float;
   fin : Boolean;

   type vector_temp is array (1..4) of Temperaturas;
   vectorTemperaturas : vector_temp;

   type vector_tiempos is array (1..4) of Time;
   vectorTiempos : vector_tiempos;

   Fichero1 : File_Type;
begin
   Open(Fichero1, Out_File, "C:\Users\cesar\Desktop\Universidad\STR\STR\P5\src\lecturaspendientes.txt");

   fin := false;
   pendiente_maxima := 0.0;

   --Valores obtenidos en medir1.
   Cp := 28.73;
   temp_despegue := 25.15;
   Te := 25.0;
   temp_estable := 59.8;

   --Encendemos el horno.
   potencia := 1000.0;
   Escribir(potencia);



   --Partimos de la temperatura en la que se supone que entramos en el regimen transitorio.
   --Por tanto, esto simplemente es un checkeo, ya que la actual tiene que ser superior.
   Leer(vectorTemperaturas(1));
   Put_Line("Esperando a llegar al regimen transitorio ...");
   while (vectorTemperaturas(1) < temp_despegue) loop
      Leer(vectorTemperaturas(1));
      vectorTiempos(1) := Clock;
   end loop;
   Put_Line("Hemos entrado en el regimen transitorio!");


   --Calculamos el punto con mayor pendiente.
   --Antes hemos sacado el tiempo de esta temperatura, y ahora lo asignamos al anterior, por
   --eso el tiempo lo hemos tomado en su momento. En el bucle, comprobamos la pendiente actual
   --con la anterior. Si es superior, los valores actuales pasan a los anteriores, y los anteriores
   --al auxiliar. De tal forma que cuando lleguemos a una pendiente menor a la anterior,
   --podamos tener los puntos que han sido los maximos. T1 será el aux y T2 el anterior.
   Put_Line("Calculando pendiente máxima ...");
   while (vectorTemperaturas(1) < temp_estable) loop

      vectorTemperaturas(2) := vectorTemperaturas(1);
      vectorTiempos(2) := vectorTiempos(1);

      delay 0.1;

      Leer(vectorTemperaturas(1));
      vectorTiempos(1) := Clock;

      --Put_Line("La teemperatura actual es: " & vectorTemperaturas(1)'Image);
      --Put_Line("La temperatura anterior es: " & vectorTemperaturas(2)'Image);

      --Put_Line("El tiempo actual es: " & Seconds(vectorTiempos(1))'Image);
      --Put_Line("El tiempo anterior es: " & Seconds(vectorTiempos(2))'Image);

      dif_temp := vectorTemperaturas(1) - vectorTemperaturas(2);
      dif_tiempo := Float(Seconds(vectorTiempos(1))) - Float(Seconds(vectorTiempos(2)));
      --Put_Line("La diferencia de tiempos es: " & dif_tiempo'Image);
      --Put_Line("La diferencia de temperatura es: " & dif_temp'Image);

      pendiente_actual := Float(dif_temp)/dif_tiempo;
      Put_Line(pendiente_actual'Image);
      Put_Line(Fichero1, pendiente_actual'Image);

      if (pendiente_actual > pendiente_maxima) then
         pendiente_maxima := pendiente_actual;

         vectorTemperaturas(4) := vectorTemperaturas(2);--Posiciones anteriores
         vectorTiempos(4) := vectorTiempos(2);

         vectorTemperaturas(3) := vectorTemperaturas(1);--Posiciones actuales
         vectorTiempos(3) := vectorTiempos(1);
      end if;
   end loop;
   --Put_Line("La pendiente maxima fue: " & pendiente_maxima'Image);



   --La temperatura con pendiente maxima es la que se encuentra entre las temperaturas que nos han dado
   --una pendiente maxima. Por ello, hacemos la media entre estas dos temperaturas. Se calcula el valor
   --intermedio y se le suma el offset, que es la temperatura menor.
   temp_media := ((vectorTemperaturas(3) - vectorTemperaturas(4))/2.0) + vectorTemperaturas(4);

   --Calculamos Ct con los datos anteriores.
   Ct := ((Float(potencia) - Float(Cp * Float(temp_media - Te))) * (Float(Seconds(vectorTiempos(3)))
          - Float(Seconds(vectorTiempos(4))))) / (Float(vectorTemperaturas(3) - vectorTemperaturas(4)));
   Put_Line("EL VALOR DE Ct ES: " & Ct'Image);


   --Apagamos el horno.
   potencia := 0.0;
   Escribir(potencia);

   Close(Fichero1);
end Main;

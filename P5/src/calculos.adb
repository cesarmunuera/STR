with Calefactor, Sensor, Ada.Calendar, Ada.Text_IO;
use Calefactor, Sensor, Ada.Calendar, Ada.Text_IO;

procedure calculos is
   temp_despegue, dif_temp, Te, temp_estable : Temperaturas;
   potencia : Potencias;
   Cp, pendiente_actual, pendiente_maxima, dif_tiempo : Float;
   fin : Boolean;

   type vector_temp is array (1..4) of Temperaturas;
   vectorTemperaturas : vector_temp;

   type vector_tiempos is array (1..4) of Time;
   vectorTiempos : vector_tiempos;

   Kp, Ti, Td, L, T : Float;

begin

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

      dif_temp := vectorTemperaturas(1) - vectorTemperaturas(2);
      dif_tiempo := Float(Seconds(vectorTiempos(1))) - Float(Seconds(vectorTiempos(2)));

      pendiente_actual := Float(dif_temp)/dif_tiempo;
      --Put_Line(pendiente_actual'Image);

      if (pendiente_actual > pendiente_maxima) then
         pendiente_maxima := pendiente_actual;

         vectorTemperaturas(4) := vectorTemperaturas(2);--Posiciones anteriores
         vectorTiempos(4) := vectorTiempos(2);

         vectorTemperaturas(3) := vectorTemperaturas(1);--Posiciones actuales
         vectorTiempos(3) := vectorTiempos(1);
      end if;
   end loop;

   --Obtenemos los puntos de la recta
   Put_Line("Punto 1");
   Put_Line("La temperatura de pendiente maxima es " & vectorTemperaturas(4)'Image);
   Put_Line("El tiempo de pendiente maxima es " & Float(Seconds(vectorTiempos(4)))'Image);
   Put_Line("Punto 2");
   Put_Line("La temperatura de pendiente maxima es " & vectorTemperaturas(3)'Image);
   Put_Line("El tiempo de pendiente maxima es " & Float(Seconds(vectorTiempos(3)))'Image);

   --Generamos la recta
   Put_Line("La recta que sale con estos puntos es: y-25.74 = (38)/(25) * (x-5134.4)" );
   Put_Line("La temperatura K es 60º, y la temperatura base es de 25º");
   Put_Line("Interseccionando con estas rectas, obtenemos los tiempos 51340.8s y 51369.5");
   Put_Line("Por tanto, L 51340.8s vale, y T vale 28.7");
   L := 51340.8;
   T := 28.7;

   --Calculamos Kp, Ti y Td
   Kp := 1.2 * (T/L);   --6.7 x 10(-4)
   Ti := 2.0 * L;       --102681.8
   Td := 0.5 * L;       --25670.4
   Put_Line("El valor de Kp es: " & Kp'Image);
   Put_Line("El valor de Ti es: " & Ti'Image);
   Put_Line("El valor de Td es: " & Td'Image);


   --Apagamos el horno.
   potencia := 0.0;
   Escribir(potencia);

end calculos;

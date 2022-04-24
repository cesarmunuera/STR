with Ada.Text_IO; use Ada.Text_IO;
with sensor; use sensor;
with calefactor; use calefactor;
with Ada.Calendar; use Ada.Calendar;

procedure Main is
   temp_amb, temp_act, temp_anterior : Temperaturas;
   instanteInicial: Time;
   instante1 : Time;
   instante2 : Time;
   instanteActual : Time;
   segundosInicio : Float;
   segundosInicial : Float;
   difTiempoMax : Float := 0.0;
   difTempMax : Float := 0.0;
   tempAntMax : Float := 0.0;
   tempActMax : Float := 0.0;

   segundosActual : Float;
   segundosFinal : Float;
   potencia : Potencias := 1000.0;
   Cp : Float := 26.63; --Resultado obtenido en medir1, puede variar un poco entre ejecuciones
   Ct : Float;

   temp_pendiente, tiempo_pendiente, pendiente : Float;

begin
   temp_amb := 25.0;
   Escribir(potencia);

   --En medir 2, en el tiempo en el que el horno está en estado transitorio voy cogiendo dos temperaturas, con un tiempo de
   --diferencia entre ellas de 2 segundos, me guardo los dos puntos entre los que haya más pendiente y los uso en la formula
   instanteInicial := Clock;
   segundosInicial := Float(Seconds(instanteInicial));
   delay(2.7); --delay de arranque del horno
   instanteActual := Clock;
   segundosActual := Float(Seconds(instanteActual));
   --
   Put_Line(" --- PENDIENTES ---");
   while(segundosActual - segundosInicial < 147.3) loop --147.3  calculado en medir1 tiempo aproximando en que la grafica llega al régimen permanente
      --Temperatura anterior con su instante
      Leer(temp_anterior);
      instante1 := Clock;
      segundosInicio := Float(Seconds(instante1));
      delay(2.0);
      --Temperatura actual con su instante
      Leer(temp_act);
      instante2 := Clock;
      segundosFinal := Float(Seconds(instante2));
      --Se guardan las dos con mayor pendiente. No hace falta calcular la pendiente como tal ya que el tiempo de recogida entre
      --temperatura actual y temperatura anterior es el mismo en las dos

      --MOD A SALME
      --CALCULAMOS PENDIENTES
      temp_pendiente := Float(temp_act-temp_anterior);
      Put_Line(temp_pendiente'Image);
      tiempo_pendiente := segundosFinal - segundosInicio;
      pendiente := temp_pendiente/tiempo_pendiente;
      --Put_Line(pendiente'Image);
      --MOD A SALME


      if(Float(temp_act-temp_anterior)>difTempMax) then
         difTempMax := Float(temp_act-temp_anterior);
         tempActMax := Float(temp_act);
         tempAntMax := Float(temp_anterior);
         difTiempoMax := segundosFinal - segundosInicio;
      end if;
      --Instante actual se usa para comprobar cuando el horno llega al  régimen permanente
      instanteActual := Clock;
      segundosActual := Float(Seconds(instanteActual));
   end loop;
   Ct := ((Float(potencia) - (Cp*(tempActMax-Float(temp_amb))))/(difTempMax))*(difTiempoMax);
   Put_Line("La constante Ct es: "& Float'Image(Ct));

   Escribir(0.0);

   null;
end Main;

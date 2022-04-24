with Ada.Real_Time, Ada.Text_Io, Sensor, Calefactor, PID;
use Ada.Real_Time, Ada.Text_Io, Sensor, Calefactor;

procedure principal is

   package PID_t is new PID(real=>Float, entrada=>Temperaturas, salida=>Potencias);
   use PID_t;

   Kd, Ki: Float;

   --Valores obtenidos a mano, en la clase calculos
   Kp : Float := 0.00067;
   Ti : Float := 102681.8;
   Td : Float := 25670.4;

   control : Controlador;

   Tiempo_ejecucion : Integer := 600;
   Temperatura_horno : Temperaturas;
   Temperatura_deseada : Temperaturas := 100.00;
   u : Potencias;

begin
   --Primero calculamos Ki y Kd
   Ki := Kp / Ti;
   Kd := Kp * Td;

   --Ahora inicializamos el controlador con Programar
   Programar(control,Kp,Ki,Kd);

   --Procedemos a estar 10 minutos controlando la temperatura
   for i in 1..Tiempo_ejecucion loop
      delay duration(1.0);
      Leer(Temperatura_horno);

      Put_Line(Temperatura_horno'Image);

      Controlar(control,Temperatura_deseada,Temperatura_horno,u);
      Escribir(u);
   end loop;

   --Apagamos el horno
   Escribir(0.0);

end principal;

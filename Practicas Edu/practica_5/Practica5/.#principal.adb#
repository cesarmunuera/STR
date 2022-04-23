with Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor, PID;
use Ada.Text_Io, Ada.Real_Time, Sensor, Calefactor;

procedure principal is
	package Float_ES is new Ada.Text_IO.Float_IO(Float);
	package PID_t is new PID(real=>Float, entrada=>Temperaturas, salida=>Potencias);
	use PID_t;
	TiempoS: Integer:=600;--Tiempo que va a estar encendido en segundos
	T,Tref: Temperaturas:=200.0;--Temperatura a alcanzar
	u: Potencias;
	control: Controlador;	
	Kp,Kd,Ki: Float;
begin
	--get temperatura
	Kp:=50.0;
	Ki:=0.5;
	Kd:=5.0;
	Programar(control,Kp,Ki,Kd);
	for i in 1..TiempoS loop
		delay duration(1.0);--Al ejecutarse 600 veces y que se pare 1 segundo dura los 10 minutos
		Leer(T);
		Controlar(control,Tref,T,u);
		Escribir(u);
		Float_ES.Put(float(t),0,3,0);
		New_Line;
        end loop;
	Escribir(0.0);

end principal;

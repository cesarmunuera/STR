with sensor, calefactor, Ada.Text_Io, Ada.Real_Time;
use Ada.Text_Io, Ada.Real_Time;

procedure medir2 is

	package Real_Es is new Ada.Text_Io.Float_Io(float);

	T:sensor.temperaturas;
	Te:sensor.temperaturas := 25.0;
	p:calefactor.potencias := 1000.00;
	Ct:float := 0.0;
	Cp:float := 25.7;
	retardo: constant time_span:=to_time_span(0.1); 
	tiempo:Time:=Clock;
	
	begin
	calefactor.escribir(p);--Encendemos el horno
	sensor.leer(T);--Tomamos la temperatura

	while float(Te) = float(T) loop

		delay until tiempo;
		tiempo := tiempo + retardo;--Sumamos los retardos
		sensor.leer(T);
	end loop;

	Ct := ((float(p)-Cp*(float(T)-float(Te)))*32.0)/(float(T));--Calculamos la capacidad termica
	New_Line;
	put("Capacidad termica (Ct): "); real_es.put(Ct,Fore=>3,Aft=>0,Exp=>0);

	p:=0.0;
	calefactor.escribir(p);--apagamos

end medir2;

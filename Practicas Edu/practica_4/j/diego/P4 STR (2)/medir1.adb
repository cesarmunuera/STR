with sensor, calefactor, Ada.Text_Io, Ada.Real_Time;
use Ada.Text_Io, Ada.Real_Time;

procedure medir1 is
	
	package Real_Es is new Ada.Text_Io.Float_Io(float);
	package Temp_Es is new Ada.Text_Io.Float_Io(sensor.Temperaturas);

	Te,T,TAux:sensor.temperaturas;
	p:calefactor.potencias:=1000.00;
	Cp,L,a:float:=0.0;
	retardo: constant time_span:=to_time_span(0.1); 
	tiempo:Time:=Clock;
	
	begin
		sensor.leer(Te);--obtenemos la temperatura del horno antes de encender
		put_Line("Temperatura ambiente sin encender(Te): "); Temp_es.put(Te,Fore=>3,Aft=>0,Exp=>0);
		calefactor.escribir(p);--Lo encendemos a 1000W
		sensor.leer(T);--Temperatura despues de encender el horno
		
		while float(Te) = float(T) loop
			delay until tiempo;
			tiempo:=tiempo + retardo; --Suma el retardo
			L :=  L + float(To_Duration(retardo)); --Pasa a float
			sensor.leer(T);
		end loop;
		
		
		delay Duration(10.0);
		sensor.leer(TAux);
		while float(TAux)-float(T) > 0.1 loop--Para cuando la diferencia es notable
			sensor.leer(T);
			delay Duration(5.0);--Para para que cambie la temperatura
			sensor.leer(TAux);
		end loop;
			

		
		
		
		Cp:=float(p)/(float(T)-float(Te));
		
		put("Temperatura ambiente (Te): "); Temp_es.put(Te,Fore=>3,Aft=>0,Exp=>0);
		New_Line;
		put("Retardo (L): "); real_es.put(L,Fore=>3,Aft=>0,Exp=>0);
		New_Line;
		put("Coeficiente de perdida (Cp): "); real_es.put(Cp,Fore=>3,Aft=>0,Exp=>0);
		New_Line;

		if (float(p) - Cp * (float(T) - float(Te))) < 0.001 then
			put_Line("Es correcto	 0=p-Cp*(T-Te)");
			New_Line;
			
		end if;

		p:=0.0;
		calefactor.escribir(p);--Se apaga el horno
		
		
		
end medir1;

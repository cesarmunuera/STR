with Horno,Sensor;
package body Sensor is
	procedure Leer(la_Temperatura: out Temperaturas) is
	begin 
		Horno.leer(horno.Temperaturas(la_Temperatura));
	end Leer;
end sensor;

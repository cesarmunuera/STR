with Horno;

package body sensor is

	procedure Leer (la_temperatura:out Temperaturas) is
	begin
		Horno.Leer(Horno.Temperaturas(la_temperatura));
	end Leer;
end sensor;

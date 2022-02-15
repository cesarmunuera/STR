with Horno;

package body calefactor is
	procedure Escribir (la_potencia: Potencias) is
	begin
		Horno.Escribir(Horno.Potencias(la_Potencia));
	end Escribir;
end calefactor;

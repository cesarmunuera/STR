with Ada.Text_Io,Horno,Sensor; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;

package body Calefactor is
	package Potencias_Es is new Ada.Text_Io.Float_Io(Potencias);
	procedure Escribir(la_Potencia: Potencias) is
	begin
		Horno.Escribir(Horno.Potencias(la_Potencia));
		
	end Escribir;
end Calefactor;

with Horno;
use Horno;

package body calefactor is
   procedure Escribir (la_Potencia : Potencias) is
   begin
      Horno.Escribir(Horno.Potencias(la_Potencia));
   end;
end calefactor;

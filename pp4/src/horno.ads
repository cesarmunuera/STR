--La potencia que se suministra hay que restar la temperatura de dentro menos la de fuera, multiplicado por el
--coeficiente de aislamiento.
package Horno is
   type Temperaturas is new Float;
   type Potencias is new Float;

   procedure Escribir (la_Potencia: Potencias);
   procedure Leer (la_Temperatura: out Temperaturas);
end Horno;

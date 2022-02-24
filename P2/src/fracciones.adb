package body Fracciones is

   function reducir (X : fraccion_t) return fraccion_t is
      numerador, denominador, aux : Integer;
   begin
      numerador := X.Num;
      denominador := Integer(X.Den);
      --El resultado del MCD queda en el numerador
      while (denominador /= 0) loop
         aux := numerador;
         numerador := denominador;
         denominador := aux mod denominador;
      end loop;
      --Procedemos a reducir la fraccion
      X.Num := (X.Num / numerador);
      X.Den := Positive(X.Den / numerador);
      return X;
   end;

   function "+" (X, Y: fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin
      aux.Num := (X.Num * Y.Den) + (Y.Num * X.Den);
      aux.Den := X.Den * Y.Den;
      return aux;
   end;


end Fracciones;

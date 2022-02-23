package body Fracciones is

   function reducir (X : fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin
      return aux;
   end;

   function "+" (X, Y: fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin
      aux.Num := (X.Num * Y.Den) + (Y.Num * X.Den);
      aux.Den := X.Den * Y.Den;
      return aux;
   end;


end Fracciones;

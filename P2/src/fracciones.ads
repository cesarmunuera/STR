package Fracciones is
   type fraccion_t is private;

   function "+" (X, Y: fraccion_t) return fraccion_t;
   function "-" (X: fraccion_t) return fraccion_t;
   function "-" (X, Y: fraccion_t) return fraccion_t;
   function "*" (X, Y: fraccion_t) return fraccion_t;
   function "/" (X, Y: fraccion_t) return fraccion_t;
   --function "=" (X, Y: fraccion_t) return Boolean;

   -- Operaciones de entrada/salida con la consola
   --procedure Leer (F: out fraccion_t);
   procedure Escribir (F: fraccion_t);

   -- Constructor de n�meros fraccionarios a partir de n�meros enteros
   function "/" (X, Y: Integer) return fraccion_t;

   -- Operaciones para obtener las partes de una fracci�n
   function Numerador (F: fraccion_t) return Integer;
   function Denominador(F:fraccion_t) return Positive;

private
   type fraccion_t is record
      Num: Integer;
      Den: Positive;
   end record;
end Fracciones;

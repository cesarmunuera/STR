with Ada.Text_Io;use Ada.Text_Io;

package body Fracciones is

   --Esta es la funcion para mostrar los datos por pantalla
   procedure Escribir (F: fraccion_t) is
   begin
      Put_Line(F.Num'Image & "/" & F.Den'Image);
   end;



   --Funcion para colocar el - en el numerador. Modularizado por si se le da
   --un uso posterior. Solo se usa, de momento, en la division.
   function colocarSigno (X : fraccion_t) return fraccion_t is
      fraccionAux: fraccion_t;
   begin
      fraccionAux := X;
      fraccionAux.Num := X.Num * (-1);
      return fraccionAux;
   end;



   --Esta funcion calcula el mcd del numerador y denominador, para poder
   --dividirlos, y dejar la funcion reducida
   function reducir (X : fraccion_t) return fraccion_t is
      fraccionAux: fraccion_t;
      v1, v2, aux, resto : integer;
   begin

      fraccionAux := X;
      --Primero comprobamos que el numerador no sea 0
      if (X.Num /= 0) then
         --Guardamos el numerador en valor absoluto, y denominador primero.
         v1 := abs X.Num;
         v2 := X.Den;

         --Ahora comprobamos que el numerador sea mayor al denominador para
         --un paso posterior.
         if (v1<v2) then
            aux := v1;
            v1 := v2;
            v2 := aux;
         end if;

         --Ahora calculamos el MCD. Inicializamos el resto por el bucle. El MCD se
         --guardara en v1
         resto := 1;
         while (resto /= 0) loop
            resto := v1 mod v2;
            v1 := v2;
            v2 := resto;
         end loop;

         --Procedemos a reducir la fraccion
         fraccionAux.Num := (X.Num / v1);
         fraccionAux.Den := (X.Den / v1);
      end if;

      return fraccionAux;
   end;



   --Esta es la funcion del constructor
   function "/" (X, Y: Integer) return fraccion_t is
      fraccion : fraccion_t;
   begin

      --Primero debemos comprobar si el denominador es negativo. Si lo es,
      --ponemos el numerador negativo y el denominador positivo.
      if (Y < 0) then
         fraccion.Num := X * (-1);
         fraccion.Den := Y * (-1);
      else --Si el numerador es negativo pero el denominador no, lo dejamos asi.
         fraccion.Num := X;
         fraccion.Den := Y;
      end if;

      return reducir(fraccion);
   end;



   --Esta es la funcion de la suma
   function "+" (X, Y: fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin

      aux.Num := (X.Num * Y.Den) + (Y.Num * X.Den);
      aux.Den := X.Den * Y.Den;

      return reducir(aux);
   end;



   --Esta es la funcion de la resta
   function "-" (X, Y: fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin

      aux.Num := (X.Num * Y.Den) - (Y.Num * X.Den);
      aux.Den := X.Den * Y.Den;

      return reducir(aux);
   end;



  --Esta es la funcion de la multiplicacion
   function "*" (X, Y: fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin

      aux.Num := X.Num * Y.Num;
      aux.Den := X.Den * Y.Den;

      return reducir(aux);
   end;



   --Esta es la funcion del opuesto
   function "-" (X: fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin

      aux.Num := X.Num * (-1);
      aux.Den := X.Den;

      return reducir(aux);
   end;



   --Esta es la funcion de la division
   function "/" (X, Y: fraccion_t) return fraccion_t is
      aux: fraccion_t;
   begin

      aux.Num := X.Num * Y.Den;
      aux.Den := abs (X.Den * Y.Num);
      --El denominador en positivo. Si es negativo, llamamos a una funcion que
      --pone el signo - en el numerador.
      if ((X.Den * Y.Num) < 0) then
         aux := colocarSigno(aux);
      end if;

      return reducir(aux);
   end;



   --Funcion que nos retorna el numerador de una fraccion
   function Numerador (F: fraccion_t) return Integer is
      aux : integer;
   begin
      aux := F.Num;
      return aux;
   end;



   --Funcion que nos retorna el denominador de una fraccion
   function Denominador (F: fraccion_t) return Positive is
      aux : Positive;
   begin
      aux := F.Den;
      return aux;
   end;



end Fracciones;

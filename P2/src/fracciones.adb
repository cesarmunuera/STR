with Ada.Text_Io;use Ada.Text_Io;

package body Fracciones is

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

      return fraccion;
   end;



   --Esta es la funcion para mostrar los datos por pantalla
   procedure Escribir (F: fraccion_t) is
   begin
      Put_Line(F.Num'Image & "/" & F.Den'Image);
   end;



   --Esta funcion calcula el mcd del numerador y denominador, para poder
   --dividirlos, y dejar la funcion reducida
   function reducir (X : fraccion_t) return fraccion_t is
      fraccionAux1,  fraccionAux2: fraccion_t;
      v1, v2, aux, resto : integer;
   begin

      --Primero comprobamos que el denominador no sea negativo. No es necesario
      --para reducir las fracciones, pero es para dejarlas todas en el mismo
      --formato. Si es negativa, el - se lo queda el numerador.
      --Si es negativo, ponemos el - al numerador.
      fraccionAux2 := X;
      if (fraccionAux2.Den < 0) then
         fraccionAux2.Num := X.Num * (-1);
         fraccionAux2.Den := X.Den * (-1);
      end if;

      --Guardamos el numerador en valor absoluto, y denominador primero.
      v1 := abs fraccionAux2.Num;
      v2 := fraccionAux2.Den;

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
      fraccionAux1.Num := (X.Num / v1);
      fraccionAux1.Den := (X.Den / v1);

      return fraccionAux1;
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
      aux : fraccion_t;
   begin

      aux.Num := X.Num * Y.Den;
      aux.Den := X.Den * Y.Num;

      return reducir(aux);
   end;


end Fracciones;

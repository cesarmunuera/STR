with Ada.Text_Io; use Ada.Text_Io;
with Ada.Exceptions;

package body Fracciones is


   --Esta es la funcion para mostrar los datos por pantalla
   procedure Escribir (F: fraccion_t) is
   begin
      Put_Line(F.Num'Image & "/" & F.Den'Image);
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



   --Esta es la funcion del opuesto. Coloca el signo en el numerador.
   function "-" (X: fraccion_t) return fraccion_t is
      aux : fraccion_t;
   begin
      aux.Num := X.Num * (-1);
      aux.Den := X.Den;
      return reducir(aux);
   end;



   --Funcion que nos permite introducir nuevas fracciones por teclado
   procedure Leer (F: out fraccion_t) is
      numerador, denominador : integer;
      invalido : boolean;
      aux : fraccion_t;
      --Nos creamos un paquete para recoger los datos metidos por el usuario
      package Fracciones_ES is new Ada.Text_Io.Integer_Io(Integer);
   begin

      Put("Introduzca el numerador de la fraccion:");
      Fracciones_ES.Get(numerador);
      aux.Num := numerador;

      --Ahora debemos comprobar que el denominador no sea 0
      invalido := true;

      while (invalido) loop
         Put("Introduzca el denominador de la fraccion (NO PUEDE SER 0):");
         Fracciones_ES.Get(denominador);
         if (denominador = 0) then
            Put("Error. Introduzca el denominador de la fraccion (NO PUEDE SER 0):");
         elsif (denominador < 0) then
            invalido := false;
            aux.Den := abs(denominador);
            --Si el denominador es 0, llamamos a "-", que nos pone signo en
            --el numerador
            aux := -(aux);
         else
            invalido := false;
            aux.Den := denominador;
         end if;
      end loop;

      --Ahora procedemos a reducir la fraccion
      F := reducir(aux);
   end;



   --Esta es la funcion del constructor
   function "/" (X, Y: Integer) return fraccion_t is
      fraccion : fraccion_t;
      Indeterminacion: exception;
   begin

      --Primero debemos comprobar si el denominador es negativo. Si lo es,
      --ponemos el numerador negativo y el denominador positivo.
      if (Y < 0) then
         fraccion.Num := X * (-1);
         fraccion.Den := Y * (-1);
      elsif (Y = 0) then --El denominador no puede ser 0, retornamos excepcion
         fraccion.Num := 1;
         fraccion.Den := 1;
         raise Indeterminacion;
      else
         fraccion.Num := X;
         fraccion.Den := Y;
      end if;

      return reducir(fraccion);
   exception
      when Ocurrencia : Indeterminacion =>
         Put_line ("Indeterminacion, 0 en el denominador. Problema en constructor.");
         --Put (Ada.Exceptions.Exception_Information (Ocurrencia));
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

      --Primero debemos comprobar si tienen el mismo denominador. Si lo tienen,
      --solo restamos los numeradores. Soluciona simplificaciones cuando hay
      --un 0 en el numerador.
      if (X.Den = Y.Den) then
         aux.Num := X.Num - Y.Num;
         aux.Den := X.Den;
      else
         aux.Num := (X.Num * Y.Den) - (Y.Num * X.Den);
         aux.Den := X.Den * Y.Den;
      end if;

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



   --Esta es la funcion de la division
   function "/" (X, Y: fraccion_t) return fraccion_t is
      aux: fraccion_t;
      Indeterminacion: exception;
   begin

      aux.Num := X.Num * Y.Den;
      if ((X.Den * Y.Num) < 0) then
         aux.Den := abs (X.Den * Y.Num);
         --El denominador en positivo. Si es negativo, llamamos a una funcion que
         --pone el signo - en el numerador.
         aux := -(aux);
      elsif ((X.Den * Y.Num) = 0) then
         --Este es el caso de una indeterminacion, tener un 0 en el denominador.
         --Retornamos esto, en forma de muestra de una indeterminacion.
         --Tambien lanzamos una excepcion.
         aux.Num := 1;
         aux.Den := 1;
         raise Indeterminacion;
      end if;

      return reducir(aux);

   exception
      when Ocurrencia : Indeterminacion =>
         Put_line ("Indeterminacion, 0 en el denominador. Problema en division.");
         --Put (Ada.Exceptions.Exception_Information (Ocurrencia));
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



   --Funcion que compara dos fracciones
   function "=" (X, Y: fraccion_t) return Boolean is
      aux1, aux2 : fraccion_t;
      igual : Boolean;
   begin

      --Primero las dejamos reducidas
      aux1 := reducir(X);
      aux2 := reducir(Y);

      --Luego, comparamos primero un elemento, el denominador por ejemplo.
      if (aux1.Den = aux2.Den) then
         if (aux1.Num = aux2.Num) then
            igual := true;  --Mismo numerador y denominador
         else
            igual := false; --Solo mismo denominador
         end if;
      else
         igual := false;    --Solo mismo numerador
      end if;

      return igual;
   end;

end Fracciones;

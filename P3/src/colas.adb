with Ada.Text_Io,Ada.Unchecked_Deallocation;
use Ada.Text_Io;

package body Colas is

   --Funcion que nos dice si nuestra cola esta vacia
   function Esta_Vacia (La_Cola: cola_t) return Boolean is
   begin
      --Si apunta a null el primero, es que no tiene nungun elemento
      if (La_Cola.ptr_Primero = null) then
         return true;
      else
         return false;
      end if;
   end;



   --Funcion que nos dice si nuestra cola tiene algun elemento
   function Esta_Llena (La_Cola: cola_t) return Boolean is
   begin
      --Si esta vacia, ya no hay ningun elemento, por eso niego la salida
      return (not Esta_Vacia (La_Cola));
   end;



   --Funcion que nos mete un nuevo elemento a una cola dada
   procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t) is
      n : ref_nodo;
   begin
      --Nos creamos el nodo de forma dinamica
      n := new Nodo;
      --Le asignamos los datos
      n.Datos := el_Elemento;
      n.ptr_Siguiente := null;
      --Ahora comprobaremos si la cola esta vacia o tiene algun elemento
      if (Esta_Vacia (en_la_Cola)) then
         en_la_Cola.ptr_Primero := n;
         en_la_Cola.ptr_Último := n;
         --Los punteros de la cola al unico nodo, el que introducimos
      else
         --El siguiente del ultimo esta a null, pero ahora debe ser el nuevo nodo
         en_la_Cola.ptr_Último.ptr_Siguiente := n;
         --Ahora el ultimo nodo de la cola debe ser el nuevo nodo
         en_la_Cola.ptr_Último := n;
      end if;
   end;



   --Funcion que desencola una cola dada
   procedure Quitar (un_Elemento: out elemento_t; de_la_Cola: in out cola_t) is
      procedure borrar is new Ada.Unchecked_Deallocation(Nodo,ref_Nodo);
   begin
      --Primero comprobamos que la cola tenga elementos
      if (Esta_Llena (de_la_Cola)) then
         --Ahora tenemos que ver si solo tiene un elemento
         if (de_la_Cola.ptr_Primero = de_la_Cola.ptr_Último) then
            un_Elemento := de_la_Cola.ptr_Primero.Datos;
            borrar(de_la_Cola.ptr_Primero);
            --Salvamos el elemento a borrar y lo borramos
         else
            un_Elemento := de_la_Cola.ptr_Primero.Datos;
            de_la_Cola.ptr_Primero := de_la_Cola.ptr_Primero.ptr_Siguiente;
            --borrar(de_la_Cola.ptr_Primero);
            --Lo mismo, pero ahora el primero es el siguiente del antiguo primero
         end if;
      end if;
   end;



   --Funcion que copia una cola dada
   procedure Copiar (Origen: cola_t; Destino:in out cola_t) is
      elemento : elemento_t;
      nodoAux :ref_nodo;
   begin
      nodoAux := new Nodo;

      --Primero vaciamos la cola destino
      while (Esta_Llena(Destino)) loop
         Quitar(elemento, Destino);
      end loop;

      --Ahora comenzamos a copiar
      nodoAux := Origen.ptr_Primero;
      while (nodoAux /= null) loop
         Poner(nodoAux.Datos, Destino);
         nodoAux := nodoAux.ptr_Siguiente;
         --Metemos el primer nodo, y actualizamos al siguiente
      end loop;
   end;



   --Funcion que compara 2 colas
   function "="(La_Cola, Con_La_Cola: cola_t) return Boolean is
      nodoAux1, nodoAux2 : ref_nodo;
   begin
      nodoAux1 := new Nodo;
      nodoAux2 := new Nodo;

      --Si ambas estan vacias, son iguales
      if (Esta_Vacia(La_Cola) and Esta_Vacia(Con_La_Cola)) then
         return true;
      else
         nodoAux1 := La_Cola.ptr_Primero;
         nodoAux2 := Con_La_Cola.ptr_Primero;
         --Si uno esta a null, el otro no puede estarlo por el primer if, y son distintas
         if ((nodoAux1 = null) or (nodoAux2 = null)) then
            return false;
         end if;

         --Ahora comparamos elemento a elemento
         while (nodoAux1.Datos = nodoAux2.Datos) loop
            nodoAux1 := nodoAux1.ptr_Siguiente;
            nodoAux2 := nodoAux2.ptr_Siguiente;

            if ((nodoAux1 = null) and (nodoAux2 = null)) then
               return true;
               --Si ambos estan a null, es que han acabado y son iguales
            elsif ((nodoAux1 = null) or (nodoAux2 = null)) then
               return false;
               --Si uno esta a null, el otro no, y son distintos
            end if;
         end loop;
         --Si hemos salido del bucle, es que son distintos
         return false;

      end if;
   end;


   --Funcion que muestra el contenido de una cola
   procedure MostrarCola (La_Cola: cola_t) is
   nodoAux :ref_nodo;
   begin
      nodoAux := new Nodo;
      --Mientras que sea null, imprimimos y actualizamos
      nodoAux := La_Cola.ptr_Primero;
      while (nodoAux /= null) loop
         Put(ToString(nodoAux.Datos));
         nodoAux := nodoAux.ptr_Siguiente;
      end loop;
      new_line;
   end;

end Colas;

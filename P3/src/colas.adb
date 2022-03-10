with Ada.Text_Io,Ada.Unchecked_Deallocation;
use Ada.Text_Io;

package body Colas is

   --Funcion que nos dice si nuestra cola esta vacia
   function Esta_Vacia (La_Cola: cola_t) return Boolean is
   begin
      --Si apunta a null el primero, es que no tiene nungun elemento
      if (cola_t.ptr_Primero = null) then
         return true;
      else
         return false;
      end if;
   end;



   --Funcion que nos dice si nuestra cola tiene algun elemento
   function Esta_Llena (La_Cola: cola_t) return Boolean is
   begin
      --Si esta vacia, ya no hay ningun elemento, por eso niego la salida
      return (�Esta_Vacia (La_Cola))
   end;



   --Funcion que nos mete un nuevo elemento a una cola dada
   procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t) is
      n :Nodo;
   begin
      --Nos creamos el nodo de forma dinamica
      n := new Nodo;
      --Le asignamos los datos
      n.Datos := el_Elemento;
      n.ptr_Siguiente := null;
      --Ahora comprobaremos si la cola esta vacia o tiene algun elemento
      if (Esta_Vacia (La_Cola)) then
         en_la_Cola.ptr_Primero := n;
         en_la_Cola.ptr_�ltimo := n;
         --Los punteros de la cola al unico nodo, el que introducimos
      else
         --El siguiente del ultimo esta a null, pero ahora debe ser el nuevo nodo
         en_la_Cola.ptr_�ltimo.ptr_Siguiente := n;
         --Ahora el ultimo nodo de la cola debe ser el nuevo nodo
         en_la_Cola.ptr_�ltimo := n;
      end if;
   end;



   --Funcion que desencola una cola dada
   procedure Quitar (un_Elemento: out elemento_t; de_la_Cola: in out cola_t) is
      procedure borrar is new Ada.Unchecked_Deallocation(Nodo,ref_Nodo);
   begin
      --Primero comprobamos que la cola tenga elementos
      if (Esta_Llena (de_la_Cola)) then
         --Ahora tenemos que ver si solo tiene un elemento
         if (de_la_Cola.ptr_Primero = de_la_Cola.ptr_�ltimo) then
            un_Elemento := de_la_Cola.ptr_Primero;
            borrar(de_la_Cola.ptr_Primero);
            --Salvamos el elemento a borrar y lo borramos
            --Primero y ultimo a null?
         else
            un_Elemento := de_la_Cola.ptr_Primero;
            de_la_Cola.ptr_Primero := de_la_Cola.ptr_Primero.ptr_Siguiente;
            borrar(de_la_Cola.ptr_Primero);
            --Lo mismo, pero ahora el primero es el siguiente del antiguo primero
         end if;
      end if;
   end;



   --Funcion que nos muestra el contenido de una cola
   procedure MostrarCola (La_Cola: cola_t) is
   begin

   end;






end Colas;

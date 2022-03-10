with Ada.Text_Io; use Ada.Text_Io;
with Ada.Exceptions;

package body Colas is

   function Está_Vacía (La_Cola: cola_t) return Boolean is
   begin
      if (cola_t.ptr_Primero = null) then
         return true;
      else
         return false;
      end if;
   end;


   procedure Poner (el_Elemento: elemento_t; en_la_Cola: in out cola_t) is
      n :Nodo;
   begin
      n := new Nodo;

      n.Datos := el_Elemento;
      n.ptr_Siguiente := en_la_Cola.ptr_Último;
      en_la_Cola.ptr_Último := n;

   end;



end Colas;

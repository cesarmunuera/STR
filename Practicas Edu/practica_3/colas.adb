with Ada.Text_Io,Ada.Unchecked_Deallocation;
use Ada.Text_Io;

package body Colas is

--COMPRUEBA QUE NO HAYA NINGUN ELEMENTO EN LA COLA
	function Esta_Vacia (La_Cola: Cola) return Boolean is
	begin
		if (La_Cola.ptr_Primero = null) then --Si no hay un primer elemento significa que no hay elementos
			return true;
		else
			return false;
		end if;
	end Esta_Vacia;



--COMPRUEBA SI HAY ALGUN ELEMENTO EN LA COLA
	function Esta_Llena (La_Cola: Cola) return Boolean is
	begin
		if (Esta_Vacia(La_Cola)) then --Que haya algo, significa que no esta vacia
			return false;
		else
			return true;
		end if;
	end Esta_Llena;



--COMPROBAMOS SI DOS COLAS SO IGUALES
	function "=" (La_Cola, Con_La_Cola: Cola) return Boolean is
		nodo1,nodo2: ref_Nodo;
	begin
		if (Esta_Vacia(La_Cola) and Esta_Vacia(Con_La_Cola)) then
			return true; --Si ambas estan vacias son iguales
		elsif ((Esta_Vacia(La_Cola) and Esta_Llena(Con_La_Cola)) or (Esta_Llena(La_Cola) and Esta_Vacia(Con_La_Cola))) then
			return false; --Si una de las dos esta vacia y la otra no, no son iguales
		end if;
		nodo1 := La_Cola.ptr_Primero;
		nodo2 := Con_La_Cola.ptr_Primero;

		while (nodo1.Datos = nodo2.Datos) loop --Comprobamos elemento a elemento si son iguales
			nodo1:= nodo1.ptr_Siguiente;
               	 	nodo2:= nodo2.ptr_Siguiente;
			if (nodo1 = null and nodo2 = null) then
				return true; --Si ambas llegan a null al mismo tiempo sin salir del bucle son iguales
			end if;
		end loop;
		return false; --Si sale del bucle significa que no son iguales
	end "=";



--METEMOS UN NUEVO ELEMENTO
	procedure Poner (el_Elemento: Elementos; en_la_Cola: in out Cola) is
		nodoAux: ref_Nodo;
	begin
		nodoAux := new Nodo'(el_Elemento,null); --Creamos un nuevo nodo con el elemento que queremos
		if Esta_Vacia(en_la_Cola) then --Si esta vacia, el primer y el ultimo elemento sera el mismo
			en_la_Cola.ptr_Primero := nodoAux;
			en_la_Cola.ptr_Ultimo := nodoAux;
		else
			en_la_Cola.ptr_Ultimo.ptr_Siguiente := nodoAux; --El ultimo apunta al nuevo nodo
			en_la_Cola.ptr_Ultimo := nodoAux; --El nuevo nodo se convierte en el ultimo, apuntado por el penultimo
		end if;
	end Poner;



--QUITAMOS UN ELEMENTO
	procedure Quitar (un_Elemento: out Elementos; de_la_Cola: in out Cola) is
		nodoAux: ref_Nodo;
		procedure borrar is new Ada.Unchecked_Deallocation(Nodo,ref_Nodo);
	begin
		if Esta_Llena(de_la_Cola) then --Comprobamos que hay elementos que eliminar, sino no hace nada
			if (de_la_Cola.ptr_Primero = de_la_Cola.ptr_Ultimo) then --Si solo hay un elemento no hay que asignar
				un_Elemento := de_la_Cola.ptr_Primero.Datos; --un nuevo elemento a primero pues se queda vacia
				borrar(de_la_Cola.ptr_Primero); --Lo borramos
			else
				nodoAux := de_la_Cola.ptr_Primero; --Cogemos el nodo a eliminar
				un_Elemento := de_la_Cola.ptr_Primero.Datos;
				de_la_Cola.ptr_Primero := de_la_Cola.ptr_Primero.ptr_Siguiente; --Asignamos un nuevo primero
				borrar(nodoAux); --Borramos el que era el primer elemento
			end if;
		end if;
    	end Quitar;



--COPIAMOS COLAS
	procedure Copiar (Origen: Cola; Destino: in out Cola) is
		nodoAux: ref_Nodo;
		dato: Elementos; --Si hay que eliminar los elementos de la otra cola hay que pasarle un elemento
	begin
		while (Esta_Llena(Destino)) loop --Comprobamos que no contenga nada la cola
			Quitar(dato,Destino); --Si hay algo la vaciamos para que contengan los mismos elementos
		end loop;
		if Esta_Llena(Origen) then --Comprobamos que haya elementos que copiar, si no los hay no se hace nada       
			nodoAux:= Origen.ptr_Primero;
			while nodoAux/= null loop --Recorremos toda la cola
				Poner(nodoAux.Datos,Destino); --Copiamos el elemento
				nodoAux := nodoAux.ptr_Siguiente; --Seleccionamos el siguiente
			end loop;
		end if;
	end Copiar;


end Colas;









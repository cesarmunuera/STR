generic
	type Elementos is private;

package Colas is 
	type Cola is limited private;

	procedure Poner (el_Elemento: Elementos; en_la_Cola: in out Cola);
	procedure Quitar (un_Elemento: out Elementos; de_la_Cola: in out Cola);
	function Esta_Vacia (La_Cola: Cola) return Boolean;
	function Esta_Llena (La_Cola: Cola) return Boolean;

	procedure Copiar (Origen: Cola; Destino: in out Cola);
	function "="(La_Cola, Con_La_Cola: Cola) return Boolean;

private

	--Definicion del tipo "Cola"
	--En esta ocasion se implementa una cola dinamica

	type Nodo;
	type ref_Nodo is access Nodo;
	type Nodo is record
		Datos: Elementos;
		ptr_Siguiente: ref_Nodo;
	end record;
	type Cola is record
		ptr_Primero,ptr_Ultimo: ref_Nodo;
	end record;
end Colas;

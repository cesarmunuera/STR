generic
   type Real    is digits <>;
   type Entrada is digits <>;
   type Salida  is digits <>;
package body PID is
	procedure Programar (el_Controlador: in out Controlador;
                            Kp, Ki, Kd:        Real) is
	begin
		el_Controlador.Kp := Kp;
		el_Controlador.Ki := Ki;
		el_Controlador.Kd := Kd;
	end Programar;
                
   	procedure Controlar(con_el_Controlador: in out Controlador;
                                     R, C:        Entrada;
                                        U: out    Salida) is

	e,Tp,Ti,Td: Real;
		
	begin
		e := R-C
		con_el_Controlador.S_Anterior:=con_el_Controlador.S_Anterior+E;

		--termino proporcional
		Tp:= con_el_Controlador.Kp * e;
		--termino integral
		Ti:= con_el_Controlador.Ki * con_el_Controlador.S_Anterior;
		--termino deritivativo
		Td:= con_el_Controlador.Kd * (e-con_el_Controlador.Error_Anterior);
		--calculamos u
		U:= (p+i+d);
		con_el_Controlador.S_Anterior:=con_el_Controlador.S_Anterior+E;
		con_el_Controlador.Error_Anterior:=e;

	end Controlar;

end PID;

with  Ada.Real_Time, Sensor, Calefactor, PID;
use   Ada.Real_Time, Sensor, Calefactor;
package body PID is
	procedure Programar (el_Controlador: in out Controlador; Kp, Ki, Kd: Real) is
	begin
		el_Controlador.Kp := Kp;
		el_Controlador.Ki := Ki;
		el_Controlador.Kd := Kd;
	end Programar;
    
   	procedure Controlar(con_el_Controlador: in out Controlador; R, C: Entrada; U: out Salida) is

	Tp,Ti,Td,err: Real;		
	begin
		--error
		err := Real(R-C);
		--termino proporcional
		Tp := con_el_Controlador.Kp * err;		
		--termino integral
		Ti := con_el_Controlador.Ki * con_el_Controlador.S_Anterior;	
		--termino deritivativo
		Td := con_el_Controlador.Kd * (err-con_el_Controlador.Error_Anterior);		
		--entrada de control del proceso
		U := Salida(Tp+Ti+Td);
		--actualizamos datos
		con_el_Controlador.S_Anterior := con_el_Controlador.S_Anterior + err;
		con_el_Controlador.Error_Anterior := err;

	end Controlar;

end PID;

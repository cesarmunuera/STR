with Ada.Text_IO;             use Ada.Text_IO;
with GNAT.Sockets;            use GNAT.Sockets;
with Ada.Calendar;		use Ada.Calendar;
with Ada.Streams;
with Ada.Strings.Unbounded;
with Ada.Numerics.Elementary_Functions;
with Ada.Float_Text_Io; use Ada.Float_Text_Io;

use type Ada.Streams.Stream_Element_Count;
use Ada.Numerics.Elementary_Functions;

with Ada.Text_Io, Ada.Real_Time;


procedure Vcv is

	package Ent_ES is new Integer_IO(Integer);


	Client  : Socket_Type;
	Address : Sock_Addr_Type;
	Channel : Stream_Access;

	Send   : String := (1 => ASCII.CR, 2 => ASCII.LF,
                       3 => ASCII.CR, 4 => ASCII.LF);
	Offset : Ada.Streams.Stream_Element_Count;
	Data   : Ada.Streams.Stream_Element_Array (1 .. 1);

	RetMsg : Ada.Strings.Unbounded.Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;


	ControlMsg : Ada.Strings.Unbounded.Unbounded_String := Ada.Strings.Unbounded.Null_Unbounded_String;

	type err_ang_t is digits 3 range -3.15 .. 3.15;
	type err_lat_t is digits 4 range -99.99 .. 99.99;
	type velocidad_t is digits 5 range 0.00 .. 500.00;
	type distancia_t is digits 6 range -9999.00 .. 9999.0;
	type volante_t is digits 3 range -1.0 .. 1.0;
	type accFreno_t is digits 3 range -1.0 .. 1.0;
	type radio_t is digits 7 range 0.0 .. 99999.99;

	c : Character;

	j : Integer := 1;
	count : Integer := 0;


	 --Kp, Ki, Kd : Float;

	 --us :Float;

	--D_err_lat : err_lat_t;

	Err_ang : err_ang_t;
	Err_lat, Err_lat_ant: err_lat_t;
	Curvatura, CurvaturaSig, Tipo, TipoSig : Float;

	velocidad : velocidad_t;
	dist, distSig : distancia_t;
	refVelocidad : velocidad_t;

	volante : volante_t;
	--acelFreno : accFreno_t;

	--y, cx, sx, ang, fang: Float;

	--Variables del alumno
	radioCurvatura : Float;




begin

	GNAT.Sockets.Initialize;  -- initialize a specific package
	Create_Socket (Client);
	Address.Addr := Inet_Addr("127.0.0.1");
	Address.Port := 12321;

	Connect_Socket (Client, Address);
	Channel := Stream (Client);

	--Kp:=0.02;
	--Kd:=0.01;


	-- Esta es la cadena de configuraci�n. Cambiar los n�meros para los distintos modos
	String'Write (Channel, "Controller init request 32" & Send);


	Curvatura := 0.0; CurvaturaSig := 1.0; distSig:=0.0; velocidad := 0.0;

	while Curvatura/=0.0 or CurvaturaSig /= 0.0 or distSig /= 0.0 or velocidad/=0.0  loop

		count :=0;
     		ControlMsg := Ada.Strings.Unbounded.Null_Unbounded_String;
     		RetMsg := Ada.Strings.Unbounded.Null_Unbounded_String;

     	loop
		Ada.Streams.Read (Channel.All, Data, Offset);
		Ada.Strings.Unbounded.Append (Source => RetMsg, New_Item => Character'Val (Data(1)));
	exit when Character'Val (Data(1)) = '*' ;
     	end loop;


     ---- Lectura de los datos que manda el coche
     	--Ada.Text_IO.Put_Line (Ada.Strings.Unbounded.To_String (RetMsg));

      	j:=1;

      	for i in Ada.Strings.Unbounded.To_String (RetMsg)'Range loop
		c := Ada.Strings.Unbounded.To_String (RetMsg)(i);

		if (c = ';' or c = '*') then
	  		count := count + 1;

	  		case count is
	    		when 1 => Err_ang := err_ang_t'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 2 => Err_lat := err_lat_t'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 3 => Tipo := Float'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 4 => Curvatura := Float'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 5 => dist := distancia_t'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 6 => TipoSig := Float'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 7 => CurvaturaSig := Float'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 8 => distSig := distancia_t'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when 9 => velocidad := velocidad_t'Value(Ada.Strings.Unbounded.To_String (RetMsg)(j..i-1));
	    		when others => NULL;
	  		end case;

	  		j := i+1;
		end if;
    	end loop;

    	-- Sacamos por pantalla lo que manda el coche
    	--Ada.Text_IO.Put_Line("You gave me " & err_ang_t'image(Err_ang) &  " " & err_lat_t'image(Err_lat) &  " " & Float'image(Tipo) &  " " & Float'image(Curvatura) 		& " " & distancia_t'image(dist)  & " " & Float'image(TipoSig) & " " & Float'image(CurvaturaSig) & " " & distancia_t'image(distSig)& " " & velocidad_t'image(velocidad));


	--Imprimimos datos relevantes

	--Put_Line("El tipo actual es: " & Float'image(Tipo));
	--Put_Line("El siguiente tipo es: " & Float'image(TipoSig));
	--Put_Line("Y la distancia es: " & distancia_t'image(dist));
	--Put_Line("Velocidad actual de " & velocidad_t'image(velocidad));
	--Put_Line("El radio de curvatura es: " & Float'image(Curvatura));




	--------------------------------------------------------------------------------------------------------------------------
    	-- Aqui va vuestro c�digo de control. Con los datos le�dos ten�is que escribir en volante y refVelocidad vuestros comandos.


	-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ MODO 32 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	if ((Err_ang > 0.0) and (Err_lat < 0.0)) then
		Put_Line("El coche est� en la izquierda, pero va hacia la derecha ++++++");
		if ((Err_lat > -3.5) and (Err_lat < 0.0)) then
			refVelocidad := 45.0;
			volante := 0.05;
		else
			Put_Line("");
			refVelocidad := 43.5;
		end if;

	elsif ((Err_ang < 0.0) and (Err_lat > 0.0)) then
		Put_Line("El coche est� en la derecha, pero va hacia la izquierda ++++++");
		if ((Err_lat > 0.0) and (Err_lat < 3.5)) then
			refVelocidad := 45.0;
			volante := -0.05;
		else
			Put_Line("");
			refVelocidad := 43.5;
		end if;

	elsif ((Err_ang > 0.0) and (Err_lat >= 0.0)) then
		Put_Line("El coche se va hacia la derecha, desde la derecha");
		if ((0.0 <= Err_lat) and (Err_lat <= 7.0)) then
			volante := 0.1;
			refVelocidad := 43.5;
		elsif ((7.1 <= Err_lat) and (Err_lat <= 14.0)) then
			volante := 0.125;
			refVelocidad := 43.0;
		elsif ((14.1 <= Err_lat) and (Err_lat <= 20.0)) then
			volante := 0.15;
			refVelocidad := 42.5;
		elsif ((20.1 <= Err_lat)) then
			volante := 0.2;
			refVelocidad := 40.5;
		end if;

	elsif ((Err_ang < 0.0) and (Err_lat <= 0.0)) then
		Put_Line("El coche se va hacia la izquierda, desde la izquierda");
		if ((0.0 >= Err_lat) and (Err_lat >= -7.0)) then
			volante := -0.1;
			refVelocidad := 43.5;
		elsif ((-7.1 >= Err_lat) and (Err_lat >= -14.0)) then
			volante := -0.125;
			refVelocidad := 43.0;
		elsif ((-14.1 >= Err_lat) and (Err_lat >= -20.0)) then
			volante := -0.15;
			refVelocidad := 42.5;
		elsif ((-20.1 >= Err_lat)) then
			volante := -0.3;
			refVelocidad := 40.5;
		end if;

	end if;


	-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++ MODO 22 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	if ((Err_ang > 0.0) and (Err_lat < 0.0)) then
		--Put_Line("El coche est� en la izquierda, pero va hacia la derecha ++++++");
		if ((Err_lat > -3.5) and (Err_lat < 0.0)) then
			--refVelocidad := 55.0;
			radioCurvatura := 120.0;
		else
			Put_Line("");
			--refVelocidad := 53.5;
		end if;

	elsif ((Err_ang < 0.0) and (Err_lat > 0.0)) then
		--Put_Line("El coche est� en la derecha, pero va hacia la izquierda ++++++");
		if ((Err_lat > 0.0) and (Err_lat < 3.5)) then
			--refVelocidad := 55.0;
			radioCurvatura := -120.0;
		else
			Put_Line("");
			--refVelocidad := 53.5;
		end if;

	elsif ((Err_ang > 0.0) and (Err_lat >= 0.0)) then
		Put_Line("El coche se va hacia la derecha, desde la derecha");
		if ((0.0 <= Err_lat) and (Err_lat <= 7.0)) then
			radioCurvatura := 85.0;
			--refVelocidad := 53.5;
		elsif ((7.1 <= Err_lat) and (Err_lat <= 14.0)) then
			radioCurvatura := 80.0;
			--refVelocidad := 52.5;
		elsif ((14.1 <= Err_lat) and (Err_lat <= 20.0)) then
			radioCurvatura := 75.0;
			refVelocidad := 51.5;
		elsif ((20.1 <= Err_lat)) then
			radioCurvatura := 60.0;
			--refVelocidad := 48.5;
		end if;

	elsif ((Err_ang < 0.0) and (Err_lat <= 0.0)) then
		Put_Line("El coche se va hacia la izquierda, desde la izquierda");
		if ((0.0 >= Err_lat) and (Err_lat >= -7.0)) then
			radioCurvatura := -85.0;
			--refVelocidad := 53.5;
		elsif ((-7.1 >= Err_lat) and (Err_lat >= -14.0)) then
			radioCurvatura := -80.0;
			--refVelocidad := 52.5;
		elsif ((-14.1 >= Err_lat) and (Err_lat >= -20.0)) then
			radioCurvatura := -75.0;
			--refVelocidad := 51.5;
		elsif ((-20.1 >= Err_lat)) then
			radioCurvatura := -60.0;
			--refVelocidad := 48.5;
		end if;


	end if;
    	--------------------------------------------------------------------------------------------------------------------------







    	--- Se env�an los comandos al coche
   	Ada.Strings.Unbounded.Append (Source => ControlMsg, New_Item => volante_t'image(volante));
   	--Ada.Strings.Unbounded.Append (Source => ControlMsg, New_Item => Float'image(radioCurvatura));
   	Ada.Strings.Unbounded.Append (Source => ControlMsg, New_Item => ';');
   	Ada.Strings.Unbounded.Append (Source => ControlMsg, New_Item => velocidad_t'image(refVelocidad));
   	Ada.Strings.Unbounded.Append (Source => ControlMsg, New_Item => '*');

   	String'Write (Channel,  Ada.Strings.Unbounded.To_String (ControlMsg) & Send);

 	end loop;
	--

 	--- Comando para terminar la carrera

   	String'Write (Channel, "Controller end request 44" & Send);

end Vcv;

with Ada.Text_Io;
use Ada.Text_Io;

procedure p1 is
 
	type temperatura_t is delta 0.1 range -25.0..75.0; --Definimos los nuevos tipos
	subtype dia_t is integer range 1..31;
	subtype ano_t is integer range 1900..2100;
	type mes_t is (enero,febrero,marzo,abril,mayo,junio,julio,agosto,septiembre,octubre,noviembre,diciembre);

	package Temperatura_Es is new Ada.Text_Io.Fixed_Io(temperatura_t); --Creamos los package para poder hacer entrada/salida
	package Dias_Es is new Ada.Text_Io.Integer_Io(dia_t);
	package Mes_Es is new Ada.Text_Io.Enumeration_Io(mes_t);
	package Ano_Es is new Ada.Text_Io.Integer_Io(ano_t);
	package NumFechas_Es is new Ada.Text_Io.Integer_Io(Integer);
	

	type Fecha_t is record --Definimos el record que almacena la fecha

	    	dia: dia_t;
	    	mes: mes_t;
	    	ano: ano_t;
	end record;

	type Registro_t is record --Definimos el record que almacena todos los datos

		temperatura: temperatura_t;
		fecha: Fecha_t;
		
	end record;
	
	temperatura: temperatura_t; --Definimos las variables	
	dia: dia_t;
	mes: mes_t;
	ano: ano_t;
	numFechas: Integer;
	diaFrio: Registro_t;
	diaCalor: Registro_t;
	temperaturaMedia: temperatura_t;
	diaAntiguo: Registro_t;
	diaReciente: Registro_t;

	type calendario is array (integer range<>) of Registro_t; --Definimos el array y los punteros necesarios
	type puntero_calendario is access calendario;
	type puntero_fecha is access Fecha_t;
	
	pointerCalendario: puntero_calendario; --Creamos los punteros
	pointerFecha: puntero_fecha;


	function minimaTemperatura(calendario: puntero_calendario) return Registro_t is --Funcion que calcula la menor temperatura

		menor: Registro_t;

		begin

    			menor := calendario(1);

    			for i in 2..calendario'Length loop

				if calendario(i).temperatura < menor.temperatura then --Compara temperaturas

		    			menor := calendario(i);
				end if;
   			end loop;
	return menor;
	end minimaTemperatura;


	function maximaTemperatura(calendario: puntero_calendario) return Registro_t is --Funcion que calcula la mayor temperatura

		mayor: Registro_t;

		begin

			mayor := calendario(1);

			for i in 2..calendario'Length loop

				if calendario(i).temperatura > mayor.temperatura then --Compara temperaturas

					mayor := calendario(i);
				end if;
			end loop;
	return mayor;
	end maximaTemperatura;



	function mediaTemperatura(calendario: puntero_calendario) return temperatura_t is --Funcion que calcula la temperatura media
	
		media: 	temperatura_t;

		begin
			media := calendario(1).temperatura/calendario'Length;

			
			for i in 2..calendario'Length loop
	 		
				media := media + calendario(i).temperatura/calendario'Length; --Calcula la media
			end loop;

		return media;
		end mediaTemperatura;
	

	function reciente(calendario: puntero_calendario) return Registro_t is --Funcion que escoge la fecha mas reciente
		
		joven: Registro_t;
		
		begin
			joven := calendario(1);

			for i in 2..calendario'Length loop
				
				if calendario(i).fecha.ano > joven.fecha.ano then --Compara los anos
				
					joven := calendario(i);
				
				elsif calendario(i).fecha.ano = joven.fecha.ano then 

					if calendario(i).fecha.mes > joven.fecha.mes then --Compara los meses

						joven := calendario(i);
				
					elsif calendario(i).fecha.mes = joven.fecha.mes then

						if calendario(i).fecha.dia > joven.fecha.dia then --Compara los dias
							
							joven := calendario(i);
						end if;
					end if;
				end if;
				
			end loop;
	return joven;
	end reciente;


	function antiguo(calendario: puntero_calendario) return Registro_t is --Funcion que escoge la fecha mas antigua
		
		viejo: Registro_t;
		
		begin
			viejo := calendario(1);

			for i in 2..calendario'Length loop
				
				if calendario(i).fecha.ano < viejo.fecha.ano then --Compara los anos
				
					viejo := calendario(i);
				
				elsif calendario(i).fecha.ano = viejo.fecha.ano then

					if calendario(i).fecha.mes < viejo.fecha.mes then --Compara los meses

						viejo := calendario(i);
					
				
					elsif calendario(i).fecha.mes = viejo.fecha.mes then

						if calendario(i).fecha.dia < viejo.fecha.dia then --Compara los dias
							
							viejo := calendario(i);
						end if;
					end if;
				end if;
				
			end loop;
	return viejo;
	end antiguo;

				
	begin

		Put_Line("¿Cuantas fechas quieres registrar?:"); --Elegimos cuantas fechas queremos introdcuir
		NumFechas_Es.Get(numFechas);
		pointerCalendario := new calendario(1..numFechas);

			calendario'Range
		for i in 1..numFechas loop
			
			Put_Line("Nueva fecha:");
			New_Line;
			Put_Line ("¿Que dia?"); --Elegimos el dia
			Dias_Es.Get(dia);
			New_Line;
			Put_Line("¿De que mes?"); --Elegimos el mes
			Mes_Es.Get(mes);
			New_Line;
			Put_Line ("¿En el ano?"); --Elegimos el ano
			Ano_Es.Get(ano);
			New_Line;
			Put_Line ("¿Cual fue la temperatura?"); --Elegimos la temperatura
			Temperatura_Es.Get(temperatura);
			New_Line;
			New_Line;



			pointerFecha := new Fecha_t'(dia_t(dia),mes_t(mes),ano_t(ano)); --Almacenamos los datos de la fecha
			pointerCalendario(i) := (temperatura_t(temperatura),pointerFecha.all); --Almacenamos la fecha y la temperatura

		end loop;
		
		

		Put("La fecha en la que se registro la menor temperatura fue:");
		diaFrio := minimaTemperatura(pointerCalendario); --Devuelve la fecha mas fria
		Dias_Es.Put(diaFrio.fecha.dia); --Muestra el dia
		Put(" de ");
		Mes_Es.Put(diaFrio.fecha.mes); --Muestra el mes
		Put(" del año ");
		Ano_Es.Put(diaFrio.fecha.ano); --Muestra el ano
		Put(" con ");
		Temperatura_Es.Put(diaFrio.temperatura); --Muestra la temperatura
		Put(" grados");
		
		New_Line;
		New_Line;

		Put("La fecha en la que se registro la mayor temperatura fue:");
		diaCalor := maximaTemperatura(pointerCalendario); --Devuelve la fecha mas calurosa
		Dias_Es.Put(diaCalor.fecha.dia); --Muestra el dia
		Put(" de ");
		Mes_Es.Put(diaCalor.fecha.mes); --Muestra el mes
		Put(" del año ");
		Ano_Es.Put(diaCalor.fecha.ano); --Muestra el ano
		Put(" con ");
		Temperatura_Es.Put(diaCalor.temperatura); --Muestra la temperatura
		Put(" grados");

		New_Line;
		New_Line;


		diaAntiguo := antiguo(pointerCalendario);
		diaReciente := reciente(pointerCalendario);
		
	
		Put("La temperatura media de todos los dias registrados desde el ");
		Dias_Es.Put(diaAntiguo.fecha.dia); --Muestra el dia mas antiguo
		Put(" de ");
		Mes_Es.Put(diaAntiguo.fecha.mes);
		Put(" del año ");
		Ano_Es.Put(diaAntiguo.fecha.ano);
		Put(" hasta el ");
		Dias_Es.Put(diaReciente.fecha.dia); --Muestra el dia mas reciente
		Put(" de ");
		Mes_Es.Put(diaReciente.fecha.mes);
		Put(" del año ");
		Ano_Es.Put(diaReciente.fecha.ano);
		Put_Line(" es:");
		
		temperaturaMedia := mediaTemperatura(pointerCalendario); --Devuelve la media de las temperaturas
		Temperatura_Es.Put(temperaturaMedia); --Muestra la temperatura media
		Put(" grados");

end p1;

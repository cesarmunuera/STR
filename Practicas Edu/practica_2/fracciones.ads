package Fracciones is
	
	type Fraccion is private;

	function "+" (X, Y: Fraccion) return Fraccion;
	function "-" (X: Fraccion) return Fraccion;
	function "-" (X, Y: Fraccion) return Fraccion;
	function "*" (X, Y: Fraccion) return Fraccion;
	function "/" (X, Y: Fraccion) return Fraccion;
	function "=" (X, Y: Fraccion) return Boolean;

	procedure Leer (F: out Fraccion);
	procedure Escribir (F: Fraccion);

	function "/" (X, Y: Integer) return Fraccion;

	function Numerador (F: Fraccion) return Integer;
	function Denominador(F: Fraccion) return Positive;

	private
		
		type Fraccion is record
		
			Num: Integer;
			Den: Positive;
		end record;
end Fracciones;

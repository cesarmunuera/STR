type ref_Procedimiento is access procedure;
type array_ref_Procedimiento is array (Positive range <>) of ref_Procedimiento;
type array_Tiempos is array (Positive range <>) of Natural;
procedure Medir (Procedimientos: array_ref_Procedimiento; Tiempos : out array_Tiempos);

--type ref_Procedimiento is access procedure;

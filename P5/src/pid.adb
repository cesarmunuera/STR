with Ada.Text_IO; use Ada.Text_IO;
package body PID is

   procedure Programar (el_Controlador: in out Controlador; Kp, Ki, Kd: Real) is
   begin
      el_Controlador.Kp := Kp;
      el_Controlador.Ki := Ki;
      el_Controlador.Kd := Kd;
   end Programar;

   procedure Controlar(con_el_Controlador: in out Controlador; R, C: Entrada; U: out Salida) is
      error: Real;
      --Ts : Real;

   begin
      --Ts := 1.0;

      --Calculamos el error actual
      error := Real(R-C);

      --No uso, en la ecuacion, el valor de TS ya que es 1. Esta ecuacion la obtenemos del enunciado, sabiendo que
      --Ki es Kp / Ti, y Kd es Kp * Td. Estos valores se calculan en principal.adb.
      U := Salida((con_el_Controlador.Kp * error) + (con_el_Controlador.Ki * con_el_Controlador.S_Anterior)
                  + (con_el_Controlador.Kd * (error - con_el_Controlador.Error_Anterior)));

      con_el_Controlador.S_Anterior := con_el_Controlador.S_Anterior + error;
      con_el_Controlador.Error_Anterior := error;
   end Controlar;

end PID;

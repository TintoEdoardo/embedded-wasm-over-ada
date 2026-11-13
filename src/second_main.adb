pragma Profile (Ravenscar);

with Ada.Text_IO;

with Export_Functions;
pragma Unreferenced (Export_Functions);

procedure Second_Main is

   Twelve : Integer := 0;

   function start_the_interpreter return Integer
     with Import => True,
     Convention => C;

begin
   loop
      Ada.Text_IO.Put_Line ("In the Main");

      -- Wasm interpreter
      Twelve := start_the_interpreter;

      Ada.Text_IO.Put_Line ("The answer is " & Integer'Image (Twelve));
   end loop;
end Second_Main;

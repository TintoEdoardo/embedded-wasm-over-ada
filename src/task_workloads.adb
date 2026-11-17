with Ada.Text_IO;
with Ada.Assertions;
with Ada.Real_Time; use Ada.Real_Time;

package body Task_Workloads is

   procedure Cheers (Id : in Natural) is
   begin
      Ada.Text_IO.Put_Line ("Task " & Natural'Image (Id) & " starts. ");
   end Cheers;
   
   procedure First_Workload_Native (Id : in Natural) is
      Counter : Positive := 1;
   begin
      for I in 0 .. 100 loop
         Counter := Counter + 1;
         if I = 17 then
            Counter := Counter + 17;
         end if;
      end loop;
      
      Ada.Text_IO.Put_Line 
        ("Task " & Natural'Image (Id) & " says " & Positive'Image (Counter));
   
   end First_Workload_Native;
   
   procedure First_Workload_Wasm (Id : in Natural) is
      Twelve : Integer := 0;
      Start  : Ada.Real_Time.Time;
      Finish : Ada.Real_Time.Time;
      Measured_Span : Ada.Real_Time.Time_Span;
   begin
      
      Start := Ada.Real_Time.Clock;
      -- Invocation of the WebAssembly interpreter. 
      Twelve := Start_The_Interpreter;
      Finish := Ada.Real_Time.Clock;
      Measured_Span := Finish - Start;
      
      -- The WebASsembly computation produce 12 as a result
      -- (trust me or check this repo: 
      -- https://github.com/TintoEdoardo/dlr-wasm-interp-inst)
      Ada.Assertions.Assert (Twelve = 12, "Twelve /= 12");
      
      Ada.Text_IO.Put_Line 
        ("Duration is " & Duration'Image (Ada.Real_Time.To_Duration (Measured_Span)));
   end First_Workload_Wasm;

end Task_Workloads;

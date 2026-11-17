with System;
with Ada.Real_Time;
with Ada.Synchronous_Task_Control;

package Epochs is

   protected Epoch is
      procedure Get_Start_Time (T : out Ada.Real_Time.Time);
   private
      pragma Priority (System.Priority'Last);
      Start : Ada.Real_Time.Time;
      First : Boolean := True;
   end Epoch;

   -- This object is never set to 'True'.
   End_Of_Execution : Ada.Synchronous_Task_Control.Suspension_Object;

end Epochs;

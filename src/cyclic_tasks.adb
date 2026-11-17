with Ada.Real_Time; use Ada.Real_Time;
with Epochs;
with Task_Workloads;

package body Cyclic_Tasks is

   task body Cyclic is
      Next_Period : Ada.Real_Time.Time;
      Period      : constant Ada.Real_Time.Time_Span := 
        Ada.Real_Time.Microseconds (Cycle_Time);
   begin
      -- Initialization. 
      Task_Workloads.Cheers (Task_Id);
      Epochs.Epoch.Get_Start_Time (Next_Period);
      Next_Period := Next_Period + Period + Ada.Real_Time.Microseconds (Offset);
      loop
         delay until Next_Period;
                  
         -- Non-suspending task workload
         if Task_Id = 1 then
            Task_Workloads.First_Workload_Native (Task_Id);
         else
            Task_Workloads.First_Workload_Wasm (Task_Id);
         end if;
         
         Next_Period := Next_Period + Period;

      end loop;
   end Cyclic;

end Cyclic_Tasks;

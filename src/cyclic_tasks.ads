with System;

package Cyclic_Tasks is

   task type Cyclic (Task_Id    : Natural;
                     Pri        : System.Priority; 
                     Cycle_Time : Positive; 
                     Offset     : Natural)
   is
      pragma Priority (Pri);
   end Cyclic;

end Cyclic_Tasks;

package Task_Workloads is

   procedure Cheers (Id : in Natural);
   
   procedure First_Workload_Native (Id : in Natural);
   
   procedure First_Workload_Wasm (Id : in Natural);
   
private
   
   function Start_The_Interpreter return Integer with 
     Import => True,
     External_Name => "start_the_interpreter",
     Convention => C;

end Task_Workloads;

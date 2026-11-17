--------------------------------------------------------------
--  This is an example of a Ravenscar-compliant application --
--  taken from the "Guide for the use of the Ada Ravenscar  --
--  Profile in high integrity systems".                     --
--------------------------------------------------------------

pragma Profile (Ravenscar);
pragma Partition_Elaboration_Policy (Sequential);

with Epochs;
with System;
with Ada.Synchronous_Task_Control;

-- Here you find the instantiation of the cyclic tasks
-- used to run the interpreter (btw written in Rust).
with Taskset;
pragma Unreferenced (Taskset);

-- This package shows a simple way to import and export
-- functions between the Rust interpreter and the Ada
-- hosting environment.
with Export_Functions;
pragma Unreferenced (Export_Functions);

procedure Main is
   pragma CPU(1);
   pragma Priority (System.Priority'Last);
begin
   Ada.Synchronous_Task_Control.Suspend_Until_True (Epochs.End_Of_Execution);
end Main;

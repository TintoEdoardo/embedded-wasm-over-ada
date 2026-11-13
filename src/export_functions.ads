package Export_Functions is

   procedure Example_Of_Import
     with Export => True,
          Convention => C,
          External_Name => "example_of_import";

end Export_Functions;

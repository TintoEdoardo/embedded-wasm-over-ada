package body Epochs is

   protected body Epoch is

      procedure Get_Start_Time (T : out Ada.Real_Time.Time) is
      begin
         if First then
            First := False;
            Start := Ada.Real_Time.Clock;
         end if;
         T := Start;
      end Get_Start_Time;

   end Epoch;

end Epochs;

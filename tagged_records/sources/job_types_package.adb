package body Job_Types_Package is

   ----------------
   -- Return_Job --
   ----------------

   procedure Return_Job
     (Channel : GNAT.Sockets.Stream_Access;
      E : Job_Record'Class)
   is
   begin
      Natural'Write (Channel, E.Job_Array_A_Length);
      Number_Array'Write (Channel, E.Job_Array_A);
   end Return_Job;

end Job_Types_Package;

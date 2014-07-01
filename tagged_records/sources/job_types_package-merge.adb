package body Job_Types_Package.Merge is

   -----------------
   -- Receive_Job --
   -----------------

   function Receive_Job
     (Channel : GNAT.Sockets.Stream_Access)
      return Job_Record_Merge
   is
      Length_A, Length_B : Natural;
   begin
      Natural'Read (Channel, Length_A);
      Natural'Read (Channel, Length_B);
      declare
         E : Job_Record_Merge (Length_A, Length_B);
      begin
         Number_Array'Read (Channel, E.Job_Array_A);
         Number_Array'Read (Channel, E.Job_Array_B);
         return E;
      end;
   end Receive_Job;

   -----------------
   -- Process_Job --
   -----------------

   function Process_Job
     (E : in Job_Record_Merge)
      return Job_Record_Merge
   is
   begin
      return E;
   end Process_Job;

end Job_Types_Package.Merge;

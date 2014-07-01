package body Job_Types_Package.Sort is

   -----------------
   -- Receive_Job --
   -----------------

   function Receive_Job
     (Channel : GNAT.Sockets.Stream_Access)
      return Job_Record_Sort
   is
      Length_A : Natural;
   begin
      Natural'Read (Channel, Length_A);
      declare
         E : Job_Record_Sort (Length_A);
      begin
         Number_Array'Read (Channel, E.Job_Array_A);
         return E;
      end;
   end Receive_Job;

   -----------------
   -- Process_Job --
   -----------------

   function Process_Job
     (E : in Job_Record_Sort)
      return Job_Record_Sort
   is
   begin
      return E;
   end Process_Job;

end Job_Types_Package.Sort;

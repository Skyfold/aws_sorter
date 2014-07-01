package Job_Types_Package.Merge is
   type Job_Record_Merge (Job_Array_A_Length : Natural;
                          Job_Array_B_Length : Natural) is
     new Job_Record with private;

   function Receive_Job (Channel : GNAT.Sockets.Stream_Access)
                         return Job_Record_Merge;
   function Process_Job (E : in Job_Record_Merge)
                         return Job_Record_Merge;

private
   type Job_Record_Merge (Job_Array_A_Length : Natural;
                          Job_Array_B_Length : Natural) is
     new Job_Record (Job_Array_A_Length) with record
      Job_Array_B : Number_Array (1 .. Job_Array_B_Length);
   end record;
end Job_Types_Package.Merge;

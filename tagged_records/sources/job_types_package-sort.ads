package Job_Types_Package.Sort is
   type Job_Record_Sort is new Job_Record with private;


   function Receive_Job (Channel : GNAT.Sockets.Stream_Access)
                         return Job_Record_Sort;
   function Process_Job (E : in Job_Record_Sort)
                         return Job_Record_Sort;
private
   type Job_Record_Sort is new Job_Record with null record;
end Job_Types_Package.Sort;

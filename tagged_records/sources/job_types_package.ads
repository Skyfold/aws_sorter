with GNAT.Sockets;
with common_types;

package Job_Types_Package is
   subtype Number_Array is common_types.Number_Array;
   type Job_Record (Job_Array_A_Length : Natural) is abstract tagged private;

   function Receive_Job (Channel : GNAT.Sockets.Stream_Access)
                         return Job_Record is abstract;
   function Process_Job (E : in Job_Record)
                         return Job_Record is abstract;

   procedure Return_Job (Channel : GNAT.Sockets.Stream_Access;
                         E : Job_Record'Class);

private
   type Job_Record (Job_Array_A_Length : Natural) is abstract tagged record
      Job_Array_A : Number_Array (1 .. Job_Array_A_Length);
   end record;
end Job_Types_Package;

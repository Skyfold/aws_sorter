with common_types;
with Job_Types_Package.Sort;  use Job_Types_Package.Sort;
with Job_Types_Package.Merge; use Job_Types_Package.Merge;

package body job_types_helper is

   -----------------
   -- Receive_Job --
   -----------------

   function Receive_Job
     (Channel : GNAT.Sockets.Stream_Access)
      return Job_Types_Package.Job_Record'Class
   is
      Job_Type_Swap : common_types.Job_Types;
   begin
      common_types.Job_Types'Read (Channel, Job_Type_Swap);
      case Job_Type_Swap is
         when common_types.Merge_Job =>
            declare
               E : Job_Types_Package.Merge.Job_Record_Merge :=
                 Receive_Job (Channel);
            begin
               return Job_Types_Package.Job_Record'Class (E);
            end;
         when common_types.Sort_Job =>
            declare
               E : Job_Types_Package.Merge.Job_Record_Merge :=
                 Receive_Job (Channel);
            begin
               return Job_Types_Package.Job_Record'Class (E);
            end;
      end case;
   end Receive_Job;

end job_types_helper;

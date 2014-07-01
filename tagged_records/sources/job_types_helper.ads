with Job_Types_Package;
with GNAT.Sockets;

package job_types_helper is
   function Receive_Job
     (Channel : GNAT.Sockets.Stream_Access)
      return Job_Types_Package.Job_Record'Class;
end job_types_helper;

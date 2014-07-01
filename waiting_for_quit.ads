package waiting_for_quit is

   -- This package, when included, will intercept terminal input.
   -- If a q is input, run_when_q won't hang.

   -- Use this as such:

   -- select waiting_for_quit.q_sstatus.run_when_q;
   -- then abort
   -- -- your code to do in the mean time
   -- end select;

   protected q_status is
      entry run_when_q;
      procedure set_q;
   private
      q : Boolean := False;
   end q_status;
end waiting_for_quit;

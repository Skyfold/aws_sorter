with Ada.Text_IO;

package body waiting_for_quit is


   --------------
   -- q_status --
   --------------

   protected body q_status is

      ----------------
      -- run_when_q --
      ----------------

      entry run_when_q when q is
      begin
         null;
      end run_when_q;

      -----------
      -- set_q --
      -----------

      procedure set_q is
      begin
         q := True;
      end set_q;

   end q_status;

   task type get_q;
   task body get_q is
      Swap_Character : Character;
   begin
      loop
         Ada.Text_IO.Get_Immediate (Swap_Character);
         exit when Swap_Character = 'q';
      end loop;
      q_status.set_q;
   end get_q;

   get_q_task : access all get_q;

begin
   get_q_task := new get_q;
end waiting_for_quit;

package body sorter is

   ----------------
   -- merge_sort --
   ----------------

   function merge_sort (numbers : number_array) return number_array is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "merge_sort unimplemented");
      raise Program_Error with "Unimplemented function merge_sort";
      return merge_sort (numbers);
   end merge_sort;

   ------------------
   -- parse_string --
   ------------------

   function parse_string (text : String) return number_array is
      temp : String := "";
   begin
      if text'Length = 0 then return empty_number_array;
      else
         if text'First = ',' then
            return Integer'Value (temp)
              & parse_string (text (text'First + 1 .. text'Length));
         else
            temp := temp & text'First;
            return parse_string (text (text'First + 1 .. text'Length));

   end parse_string;

   ---------------
   -- to_string --
   ---------------

   function to_string (numbers : number_array) return String is
   begin
      if numbers'Length = 0 then return "";
      elsif numbers'Length = 1 then return Integer'Image (numbers (numbers'First));
      else return Integer'Image (numbers (numbers'First))
           & ", "
           & to_string (numbers (numbers'First + 1 .. numbers'Last));
   end to_string;

   ----------
   -- sort --
   ----------

   function sort (text : String) return String is
   begin
      return to_string (merge_sort (parse_string (text)));
   end sort;

end sorter;

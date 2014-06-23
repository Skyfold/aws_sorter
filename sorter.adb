with generic_MergeSort;

package body sorter is

   package sort_Float is new generic_MergeSort (Element => Float,">" => ">");
   use sort_Float;

   subtype number_array is sort_Float.Element_Array;

   empty_number_array : constant number_array (2 .. 1) := (others => 0.0);

   ------------------
   -- parse_string --
   ------------------

   function parse_string (text : String) return number_array is
   begin
      if text'Length = 0 then return empty_number_array;
      else
         for i in text'Range loop
            if text (i) = ',' then
               return Float'Value (text (text'First .. i - 1)) & parse_string (text (i + 1 .. text'Last));
            end if;
         end loop;
         return Float'Value (text) & empty_number_array;
      end if;

   end parse_string;

   ---------------
   -- to_string --
   ---------------

   function to_string (numbers : number_array) return String is
   begin
      if numbers'Length = 0 then return "";
      elsif numbers'Length = 1 then return Float'Image (numbers (numbers'First));
      else return Float'Image (numbers (numbers'First))
           & ','
           & to_string (numbers (numbers'First + 1 .. numbers'Last));
      end if;
   end to_string;

   ----------
   -- sort --
   ----------

   function sort (text : String) return String is
   begin
      return to_string ( sort_Float.merge_sort (parse_string (text)));
   end sort;

end sorter;

package body sorter is


   type number_array is array (Positive range <>) of Integer;

   empty_number_array : constant number_array (2 .. 1) := (others => 0);

   ----------------
   -- merge_sort --
   ----------------

   function merge_sort (numbers : number_array) return number_array is

      function merge (n_left, n_right : number_array) return number_array is
         left_index : Integer := n_left'First;
         right_index : Integer := n_right'First;
      begin
         if n_left'Length = 0 then
            return n_right;
         elsif n_right'Length = 0 then
            return n_left;
         elsif n_left (left_index) > n_right (right_index) then
            return n_right (right_index)
              & merge (n_left,
                       n_right(right_index + 1 .. n_right'Last));
         else
            return n_left (left_index)
              & merge (n_left (left_index + 1 .. n_left'Last),
                       n_right);
         end if;
      end merge;

      half : Integer := numbers'First + numbers'Length/2 - 1;

   begin
      case numbers'Length is
         when 0 => return numbers;
         when 1 => return numbers;
         when others => return merge
              (merge_sort (numbers (numbers'First .. half)),
               (merge_sort (numbers (half + 1 .. numbers'Last))));

      end case;

   end merge_sort;

   ------------------
   -- parse_string --
   ------------------

   function parse_string (text : String) return number_array is
   begin
      if text'Length = 0 then return empty_number_array;
      else
         for i in text'Range loop
            if text (i) = ',' then
               return Integer'Value (text (text'First .. i - 1)) & parse_string (text (i + 1 .. text'Last));
            end if;
         end loop;
         return Integer'Value (text) & empty_number_array;
      end if;

   end parse_string;

   ---------------
   -- to_string --
   ---------------

   function to_string (numbers : number_array) return String is
   begin
      if numbers'Length = 0 then return "";
      elsif numbers'Length = 1 then return Integer'Image (numbers (numbers'First));
      else return Integer'Image (numbers (numbers'First))
           & ','
           & to_string (numbers (numbers'First + 1 .. numbers'Last));
      end if;
   end to_string;

   ----------
   -- sort --
   ----------

   function sort (text : String) return String is
   begin
      return to_string (merge_sort (parse_string (text)));
   end sort;

end sorter;

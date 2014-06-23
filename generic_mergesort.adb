package body generic_MergeSort is

   ----------------
   -- merge_sort --
   ----------------

   function merge_sort (numbers : Element_Array) return Element_Array is

      function merge (n_left, n_right : Element_Array) return Element_Array is
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

end generic_MergeSort;

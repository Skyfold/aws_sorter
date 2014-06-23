generic
   type Element is private;
   with function ">" (L, R : Element) return Boolean;

package generic_MergeSort is

   type Element_Array is array (Positive range <>) of Element;

   function merge_sort (numbers : Element_Array) return Element_Array;

end generic_MergeSort;

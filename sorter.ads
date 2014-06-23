package sorter is

   type number_array is array (Positive range <>) of Integer;

   empty_number_array : constant number_array (2 .. 1);

   function merge_sort (numbers : number_array) return number_array;

   function parse_string (text : String) return number_array;

   function to_string (numbers : number_array) return String;

   function sort (text : String) return String;

end sorter;

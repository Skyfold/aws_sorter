generic
   type Element_Type is private;
   with function Less_Than (L, R : Element_Type) return Boolean;

package generic_thing is

   type Element_Array is array (Positive range <>) of Element_Type;

   function Greatest_Element (A : Element_Array) return Element_Type;
end generic_thing;

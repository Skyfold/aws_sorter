package body generic_thing is

   ----------------------
   -- Greatest_Element --
   ----------------------

   function Greatest_Element (A : Element_Array) return Element_Type is
      Greatest_Element : Element_Type;
   begin
      case A'Length is
         when 0 => raise Program_Error;
         when 1 => return A (A'First);
         when others =>
            Greatest_Element := A (A'First);
            for i in A'First + 1 .. A'Last loop
               if Less_Than (Greatest_Element, A(i)) then
                  Greatest_Element := A (i);
               end if;
            end loop;
            return Greatest_Element;
      end case;
   end Greatest_Element;

end generic_thing;

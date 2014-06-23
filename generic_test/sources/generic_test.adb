with Ada.Text_IO;
with generic_thing;

procedure generic_test is
   package generic_testing is new generic_thing (Element_Type => Integer,
                                                 Less_Than    => "<");
begin
   Ada.Text_IO.Put_Line ("Greatest Element is: " & Integer'Image (generic_testing.Greatest_Element ( (1, 5, 4, 7, 5) )));

end generic_test;

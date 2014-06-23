with Ada.Strings.Bounded;

package common_types is
   package Bounded_300 is new Ada.Strings.Bounded.Generic_Bounded_Length (300);
end common_types;

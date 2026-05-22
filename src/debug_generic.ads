with System.Storage_Elements; use System.Storage_Elements;

generic
   with procedure Driver_Write (Buf : Storage_Array);
package Debug_Generic is

   procedure Put      (S : String);
   procedure Put_Line (S : String);
   function Hex       (B : Natural) return String;
   function Img       (N : Integer) return String;

end Debug_Generic;
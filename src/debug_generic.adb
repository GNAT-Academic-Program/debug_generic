package body Debug_Generic is

   procedure Put (S : String) is
      Buf : Storage_Array (1 .. Storage_Offset (S'Length));
      J   : Storage_Offset := Buf'First;
   begin
      for C of S loop
         Buf (J) := Storage_Element (Character'Pos (C));
         J := J + 1;
      end loop;
      Driver_Write (Buf);
   end Put;

   procedure Put_Line (S : String) is
   begin
      Put (S);
      Put ("" & ASCII.CR & ASCII.LF);
   end Put_Line;

   function Hex (B : Natural) return String is
      function Digit (N : Natural) return Character is
      (if N < 10 then Character'Val (Character'Pos ('0') + N)
         else Character'Val (Character'Pos ('A') + (N - 10)));
   begin
      return "0x"
      & Digit ((B / 16#10000000#) mod 16)
      & Digit ((B / 16#1000000#)  mod 16)
      & Digit ((B / 16#100000#)   mod 16)
      & Digit ((B / 16#10000#)    mod 16)
      & Digit ((B / 16#1000#)     mod 16)
      & Digit ((B / 16#100#)      mod 16)
      & Digit ((B / 16#10#)       mod 16)
      & Digit  (B                 mod 16);
   end Hex;

   function Img (N : Integer) return String is
   begin
      return Integer'Image (N);
   end Img;

end Debug_Generic;
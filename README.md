# debug_generic

Generic debug output package for bare-metal Ada applications.

## Overview

`debug_generic` provides a minimal, zero-dependency debug output interface for embedded systems. It abstracts the underlying transport mechanism (UART, SWO, etc.) through a generic parameter, allowing the same debug code to work across different hardware platforms.

## Features

- Generic instantiation with custom write driver
- String output with `Put` and `Put_Line`
- Hexadecimal formatting with `Hex`
- Integer to string conversion with `Img`
- Zero heap allocation
- No runtime dependencies beyond System.Storage_Elements

## API

```ada
generic
   with procedure Driver_Write (Buf : Storage_Array);
package Debug_Generic is
   procedure Put      (S : String);
   procedure Put_Line (S : String);
   function Hex       (B : Natural) return String;
   function Img       (N : Integer) return String;
end Debug_Generic;
```

### Procedures

- **`Put (S : String)`** - Output string without newline
- **`Put_Line (S : String)`** - Output string with CR+LF terminator

### Functions

- **`Hex (B : Natural) return String`** - Convert natural to 8-digit hexadecimal string (e.g., "0x0000ABCD")
- **`Img (N : Integer) return String`** - Convert integer to decimal string representation

## Usage

### 1. Implement a Driver Write Procedure

Create a procedure that writes a `Storage_Array` to your debug output hardware:

```ada
with System.Storage_Elements; use System.Storage_Elements;

package Board_Log is
   procedure Write (Buf : Storage_Array);
end Board_Log;
```

### 2. Instantiate the Generic Package

```ada
with Debug_Generic;
with Board_Log;

package Debug is new Debug_Generic
  (Driver_Write => Board_Log.Write);
```

### 3. Use the Debug Interface

```ada
with Debug;

procedure Main is
   Value : Natural := 16#DEADBEEF#;
begin
   Debug.Put_Line ("System initialized");
   Debug.Put ("Register value: ");
   Debug.Put_Line (Debug.Hex (Value));
   Debug.Put_Line ("Counter: " & Debug.Img (42));
end Main;
```

## Example Output

```
System initialized
Register value: 0xDEADBEEF
Counter:  42
```

## Integration

Add to your `alire.toml`:

```toml
[[depends-on]]
debug_generic = "^0.1.0"
```

## Design Rationale

The generic approach decouples debug output from specific hardware implementations, enabling:

- Portability across different microcontroller families
- Testing with different output backends (UART, SWO, semihosting)
- Compile-time binding with zero runtime overhead
- No dynamic dispatch or virtual function calls
- Hierarchical instantiation for multi-level debugging

## License

MIT OR Apache-2.0 WITH LLVM-exception

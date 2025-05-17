# CheckEvenBits-EMU8086

## 🧠 About the Project

This is a simple 16-bit assembly language program written for the EMU8086 emulator. It allows the user to input a **1-byte hexadecimal value** (e.g., `FF`, `A5`, `55`) and checks whether **all even-positioned bits** (i.e., bits 0, 2, 4, and 6) are set to `1`.

The bitmask used is `0x55` (`01010101b`) which targets the even bit positions. If all those bits are set in the input byte, the program displays a message confirming it. Otherwise, it notifies that not all even bits are set.

---

## ⚙️ Features

- Accepts **hexadecimal input** (`00` to `FF`)
- Converts ASCII input to binary
- Checks **even-positioned bits** using bitwise AND
- Displays meaningful output messages
- Handles both **uppercase and lowercase** hex letters
- Detects and handles **invalid input**

---

## 🛠 Built With

- **EMU8086** – x86 Assembly Emulator
- **DOS INT 21h** services for I/O

---




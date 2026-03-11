# UART Implementation in Verilog

## Overview
This project implements a **Universal Asynchronous Receiver/Transmitter (UART)** in Verilog.  
The design consists of a **baud rate generator, transmitter, receiver, top module, and a testbench**.

The UART uses **16× oversampling in the receiver** to accurately sample incoming data and supports **8-bit serial communication with start and stop bits**.

The design was simulated using **Icarus Verilog** and **GTKWave**.

---

## UART Frame Format
Idle → Start → D0 → D1 → D2 → D3 → D4 → D5 → D6 → D7 → Stop <br>
  1      0      LSB --------------------------> MSB     1

---

## Project Structure
UART/
│
├── baud_rate_generator.v
├── transmitter.v
├── receiver.v
├── top.v
├── uart_top_tb.v


---

## Module Description

### 1. Baud Rate Generator
Generates enable pulses for UART transmission and reception.

- `tx_enable` → Baud clock for transmitter  
- `rx_enable` → 16× oversampling clock for receiver  

---

### 2. UART Transmitter
Implements a **Finite State Machine (FSM)** with the following states:

- `IDLE`
- `START`
- `DATA`
- `STOP`

Responsibilities:
- Load input data
- Serialize data bits
- Send start and stop bits
- Generate `busy` signal during transmission

---

### 3. UART Receiver
Uses **16× oversampling** to sample incoming bits reliably.

States:
- `START`
- `DATA`
- `STOP`

Features:
- Mid-bit sampling
- Stores received bits in a temporary register
- Asserts `rdy` signal when data reception is complete

---

### 4. Top Module
The top module connects all UART components.
Baud Rate Generator
│
├── tx_enable → Transmitter
└── rx_enable → Receiver

---

### 5. Testbench
The testbench performs the following tasks:

- Generates clock signal
- Applies reset
- Sends data bytes
- Waits for reception
- Displays received data

Example transmitted data:
0x41 (ASCII 'A')
0x55


---

## Simulation

### Tools Used
- **Icarus Verilog**
- **GTKWave**

---

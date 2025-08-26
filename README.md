# Fast-Fourier-Transform
This project focuses on the design and implementation of an 8-point Fast Fourier Transform (FFT) processor using Verilog HDL. The FFT algorithm is widely used in digital signal processing (DSP) applications such as image processing, communications, and audio analysis. The hardware design efficiently computes the Discrete Fourier Transform (DFT) by exploiting the FFT algorithm’s butterfly structure, significantly reducing computational complexity from 
O(N^2) to O(NlogN).

The implementation is based on a radix-2 decimation-in-time (DIT) architecture. The design includes the following modules:

Complex Arithmetic Units: Perform addition, subtraction, and multiplication of complex numbers.

Butterfly Computation Unit: Handles FFT butterfly operations at each stage.

Twiddle Factor ROM: Stores pre-computed coefficients (sine and cosine values).

Control Logic: Manages data flow across stages and synchronizes operations.

Input/Output Buffers: For handling complex input samples and storing FFT outputs.

The FFT design was verified using testbenches in Verilog and the results were cross-checked against MATLAB/Python FFT functions for correctness. Simulation waveforms in GTKWave were analyzed to confirm accurate stage-by-stage butterfly computations and twiddle factor multiplications.

Key Features:

8-point radix-2 DIT FFT hardware implementation.

Fixed-point arithmetic for hardware efficiency.

Modular Verilog design with reusable arithmetic blocks.

Verification with MATLAB/Python reference outputs.

Suitable for FPGA implementation in real-time DSP applications.

Learning Outcome:
Through this project, I gained hands-on experience in digital signal processing, complex arithmetic hardware design, and fixed-point implementation techniques. It also strengthened my understanding of Verilog RTL design, testbench writing, and waveform-based debugging for algorithm-to-hardware translation.


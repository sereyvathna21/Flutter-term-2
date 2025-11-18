# Quantum Computing Labs - Combined Notebook

## Overview

This repository contains a combined Jupyter notebook (`Quantum_Computing_Labs_Combined.ipynb`) that includes five quantum computing laboratory exercises:

1. **Lab 1: QFT (Quantum Fourier Transform)** - Implementation of the quantum Fourier transform
2. **Lab 2: BV (Bernstein-Vazirani)** - Finding hidden binary strings with secret number input
3. **Lab 3: QPE (Quantum Phase Estimation)** - Estimating eigenvalues of unitary operators
4. **Lab 4: Grover's Search on 3 qubits** - Quantum search algorithm demonstration
5. **Lab 5: Shor's Factoring** - Integer factorization using quantum computing

## Author

**IDTB090046 - Em Sereyvathna**

## Prerequisites

To run this notebook, you need Python 3.8 or higher with the following packages:

### Required Python Packages

```bash
pip install qiskit
pip install qiskit-aer
pip install matplotlib
pip install numpy
```

Or install all at once:

```bash
pip install qiskit qiskit-aer matplotlib numpy
```

### Standard Library Packages (included with Python)

- `math` (for gcd, pi)
- `fractions` (for Fraction)

## How to Use

### 1. Install Jupyter

If you don't have Jupyter installed:

```bash
pip install jupyter
```

### 2. Launch Jupyter Notebook

Navigate to the repository directory and start Jupyter:

```bash
jupyter notebook
```

### 3. Open the Notebook

In the Jupyter interface, open `Quantum_Computing_Labs_Combined.ipynb`

### 4. Run the Cells

Execute the cells in order:
- The first cell imports all required libraries
- Each lab section can be run independently
- Make sure to run the import cell first before running any lab sections

## Lab Descriptions

### Lab 1: Quantum Fourier Transform (QFT)

Demonstrates the implementation of QFT, a quantum analogue of the discrete Fourier transform. Includes:
- QFT rotations implementation
- Qubit swap operations
- Visualization of results

### Lab 2: Bernstein-Vazirani Algorithm

Shows how to find a hidden binary string in a single query. Features:
- Oracle construction
- Customizable secret number input
- Measurement and result interpretation

**Note:** You can modify the `secret_string` variable to test different binary strings.

### Lab 3: Quantum Phase Estimation (QPE)

Implements phase estimation for finding eigenvalues. Includes:
- Controlled unitary operations
- Inverse QFT application
- Phase interpretation from measurements

### Lab 4: Grover's Search Algorithm

Demonstrates quantum search on a 3-qubit system. Features:
- Oracle for marking target states
- Diffusion operator (inversion about average)
- Optimal iteration calculation
- Search for state |101⟩

### Lab 5: Shor's Factoring Algorithm

Complete implementation of Shor's algorithm for factoring N=15. Includes:
- Period finding using quantum phase estimation
- Classical post-processing
- Factor extraction
- Verification of results

## Customization

### Changing the Secret Number (Lab 2)

In Lab 2, modify the `secret_string` variable:

```python
secret_string = '10110101'  # Change to any binary string
```

### Changing the Search Target (Lab 4)

In Lab 4, modify the `marked_state` variable:

```python
marked_state = 5  # Change to any number from 0 to 7 (for 3 qubits)
```

### Changing the Number to Factor (Lab 5)

Lab 5 is specifically designed for N=15. To factor other numbers, significant modifications to the circuit would be required.

## Expected Results

- **QFT**: Shows the transformed quantum state distribution
- **BV**: Should measure the exact secret binary string with high probability
- **QPE**: Estimates phase ≈ 1/8 for the T gate
- **Grover's**: Should find the marked state with high probability (~95%)
- **Shor's**: Successfully factors 15 = 3 × 5

## Troubleshooting

### Import Errors

If you get import errors, ensure all packages are installed:

```bash
pip install --upgrade qiskit qiskit-aer matplotlib numpy
```

### Qiskit Version

This notebook is compatible with Qiskit 1.0+. If you have an older version:

```bash
pip install --upgrade qiskit
```

### Visualization Issues

If plots don't display, ensure matplotlib backend is properly configured:

```python
%matplotlib inline
```

## Additional Resources

- [Qiskit Documentation](https://qiskit.org/documentation/)
- [Qiskit Textbook](https://qiskit.org/textbook/)
- [Quantum Computing Stack Exchange](https://quantumcomputing.stackexchange.com/)

## License

This notebook is for educational purposes.

## Notes

- All simulations run on classical simulators (qasm_simulator and statevector_simulator)
- For real quantum hardware, you would need IBM Quantum account credentials
- Circuit depths and qubit counts are optimized for simulator performance
- Some algorithms may take a few seconds to run due to simulation complexity

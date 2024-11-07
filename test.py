#!/usr/bin/env python3
from dataclasses import dataclass
import subprocess
from pathlib import Path
import sys
import os
import random
from typing import List, Tuple

@dataclass
class TestCase:
    """Represents a single ALU test case"""
    operation: int      # Operation code (0-15)
    a_value: int       # Value for register A
    b_value: int       # Value for register B
    expected: int      # Expected output
    description: str   # Test description

class ALUTester:
    def __init__(self):
        # Define paths based on operating system
        self.IVL_PATH = "iverilog"
        self.VVP_PATH = "vvp"
        self.GTK_PATH = "gtkwave"
        
        if os.name == "nt":  # Windows
            base_path = "C:\\iverilog\\bin\\"
            self.IVL_PATH = base_path + self.IVL_PATH
            self.VVP_PATH = base_path + self.VVP_PATH
            self.GTK_PATH = "C:\\iverilog\\gtkwave\\bin\\" + self.GTK_PATH
            
        self.test_cases = self._generate_test_cases()
        
    def _generate_test_cases(self) -> List[TestCase]:
        """Generate comprehensive test cases for ALU verification"""
        tests = []
        
        # Test arithmetic operations
        tests.extend([
            TestCase(0, 5, 3, 8, "Basic addition"),
            TestCase(0, -5, 3, -2, "Addition with negative"),
            TestCase(1, 10, 4, 6, "Basic subtraction"),
            TestCase(2, 5, 0, 10, "Shift left"),
            TestCase(3, 8, 0, 4, "Shift right"),
        ])
        
        # Test logical operations
        tests.extend([
            TestCase(4, 5, 5, 0, "Equal comparison"),
            TestCase(4, 6, 5, 1, "Greater than comparison"),
            TestCase(4, 4, 5, -1, "Less than comparison"),
            TestCase(5, 0b1010, 0b1100, 0b1000, "Bitwise AND"),
            TestCase(6, 0b1010, 0b1100, 0b1110, "Bitwise OR"),
        ])
        
        return tests

    def execute_test(self) -> bool:
        """Compile and run the Verilog simulation"""
        try:
            # Compile all Verilog files
            verilog_files = Path(".").glob("*.v")
            compile_result = subprocess.run(
                [self.IVL_PATH] + [str(x) for x in verilog_files],
                capture_output=True,
                text=True
            )
            
            if compile_result.returncode != 0:
                print("Compilation failed:")
                print(compile_result.stderr)
                return False
                
            # Run the simulation
            sim_result = subprocess.run(
                [self.VVP_PATH, "a.out"],
                capture_output=True,
                text=True
            )
            
            if sim_result.returncode != 0:
                print("Simulation failed:")
                print(sim_result.stderr)
                return False
                
            return True
            
        except Exception as e:
            print(f"Test execution failed: {str(e)}")
            return False

    def verify_results(self) -> Tuple[int, int]:
        """
        Analyze dump.vcd file to verify test results
        Returns (passed_tests, total_tests)
        """
        # This is where you would parse dump.vcd and compare against test_cases
        # For now, we'll just return placeholder values
        return (0, len(self.test_cases))

    def view_waveform(self):
        """Open GTKWave to view the waveform"""
        try:
            subprocess.run([self.GTK_PATH, "dump.vcd"])
        except Exception as e:
            print(f"Failed to open waveform viewer: {str(e)}")

def main():
    tester = ALUTester()
    
    print("Starting ALU verification...")
    if tester.execute_test():
        passed, total = tester.verify_results()
        print(f"\nTest Results: {passed}/{total} tests passed")
        
        # Uncomment to view waveform automatically
        # tester.view_waveform()
    else:
        print("Testing failed - check error messages above")

if __name__ == "__main__":
    main()
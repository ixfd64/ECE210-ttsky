# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import *


# combine two 4-bit inputs into an octet
def combine(x1, x2):
    return ((x2 & 0xF) << 4) | (x1 & 0xF)


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # run tests on perceptron
    dut.ena.value = 1
    dut.rst_n.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    await Timer(1, units="ns")

    # test case: positive sum
    dut.ui_in.value = combine(0, 0)
    await Timer(1, units="ns")
    assert dut.uo_out.value.integer & 1 == 1, f"Test #1 failed: {dut.uo_out.value.integer}"

    # test case: zero sum
    dut.ui_in.value = combine(-2, 2)
    await Timer(1, units="ns")
    assert dut.uo_out.value.integer & 1 == 0, f"Test #2 failed: {dut.uo_out.value.integer}"

    # test case: double negative multiplication
    dut.ui_in.value = combine(-1, -1)
    await Timer(1, units="ns")
    assert dut.uo_out.value.integer & 1 == 1, f"Test #3 failed: {dut.uo_out.value.integer}"

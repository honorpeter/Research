# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ipgui::add_page $IPINST -name "Page 1" -layout vertical]
	set Component_Name [ipgui::add_param $IPINST -parent $Page0 -name Component_Name]
	set C_M00_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_M00_AXIS_TDATA_WIDTH]
	set_property tooltip {Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.} $C_M00_AXIS_TDATA_WIDTH
	set C_M00_AXIS_START_COUNT [ipgui::add_param $IPINST -parent $Page0 -name C_M00_AXIS_START_COUNT]
	set_property tooltip {Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.} $C_M00_AXIS_START_COUNT
	set C_S00_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_S00_AXIS_TDATA_WIDTH]
	set_property tooltip {AXI4Stream sink: Data Width} $C_S00_AXIS_TDATA_WIDTH
	set C_IMAGE_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_IMAGE_WIDTH]
	set SHIFT [ipgui::add_param $IPINST -parent $Page0 -name SHIFT]
	set OFFSET [ipgui::add_param $IPINST -parent $Page0 -name OFFSET]
	set tabgroup0 [ipgui::add_group $IPINST -parent $Page0 -name {Filter Coefficients} -layout vertical]
	set A [ipgui::add_param $IPINST -parent $tabgroup0 -name A]
	set B [ipgui::add_param $IPINST -parent $tabgroup0 -name B]
	set C [ipgui::add_param $IPINST -parent $tabgroup0 -name C]
	set D [ipgui::add_param $IPINST -parent $tabgroup0 -name D]
	set E [ipgui::add_param $IPINST -parent $tabgroup0 -name E]
	set F [ipgui::add_param $IPINST -parent $tabgroup0 -name F]
	set G [ipgui::add_param $IPINST -parent $tabgroup0 -name G]
	set H [ipgui::add_param $IPINST -parent $tabgroup0 -name H]
	set I [ipgui::add_param $IPINST -parent $tabgroup0 -name I]
	set J [ipgui::add_param $IPINST -parent $tabgroup0 -name J]
	set K [ipgui::add_param $IPINST -parent $tabgroup0 -name K]
	set L [ipgui::add_param $IPINST -parent $tabgroup0 -name L]
	set M [ipgui::add_param $IPINST -parent $tabgroup0 -name M]
	set N [ipgui::add_param $IPINST -parent $tabgroup0 -name N]
	set O [ipgui::add_param $IPINST -parent $tabgroup0 -name O]
}

proc update_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M00_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXIS_START_COUNT { PARAM_VALUE.C_M00_AXIS_START_COUNT } {
	# Procedure called to update C_M00_AXIS_START_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXIS_START_COUNT { PARAM_VALUE.C_M00_AXIS_START_COUNT } {
	# Procedure called to validate C_M00_AXIS_START_COUNT
	return true
}

proc update_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_S00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_S00_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_IMAGE_WIDTH { PARAM_VALUE.C_IMAGE_WIDTH } {
	# Procedure called to update C_IMAGE_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IMAGE_WIDTH { PARAM_VALUE.C_IMAGE_WIDTH } {
	# Procedure called to validate C_IMAGE_WIDTH
	return true
}

proc update_PARAM_VALUE.SHIFT { PARAM_VALUE.SHIFT } {
	# Procedure called to update SHIFT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SHIFT { PARAM_VALUE.SHIFT } {
	# Procedure called to validate SHIFT
	return true
}

proc update_PARAM_VALUE.OFFSET { PARAM_VALUE.OFFSET } {
	# Procedure called to update OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET { PARAM_VALUE.OFFSET } {
	# Procedure called to validate OFFSET
	return true
}

proc update_PARAM_VALUE.A { PARAM_VALUE.A } {
	# Procedure called to update A when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.A { PARAM_VALUE.A } {
	# Procedure called to validate A
	return true
}

proc update_PARAM_VALUE.B { PARAM_VALUE.B } {
	# Procedure called to update B when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.B { PARAM_VALUE.B } {
	# Procedure called to validate B
	return true
}

proc update_PARAM_VALUE.C { PARAM_VALUE.C } {
	# Procedure called to update C when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C { PARAM_VALUE.C } {
	# Procedure called to validate C
	return true
}

proc update_PARAM_VALUE.D { PARAM_VALUE.D } {
	# Procedure called to update D when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.D { PARAM_VALUE.D } {
	# Procedure called to validate D
	return true
}

proc update_PARAM_VALUE.E { PARAM_VALUE.E } {
	# Procedure called to update E when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.E { PARAM_VALUE.E } {
	# Procedure called to validate E
	return true
}

proc update_PARAM_VALUE.F { PARAM_VALUE.F } {
	# Procedure called to update F when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.F { PARAM_VALUE.F } {
	# Procedure called to validate F
	return true
}

proc update_PARAM_VALUE.G { PARAM_VALUE.G } {
	# Procedure called to update G when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.G { PARAM_VALUE.G } {
	# Procedure called to validate G
	return true
}

proc update_PARAM_VALUE.H { PARAM_VALUE.H } {
	# Procedure called to update H when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.H { PARAM_VALUE.H } {
	# Procedure called to validate H
	return true
}

proc update_PARAM_VALUE.I { PARAM_VALUE.I } {
	# Procedure called to update I when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.I { PARAM_VALUE.I } {
	# Procedure called to validate I
	return true
}

proc update_PARAM_VALUE.J { PARAM_VALUE.J } {
	# Procedure called to update J when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.J { PARAM_VALUE.J } {
	# Procedure called to validate J
	return true
}

proc update_PARAM_VALUE.K { PARAM_VALUE.K } {
	# Procedure called to update K when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.K { PARAM_VALUE.K } {
	# Procedure called to validate K
	return true
}

proc update_PARAM_VALUE.L { PARAM_VALUE.L } {
	# Procedure called to update L when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L { PARAM_VALUE.L } {
	# Procedure called to validate L
	return true
}

proc update_PARAM_VALUE.M { PARAM_VALUE.M } {
	# Procedure called to update M when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.M { PARAM_VALUE.M } {
	# Procedure called to validate M
	return true
}

proc update_PARAM_VALUE.N { PARAM_VALUE.N } {
	# Procedure called to update N when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N { PARAM_VALUE.N } {
	# Procedure called to validate N
	return true
}

proc update_PARAM_VALUE.O { PARAM_VALUE.O } {
	# Procedure called to update O when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.O { PARAM_VALUE.O } {
	# Procedure called to validate O
	return true
}


proc update_MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXIS_START_COUNT { MODELPARAM_VALUE.C_M00_AXIS_START_COUNT PARAM_VALUE.C_M00_AXIS_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXIS_START_COUNT}] ${MODELPARAM_VALUE.C_M00_AXIS_START_COUNT}
}

proc update_MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_IMAGE_WIDTH { MODELPARAM_VALUE.C_IMAGE_WIDTH PARAM_VALUE.C_IMAGE_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IMAGE_WIDTH}] ${MODELPARAM_VALUE.C_IMAGE_WIDTH}
}

proc update_MODELPARAM_VALUE.A { MODELPARAM_VALUE.A PARAM_VALUE.A } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.A}] ${MODELPARAM_VALUE.A}
}

proc update_MODELPARAM_VALUE.B { MODELPARAM_VALUE.B PARAM_VALUE.B } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.B}] ${MODELPARAM_VALUE.B}
}

proc update_MODELPARAM_VALUE.C { MODELPARAM_VALUE.C PARAM_VALUE.C } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C}] ${MODELPARAM_VALUE.C}
}

proc update_MODELPARAM_VALUE.D { MODELPARAM_VALUE.D PARAM_VALUE.D } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.D}] ${MODELPARAM_VALUE.D}
}

proc update_MODELPARAM_VALUE.E { MODELPARAM_VALUE.E PARAM_VALUE.E } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.E}] ${MODELPARAM_VALUE.E}
}

proc update_MODELPARAM_VALUE.F { MODELPARAM_VALUE.F PARAM_VALUE.F } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.F}] ${MODELPARAM_VALUE.F}
}

proc update_MODELPARAM_VALUE.G { MODELPARAM_VALUE.G PARAM_VALUE.G } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.G}] ${MODELPARAM_VALUE.G}
}

proc update_MODELPARAM_VALUE.H { MODELPARAM_VALUE.H PARAM_VALUE.H } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.H}] ${MODELPARAM_VALUE.H}
}

proc update_MODELPARAM_VALUE.I { MODELPARAM_VALUE.I PARAM_VALUE.I } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.I}] ${MODELPARAM_VALUE.I}
}

proc update_MODELPARAM_VALUE.J { MODELPARAM_VALUE.J PARAM_VALUE.J } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.J}] ${MODELPARAM_VALUE.J}
}

proc update_MODELPARAM_VALUE.K { MODELPARAM_VALUE.K PARAM_VALUE.K } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.K}] ${MODELPARAM_VALUE.K}
}

proc update_MODELPARAM_VALUE.L { MODELPARAM_VALUE.L PARAM_VALUE.L } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L}] ${MODELPARAM_VALUE.L}
}

proc update_MODELPARAM_VALUE.M { MODELPARAM_VALUE.M PARAM_VALUE.M } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.M}] ${MODELPARAM_VALUE.M}
}

proc update_MODELPARAM_VALUE.N { MODELPARAM_VALUE.N PARAM_VALUE.N } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N}] ${MODELPARAM_VALUE.N}
}

proc update_MODELPARAM_VALUE.O { MODELPARAM_VALUE.O PARAM_VALUE.O } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.O}] ${MODELPARAM_VALUE.O}
}

proc update_MODELPARAM_VALUE.SHIFT { MODELPARAM_VALUE.SHIFT PARAM_VALUE.SHIFT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SHIFT}] ${MODELPARAM_VALUE.SHIFT}
}

proc update_MODELPARAM_VALUE.OFFSET { MODELPARAM_VALUE.OFFSET PARAM_VALUE.OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET}] ${MODELPARAM_VALUE.OFFSET}
}


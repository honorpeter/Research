# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ipgui::add_page $IPINST -name "Page 0" -layout vertical]
	set Component_Name [ipgui::add_param $IPINST -parent $Page0 -name Component_Name]
	set C_IMAGE_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_IMAGE_WIDTH]
	set A [ipgui::add_param $IPINST -parent $Page0 -name A]
	set B [ipgui::add_param $IPINST -parent $Page0 -name B]
	set C [ipgui::add_param $IPINST -parent $Page0 -name C]
	set SHIFT [ipgui::add_param $IPINST -parent $Page0 -name SHIFT]
	set C_M00_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_M00_AXIS_TDATA_WIDTH]
	set_property tooltip {Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.} $C_M00_AXIS_TDATA_WIDTH
	set C_M00_AXIS_START_COUNT [ipgui::add_param $IPINST -parent $Page0 -name C_M00_AXIS_START_COUNT]
	set_property tooltip {Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.} $C_M00_AXIS_START_COUNT
	set C_S00_AXIS_TDATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_S00_AXIS_TDATA_WIDTH]
	set_property tooltip {AXI4Stream sink: Data Width} $C_S00_AXIS_TDATA_WIDTH
}

proc update_PARAM_VALUE.C_IMAGE_WIDTH { PARAM_VALUE.C_IMAGE_WIDTH } {
	# Procedure called to update C_IMAGE_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IMAGE_WIDTH { PARAM_VALUE.C_IMAGE_WIDTH } {
	# Procedure called to validate C_IMAGE_WIDTH
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

proc update_PARAM_VALUE.SHIFT { PARAM_VALUE.SHIFT } {
	# Procedure called to update SHIFT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SHIFT { PARAM_VALUE.SHIFT } {
	# Procedure called to validate SHIFT
	return true
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

proc update_MODELPARAM_VALUE.SHIFT { MODELPARAM_VALUE.SHIFT PARAM_VALUE.SHIFT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SHIFT}] ${MODELPARAM_VALUE.SHIFT}
}


PATH_LIB=$(XILINX_VIVADO)/data/verilog/src
PATH_RTL=../rtl
PATH_TBN=../tbn

# secure IP
#LIB=$(PATH_LIB)/glbl.v

# TODO: VIP for AXI4 memory mapped interfaces, and ZYNQ PS
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/axi_vip_axi4pc.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/xil_common_vip_pkg.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/axi_vip_pkg.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/axi4stream_vip_if.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/axi_vip_if.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/clk_vip_if.sv
LIB+=$(XILINX_VIVADO)/data/xilinx_vip/hdl/rst_vip_if.sv

# RTL files
RTL_PKG =$(wildcard $(PATH_RTL)/*_pkg.sv)
RTL_SRC =$(wildcard $(PATH_RTL)/*.sv)
RTL_SRC+=$(wildcard $(PATH_RTL)/*.v)
RTL_DIF =$(filter-out $(RTL_PKG),$(RTL_SRC))
RTL = $(RTL_PKG) $(RTL_DIF)

# testbench files
TBN_PKG =$(wildcard $(PATH_TBN)/*_pkg.sv)
TBN_SRC =$(wildcard $(PATH_TBN)/*.sv)
TBN_SRC+=$(wildcard $(PATH_TBN)/*.v)
TBN_SRC+=$(wildcard $(PATH_TBN)/imports/*.sv)
TBN_SRC+=$(wildcard $(PATH_TBN)/imports/*.v)
TBN_DIF =$(filter-out $(TBN_PKG),$(TBN_SRC))
TBN = $(TBN_PKG) $(TBN_DIF)
TBN+= $(PATH_LIB)/glbl.v

SRC = $(LIB) $(RTL) $(TBN)

#MOD ?= axi4stream_vip_0_exdes_tb
MOD = axi_vip_0_exdes
#MOD = axi_vip_0_exdes_adv_mst_active__pt_passive__slv_comb

all: simulate

.PHONY: compile elborate simulate


OPT_COMPILE_LIB =-L xilinx_vip
OPT_COMPILE_LIB+=-L xil_common_vip
OPT_COMPILE_LIB+=-L axi_vip_v1_1_6
OPT_COMPILE_LIB+=-L axi4stream_vip_v1_1_6
OPT_COMPILE_LIB+=-L xil_defaultlib

OPT_COMPILE_INC = -i $(PATH_TBN)/imports
OPT_COMPILE_INC+=--include $(XILINX_VIVADO)/data/xilinx_vip/include
OPT_COMPILE_INC+=--include $(XILINX_VIVADO)/data/xilinx_vip/hdl
OPT_COMPILE_INC+=--include $(XILINX_VIVADO)/data/ip/xilinx/axi_vip_v1_1/hdl
OPT_COMPILE_INC+=--include $(XILINX_VIVADO)/data/ip/xilinx/axi4stream_vip_v1_1/hdl
OPT_COMPILE_INC+=--include $(XILINX_VIVADO)/data/ip/xilinx/processing_system7_vip_v5_5/hdl
OPT_COMPILE_INC+=--include $(XILINX_VIVADO)/data/ip/xilinx/sc_util_v1_0/hdl/verilog

OPT_COMPILE = $(OPT_COMPILE_LIB) $(OPT_COMPILE_INC)

#xsim.dir/xil_defaultlib/glbl.sdb:

compile: $(SRC)
#	$(foreach file,$(SRC),xvlog                             --sv --work xil_defaultlib $(file);)
	$(foreach file,$(SRC),xvlog -m64 --relax $(OPT_COMPILE) --sv --work xil_defaultlib $(file);)


OPT_ELABORATE_LIB =-L smartconnect_v1_0
OPT_ELABORATE_LIB+=-L axi_vip_if
OPT_ELABORATE_LIB+=-L axi_infrastructure_v1_1_0
OPT_ELABORATE_LIB+=-L axis_infrastructure_v1_1_0
OPT_ELABORATE_LIB+=-L xil_common_vip_v1_0_0
OPT_ELABORATE_LIB+=-L axi_protocol_checker_v2_0_6
OPT_ELABORATE_LIB+=-L axis_protocol_checker_v2_0_4
OPT_ELABORATE_LIB+=-L axi_vip_v1_1_6
OPT_ELABORATE_LIB+=-L axi4stream_vip_v1_1_6
OPT_ELABORATE_LIB+=-L xil_defaultlib
OPT_ELABORATE_LIB+=-L unisims_ver
OPT_ELABORATE_LIB+=-L unimacro_ver
OPT_ELABORATE_LIB+=-L secureip
OPT_ELABORATE_LIB+=-L xpm

OPT_ELABORATE = $(OPT_ELABORATE_LIB)

elaborate: compile
#%_tb: elaborate
	xelab -m64 --debug typical --relax $(OPT_ELABORATE) \
	--snapshot $(MOD)_behav xil_defaultlib.$(MOD)_tb xil_defaultlib.glbl -log elaborate.log
#	--snapshot $@ xil_defaultlib.$@

simulate: elaborate
#	xsim $@ -gui -wdb simulate_xsim.wdb
#	xsim $(MOD)_behav -tclbatch $(MOD)_tb.tcl -log simulate.log
	xsim $(MOD)_behav -tclbatch $(MOD)_tb.tcl -gui -view $(MOD)_behav.wcfg -log simulate.log

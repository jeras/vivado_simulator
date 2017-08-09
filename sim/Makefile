PATH_LIB=$(XILINX_VIVADO)/data/verilog/src
PATH_RTL=../rtl
PATH_TBN=../tbn

# secure IP
#LIB=$(PATH_LIB)/glbl.v

# TODO: VIP for AXI4 memory mapped interfaces, and ZYNQ PS

# testbench files
TBN_PKG =$(wildcard $(PATH_TBN)/*_pkg.sv)
TBN_SRC =$(wildcard $(PATH_TBN)/*.sv)
TBN_DIF =$(filter-out $(TBN_PKG),$(TBN_SRC))
SRC = $(TBN_PKG) $(TBN_DIF)
SRC+= #LIB=$(PATH_LIB)/glbl.v

# targets
TGT=$(RTL:.sv=)

OPT =-L xil_common_vip_v1_0_0
OPT+=-L axi4stream_vip_v1_0_1
OPT+=-L xil_defaultlib

OPT+=--include $(XILINX_VIVADO)/data/ip/xilinx/axi_vip_v1_0/hdl
OPT+=--include $(XILINX_VIVADO)/data/ip/xilinx/xil_common_vip_v1_0/hdl/
OPT+=--include $(XILINX_VIVADO)/data/ip/xilinx/axi4stream_vip_v1_0/hdl
OPT+=--include $(XILINX_VIVADO)/data/ip/xilinx/processing_system7_vip_v1_0/hdl/

.PHONY: compile elborate

all: $(TGT)

compile: $(SRC)
	$(foreach file,$(TBN),xvlog                     --sv --work xil_defaultlib $(file);)
#	$(foreach file,$(TBN),xvlog -m64 --relax $(OPT) --sv --work xil_defaultlib $(file);)

elaborate: compile

%_tb: elaborate
	xelab --debug typical --relax \
	-L unisims_ver -L unimacro_ver -L secureip \
	--snapshot $@ xil_defaultlib.$@
	xsim $@ -gui -wdb simulate_xsim.wdb

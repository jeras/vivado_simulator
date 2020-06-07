MOD=axisim_tb

# compile sources
xvlog --incr --relax -L axi_vip_v1_1_7 -L xilinx_vip -prj ${MOD}_vlog.prj

# elaborate design
xelab -wto b3ce32971b074427ad53c722ac80f042 --incr --debug typical --relax --mt 8 \
-L xil_defaultlib \
-L axi_infrastructure_v1_1_0 \
-L axi_vip_v1_1_7 \
-L xilinx_vip \
-L unisims_ver \
-L unimacro_ver \
-L secureip \
-L xpm \
--snapshot ${MOD}_behav xil_defaultlib.${MOD} xil_defaultlib.glbl \
-log elaborate.log

# simulate design
xsim ${MOD}_behav \
-key {Behavioral:sim_all_config:Functional:${MOD}} \
-tclbatch {${MOD}.tcl} \
-protoinst "axi_sim.protoinst" \
-log {simulate.log} \
#-gui

///////////////////////////////////////////////////////////////////////////
//NOTE: This file has been automatically generated by Vivado.
///////////////////////////////////////////////////////////////////////////
`timescale 1ps/1ps
package axi_vip_slv_pkg;
import axi_vip_pkg::*;
///////////////////////////////////////////////////////////////////////////
// These parameters are named after the component for use in your verification 
// environment.
///////////////////////////////////////////////////////////////////////////
      parameter axi_vip_slv_VIP_PROTOCOL           = 2;
      parameter axi_vip_slv_VIP_READ_WRITE_MODE    = "READ_WRITE";
      parameter axi_vip_slv_VIP_INTERFACE_MODE     = 2;
      parameter axi_vip_slv_VIP_ADDR_WIDTH         = 32;
      parameter axi_vip_slv_VIP_DATA_WIDTH         = 32;
      parameter axi_vip_slv_VIP_ID_WIDTH           = 0;
      parameter axi_vip_slv_VIP_AWUSER_WIDTH       = 0;
      parameter axi_vip_slv_VIP_ARUSER_WIDTH       = 0;
      parameter axi_vip_slv_VIP_RUSER_WIDTH        = 0;
      parameter axi_vip_slv_VIP_WUSER_WIDTH        = 0;
      parameter axi_vip_slv_VIP_BUSER_WIDTH        = 0;
      parameter axi_vip_slv_VIP_SUPPORTS_NARROW    = 0;
      parameter axi_vip_slv_VIP_HAS_BURST          = 0;
      parameter axi_vip_slv_VIP_HAS_LOCK           = 0;
      parameter axi_vip_slv_VIP_HAS_CACHE          = 0;
      parameter axi_vip_slv_VIP_HAS_REGION         = 0;
      parameter axi_vip_slv_VIP_HAS_QOS            = 0;
      parameter axi_vip_slv_VIP_HAS_PROT           = 1;
      parameter axi_vip_slv_VIP_HAS_WSTRB          = 1;
      parameter axi_vip_slv_VIP_HAS_BRESP          = 1;
      parameter axi_vip_slv_VIP_HAS_RRESP          = 1;
      parameter axi_vip_slv_VIP_HAS_ACLKEN         = 0;
      parameter axi_vip_slv_VIP_HAS_ARESETN        = 1;
///////////////////////////////////////////////////////////////////////////


typedef axi_slv_agent #(axi_vip_slv_VIP_PROTOCOL, 
                        axi_vip_slv_VIP_ADDR_WIDTH,
                        axi_vip_slv_VIP_DATA_WIDTH,
                        axi_vip_slv_VIP_DATA_WIDTH,
                        axi_vip_slv_VIP_ID_WIDTH,
                        axi_vip_slv_VIP_ID_WIDTH,
                        axi_vip_slv_VIP_AWUSER_WIDTH, 
                        axi_vip_slv_VIP_WUSER_WIDTH, 
                        axi_vip_slv_VIP_BUSER_WIDTH, 
                        axi_vip_slv_VIP_ARUSER_WIDTH,
                        axi_vip_slv_VIP_RUSER_WIDTH, 
                        axi_vip_slv_VIP_SUPPORTS_NARROW, 
                        axi_vip_slv_VIP_HAS_BURST,
                        axi_vip_slv_VIP_HAS_LOCK,
                        axi_vip_slv_VIP_HAS_CACHE,
                        axi_vip_slv_VIP_HAS_REGION,
                        axi_vip_slv_VIP_HAS_PROT,
                        axi_vip_slv_VIP_HAS_QOS,
                        axi_vip_slv_VIP_HAS_WSTRB,
                        axi_vip_slv_VIP_HAS_BRESP,
                        axi_vip_slv_VIP_HAS_RRESP,
                        axi_vip_slv_VIP_HAS_ARESETN) axi_vip_slv_slv_t;

typedef axi_slv_mem_agent #(axi_vip_slv_VIP_PROTOCOL, 
                        axi_vip_slv_VIP_ADDR_WIDTH,
                        axi_vip_slv_VIP_DATA_WIDTH,
                        axi_vip_slv_VIP_DATA_WIDTH,
                        axi_vip_slv_VIP_ID_WIDTH,
                        axi_vip_slv_VIP_ID_WIDTH,
                        axi_vip_slv_VIP_AWUSER_WIDTH, 
                        axi_vip_slv_VIP_WUSER_WIDTH, 
                        axi_vip_slv_VIP_BUSER_WIDTH, 
                        axi_vip_slv_VIP_ARUSER_WIDTH,
                        axi_vip_slv_VIP_RUSER_WIDTH, 
                        axi_vip_slv_VIP_SUPPORTS_NARROW, 
                        axi_vip_slv_VIP_HAS_BURST,
                        axi_vip_slv_VIP_HAS_LOCK,
                        axi_vip_slv_VIP_HAS_CACHE,
                        axi_vip_slv_VIP_HAS_REGION,
                        axi_vip_slv_VIP_HAS_PROT,
                        axi_vip_slv_VIP_HAS_QOS,
                        axi_vip_slv_VIP_HAS_WSTRB,
                        axi_vip_slv_VIP_HAS_BRESP,
                        axi_vip_slv_VIP_HAS_RRESP,
                        axi_vip_slv_VIP_HAS_ARESETN) axi_vip_slv_slv_mem_t;
                        
      
///////////////////////////////////////////////////////////////////////////
// How to start the verification component
///////////////////////////////////////////////////////////////////////////
//      axi_vip_slv_slv_t  axi_vip_slv_slv;
//      initial begin : START_axi_vip_slv_SLAVE
//        axi_vip_slv_slv = new("axi_vip_slv_slv", `axi_vip_slv_PATH_TO_INTERFACE);
//        axi_vip_slv_slv.start_slave();
//      end

endpackage : axi_vip_slv_pkg

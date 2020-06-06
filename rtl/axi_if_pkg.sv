package axi_if_pkg;

typedef struct {
  int unsigned PROTOCOL       ;
  int unsigned INTERFACE_MODE ;
  int unsigned ADDR_WIDTH     ; 
  int unsigned WDATA_WIDTH    ; 
  int unsigned RDATA_WIDTH    ; 
  int unsigned WID_WIDTH      ;
  int unsigned RID_WIDTH      ;
  int unsigned AWUSER_WIDTH   ;
  int unsigned WUSER_WIDTH    ;
  int unsigned BUSER_WIDTH    ;
  int unsigned ARUSER_WIDTH   ;
  int unsigned RUSER_WIDTH    ;
  int unsigned SUPPORTS_NARROW;
  int unsigned HAS_BURST      ;
  int unsigned HAS_LOCK       ;
  int unsigned HAS_CACHE      ;
  int unsigned HAS_REGION     ;
  int unsigned HAS_PROT       ;
  int unsigned HAS_QOS        ;
  int unsigned HAS_WSTRB      ;
  int unsigned HAS_BRESP      ;
  int unsigned HAS_RRESP      ;
  int unsigned HAS_ARESETN    ;
} axi_prm_t;

endpackage: axi_if_pkg

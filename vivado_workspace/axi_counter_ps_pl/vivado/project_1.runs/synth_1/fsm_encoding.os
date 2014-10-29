
 add_fsm_encoding \
       {axi_datamover_ibttcc.sig_csm_state} \
       { }  \
       {{000 00000010} {001 00000100} {010 00010000} {011 00100000} {100 01000000} {101 00001000} {110 10000000} }

 add_fsm_encoding \
       {axi_datamover_ibttcc.sig_psm_state} \
       { }  \
       {{000 0000010} {001 0000100} {010 0001000} {011 0010000} {100 1000000} {111 0100000} }

 add_fsm_encoding \
       {axi_datamover_s2mm_realign.sig_cmdcntl_sm_state} \
       { }  \
       {{000 0000010} {001 0000100} {010 0010000} {011 0100000} {100 1000000} {101 0001000} }

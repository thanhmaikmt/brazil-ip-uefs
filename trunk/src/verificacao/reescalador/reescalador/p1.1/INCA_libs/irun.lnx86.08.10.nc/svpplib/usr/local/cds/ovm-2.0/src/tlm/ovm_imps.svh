// $Id: //dvt/vtech/dev/main/ovm/src/tlm/ovm_imps.svh#8 $
//----------------------------------------------------------------------
//   Copyright 2007-2008 Mentor Graphics Corporation
//   Copyright 2007-2008 Cadence Design Systems, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------

// ovm_blocking_put_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 22. 
// Original header declaration: 
//   class ovm_blocking_put_imp  #(type T=int, type IMP=int)



// ovm_nonblocking_put_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 28. 
// Original header declaration: 
//   class ovm_nonblocking_put_imp  #(type T=int, type IMP=int)



// ovm_put_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 34. 
// Original header declaration: 
//   class ovm_put_imp  #(type T=int, type IMP=int)
`include "ovm_put_imp_ovm_sequence_item_tlm_fifo_base_ovm_sequence_item.svi"
`include "ovm_put_imp_reescalador_input_tlm_fifo_base_reescalador_input.svi"
`include "ovm_put_imp_reescalador_output_tlm_fifo_base_reescalador_output.svi"



// ovm_blocking_get_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 40. 
// Original header declaration: 
//   class ovm_blocking_get_imp  #(type T=int, type IMP=int)



// ovm_nonblocking_get_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 46. 
// Original header declaration: 
//   class ovm_nonblocking_get_imp  #(type T=int, type IMP=int)



// ovm_get_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 52. 
// Original header declaration: 
//   class ovm_get_imp  #(type T=int, type IMP=int)



// ovm_blocking_peek_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 58. 
// Original header declaration: 
//   class ovm_blocking_peek_imp  #(type T=int, type IMP=int)



// ovm_nonblocking_peek_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 64. 
// Original header declaration: 
//   class ovm_nonblocking_peek_imp  #(type T=int, type IMP=int)



// ovm_peek_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 70. 
// Original header declaration: 
//   class ovm_peek_imp  #(type T=int, type IMP=int)



// ovm_blocking_get_peek_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 76. 
// Original header declaration: 
//   class ovm_blocking_get_peek_imp  #(type T=int, type IMP=int)



// ovm_nonblocking_get_peek_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 82. 
// Original header declaration: 
//   class ovm_nonblocking_get_peek_imp  #(type T=int, type IMP=int)



// ovm_get_peek_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 88. 
// Original header declaration: 
//   class ovm_get_peek_imp  #(type T=int, type IMP=int)
`include "ovm_get_peek_imp_ovm_sequence_item_tlm_fifo_base_ovm_sequence_item.svi"
`include "ovm_get_peek_imp_reescalador_input_tlm_fifo_base_reescalador_input.svi"
`include "ovm_get_peek_imp_reescalador_output_tlm_fifo_base_reescalador_output.svi"



//
// All the master and slave imps have two modes of operation.
//
// The first could be described as normal but unusual. In other words
// it fits the pattern of the other imps but in practise is unusual.
//
// This is when there is a single class  (type IMP) that implements the
// entire interface, and imp -= req_imp == rsp_imp.
//
// The reason this is unusual is that we do not have C++ style name
// mangling in SV, so such a channel will not be able to implement both
// a master and a slave interface, even if REQ != RSP
//
// The abnormal but more usual pattern is where two siblings implement
// the request and response methods. In this case req_imp and rsp_imp
// are children of imp, as is the implementation itself.
//
// This second pattern is used in tlm_req_rsp_channel, for example.
//

// ovm_blocking_master_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 114. 
// Original header declaration: 
//   class ovm_blocking_master_imp  #(type REQ=int, type RSP=int, type IMP=int,
//                                 type REQ_IMP=IMP, type RSP_IMP=IMP)



// ovm_nonblocking_master_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 125. 
// Original header declaration: 
//   class ovm_nonblocking_master_imp  #(type REQ=int, type RSP=int, type IMP=int,
//                                    type REQ_IMP=IMP, type RSP_IMP=IMP)



// ovm_master_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 136. 
// Original header declaration: 
//   class ovm_master_imp  #(type REQ=int, type RSP=int, type IMP=int,
//                        type REQ_IMP=IMP, type RSP_IMP=IMP)



// ovm_blocking_slave_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 147. 
// Original header declaration: 
//   class ovm_blocking_slave_imp  #(type REQ=int, type RSP=int, type IMP=int,
//                                type REQ_IMP=IMP, type RSP_IMP=IMP)



// ovm_nonblocking_slave_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 158. 
// Original header declaration: 
//   class ovm_nonblocking_slave_imp  #(type REQ=int, type RSP=int, type IMP=int,
//                                   type REQ_IMP=IMP, type RSP_IMP=IMP)



// ovm_slave_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 169. 
// Original header declaration: 
//   class ovm_slave_imp  #(type REQ=int, type RSP=int, type IMP=int,
//                       type REQ_IMP=IMP, type RSP_IMP=IMP)



// ovm_blocking_transport_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 180. 
// Original header declaration: 
//   class ovm_blocking_transport_imp  #(type REQ=int, type RSP=int, type IMP=int)



// ovm_nonblocking_transport_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 186. 
// Original header declaration: 
//   class ovm_nonblocking_transport_imp  #(type REQ=int, type RSP=int, type IMP=int)



// ovm_transport_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 192. 
// Original header declaration: 
//   class ovm_transport_imp  #(type REQ=int, type RSP=int, type IMP=int)



// ovm_analysis_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/ovm_imps.svh, line 199. 
// Original header declaration: 
//   class ovm_analysis_imp  #(type T=int, type IMP=int)
`include "ovm_analysis_imp_ovm_sequence_item_sequencer_analysis_fifo_ovm_sequence_item.svi"



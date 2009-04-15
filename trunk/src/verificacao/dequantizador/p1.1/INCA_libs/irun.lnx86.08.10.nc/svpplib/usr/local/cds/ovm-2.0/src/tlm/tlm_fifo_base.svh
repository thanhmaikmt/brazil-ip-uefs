// $Id:  //dvt/vtech/dev/main/ovm/src/tlm/tlm_fifo_base.svh#5 $
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

`define TLM_FIFO_TASK_ERROR "fifo channel task not implemented"
`define TLM_FIFO_FUNCTION_ERROR "fifo channel function not implemented"

//----------------------------------------------------------------------
// CLASS tlm_event
//----------------------------------------------------------------------
class tlm_event;
  event trigger;
endclass

//----------------------------------------------------------------------
// CLASS tlm_fifo_base
//----------------------------------------------------------------------
// tlm_fifo_base - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/tlm_fifo_base.svh, line 35. 
// Original header declaration: 
//   virtual class tlm_fifo_base  #(type T = int)
`include "tlm_fifo_base_ovm_sequence_item.svi"
`include "tlm_fifo_base_dequantizador_input.svi"
`include "tlm_fifo_base_dequantizador_output.svi"



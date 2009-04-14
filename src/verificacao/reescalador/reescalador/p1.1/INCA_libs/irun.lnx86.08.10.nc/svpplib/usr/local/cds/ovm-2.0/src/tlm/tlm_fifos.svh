// $Id: //dvt/vtech/dev/main/ovm/src/tlm/tlm_fifos.svh#21 $
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

typedef class tlm_event;

//----------------------------------------------------------------------
// CLASS tlm_fifo
//----------------------------------------------------------------------
// tlm_fifo - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/tlm_fifos.svh, line 27. 
// Original header declaration: 
//   class tlm_fifo  #(type T = int)
`include "tlm_fifo_ovm_sequence_item.svi"
`include "tlm_fifo_reescalador_input.svi"
`include "tlm_fifo_reescalador_output.svi"

 

//----------------------------------------------------------------------
// CLASS tlm_analysis_fifo
//----------------------------------------------------------------------

// An tlm_analysis_fifo is an unbounded tlm_fifo that also implements and 
// exports the write interfaces.
//
// It is very useful in objects such as scoreboards which need to be
// connected to monitors.

// tlm_analysis_fifo - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/tlm_fifos.svh, line 151. 
// Original header declaration: 
//   class tlm_analysis_fifo  #(type T = int)



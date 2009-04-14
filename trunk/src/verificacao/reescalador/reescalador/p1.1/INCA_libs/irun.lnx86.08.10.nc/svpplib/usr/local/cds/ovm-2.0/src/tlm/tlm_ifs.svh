// $Id: //dvt/vtech/dev/main/ovm/src/tlm/tlm_ifs.svh#7 $
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

//----------------------------------------------------------------------
//
// TLM Interfaces
//
//----------------------------------------------------------------------
//
// The unidirectional TLM interfaces are divided into put, get and peek
// interfaces, and blocking, nonblocking and combined interfaces.
// 
// A blocking call always succeeds, but may need to consume time to do
// so. As a result, these methods must be tasks.
//
// A nonblocking call may not succeed, but consumes no time. As a result,
// these methods are functions.
//
// The difference between get and peek is that get consumes the data
// while peek does not. So successive calls to peek with no calls get
// or try_get are guaranteed to return the same value.
//
// The transport interface is a bidirectional blocking interface used
// when the request and response are tightly coupled in a one to one
// relationship.
//----------------------------------------------------------------------

`define TASK_ERROR "TLM interface task not implemented"
`define FUNCTION_ERROR "TLM interface function not implemented"

// tlm_if_base - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/tlm_ifs.svh, line 49. 
// Original header declaration: 
//   virtual class tlm_if_base  #(type T1=int, type T2=int)
`include "tlm_if_base_ovm_sequence_item_ovm_sequence_item.svi"
`include "tlm_if_base_reescalador_input_reescalador_input.svi"
`include "tlm_if_base_reescalador_output_reescalador_output.svi"




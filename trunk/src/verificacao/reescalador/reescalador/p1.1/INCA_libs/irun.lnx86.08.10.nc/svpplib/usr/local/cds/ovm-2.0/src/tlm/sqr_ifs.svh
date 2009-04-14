// $Id: sqr_ifs.svh,v 1.3 2008/10/09 14:59:10 jlrose Exp $
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
// sequencer interfaces
//----------------------------------------------------------------------

`define SEQ_ITEM_TASK_ERROR "Sequencer interface task not implemented"
`define SEQ_ITEM_FUNCTION_ERROR "Sequencer interface function not implemented"

//----------------------------------------------------------------------
// ovm_sqr_pull_if
//----------------------------------------------------------------------
// sqr_if_base - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/sqr_ifs.svh, line 33. 
// Original header declaration: 
//   virtual class sqr_if_base  #(type T1=ovm_object, T2=T1)
`include "sqr_if_base_ovm_sequence_item_ovm_sequence_item.svi"



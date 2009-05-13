// $Id: sqr_ifs.svh,v 1.2 2008/08/14 15:47:03 jlrose Exp $
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



`define SEQ_ITEM_GET_NEXT_ITEM_MASK       (1<<0)
`define SEQ_ITEM_TRY_NEXT_ITEM_MASK       (1<<1)
`define SEQ_ITEM_ITEM_DONE_MASK           (1<<2)
`define SEQ_ITEM_HAS_DO_AVAILABLE_MASK    (1<<3)
`define SEQ_ITEM_WAIT_FOR_SEQUENCES_MASK  (1<<4)
`define SEQ_ITEM_PUT_RESPONSE_MASK        (1<<5)
`define SEQ_ITEM_PUT_MASK                 (1<<6)
`define SEQ_ITEM_GET_MASK                 (1<<7)
`define SEQ_ITEM_PEEK_MASK                (1<<8)

`define SEQ_ITEM_PULL_MASK  (`SEQ_ITEM_GET_NEXT_ITEM_MASK | `SEQ_ITEM_TRY_NEXT_ITEM_MASK | \
                        `SEQ_ITEM_ITEM_DONE_MASK | `SEQ_ITEM_HAS_DO_AVAILABLE_MASK |  \
                        `SEQ_ITEM_WAIT_FOR_SEQUENCES_MASK | `SEQ_ITEM_PUT_RESPONSE_MASK | \
                        `SEQ_ITEM_PUT_MASK | `SEQ_ITEM_GET_MASK | `SEQ_ITEM_PEEK_MASK)

`define SEQ_ITEM_UNI_PULL_MASK (`SEQ_ITEM_GET_NEXT_ITEM_MASK | `SEQ_ITEM_TRY_NEXT_ITEM_MASK | \
                           `SEQ_ITEM_ITEM_DONE_MASK | `SEQ_ITEM_HAS_DO_AVAILABLE_MASK | \
                           `SEQ_ITEM_WAIT_FOR_SEQUENCES_MASK | `SEQ_ITEM_GET_MASK | \
                           `SEQ_ITEM_PEEK_MASK)

`define SEQ_ITEM_PUSH_MASK  (`SEQ_ITEM_PUT_MASK)

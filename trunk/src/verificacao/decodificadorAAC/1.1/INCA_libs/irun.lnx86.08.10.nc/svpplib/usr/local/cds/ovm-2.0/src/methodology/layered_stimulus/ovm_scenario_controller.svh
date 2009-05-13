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

typedef enum {FIFO, WEIGHTED, RANDOM, STRICT_FIFO, STRICT_RANDOM, USER} ARBITRATION_TYPE;

`ifndef INCA
// INCA doesn't like this 
typedef class ovm_scenario_base;
`endif

  
// ovm_scenario_controller - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/layered_stimulus/ovm_scenario_controller.svh, line 29. 
// Original header declaration: 
//   class ovm_scenario_controller  #(type REQ = ovm_transaction,
//                                 type RSP = ovm_transaction)




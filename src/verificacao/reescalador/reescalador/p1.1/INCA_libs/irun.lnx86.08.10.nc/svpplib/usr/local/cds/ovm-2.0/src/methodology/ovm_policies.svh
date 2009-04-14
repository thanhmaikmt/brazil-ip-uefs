// $Id: //dvt/vtech/dev/main/ovm/src/methodology/ovm_policies.svh#3 $
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

`ifndef OVM_POLICIES_SVH
`define OVM_POLICIES_SVH

// comp, convert and clone policy classes for built in types
// and classes.
// 
// These are for passing in as parameters to standard
// components such as tlm_fifo and in_order_comparator
//

//
// Built in type comparator, converter and clone
//

//----------------------------------------------------------------------
// CLASS ovm_built_in_comp
//----------------------------------------------------------------------
// ovm_built_in_comp - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_policies.svh, line 39. 
// Original header declaration: 
//   class ovm_built_in_comp  #( type T = int )



//----------------------------------------------------------------------
// CLASS ovm_built_in_converter
//----------------------------------------------------------------------
// ovm_built_in_converter - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_policies.svh, line 50. 
// Original header declaration: 
//   class ovm_built_in_converter  #( type T = int )



//----------------------------------------------------------------------
// class ovm_built_in_clone
//----------------------------------------------------------------------
// ovm_built_in_clone - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_policies.svh, line 63. 
// Original header declaration: 
//   class ovm_built_in_clone  #( type T = int )



//
// Class comparator, converter, clone
//
// Assumes comp, converter and clone functions in all classes
//

//----------------------------------------------------------------------
// CLASS ovm_class_comp
//----------------------------------------------------------------------
// ovm_class_comp - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_policies.svh, line 80. 
// Original header declaration: 
//   class ovm_class_comp  #( type T = int )



//----------------------------------------------------------------------
// CLASS ovm_class_converter
//----------------------------------------------------------------------
// ovm_class_converter - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_policies.svh, line 91. 
// Original header declaration: 
//   class ovm_class_converter  #( type T = int )



//----------------------------------------------------------------------
// CLASS ovm_class_clone
//----------------------------------------------------------------------
// ovm_class_clone - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_policies.svh, line 102. 
// Original header declaration: 
//   class ovm_class_clone  #( type T = int )



`endif // OVM_POLICIES_SVH

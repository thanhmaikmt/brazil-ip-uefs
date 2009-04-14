//------------------------------------------------------------------------------
//   Copyright 2007-2008 Mentor Graphics Corporation
//   Copyright 2007-2008 Cadence Design Systems, Inc.
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the "License"); you may not
//   use this file except in compliance with the License.  You may obtain a copy
//   of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//   WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//   License for the specific language governing permissions and limitations
//   under the License.
//------------------------------------------------------------------------------

typedef enum {
  OVM_PORT ,
  OVM_EXPORT ,
  OVM_IMPLEMENTATION
} ovm_port_type_e;

`const int OVM_UNBOUNDED_CONNECTIONS = -1;
`const string s_connection_error_id = "Connection Error";
`const string s_connection_warning_id = "Connection Warning";
`const string s_spaces = "                       ";

typedef class ovm_port_component_base;
typedef ovm_port_component_base ovm_port_list[string];

//------------------------------------------------------------------------------
//
// CLASS: ovm_port_component_base
//
//------------------------------------------------------------------------------
// This class defines an interface for obtaining a port's connectivity lists
// after or during the end_of_elaboration phase.  The sub-class,
// ovm_port_component #(PORT), implements this interface.
//
// The connectivity lists are returned in the form of handles to objects of this
// type. This allowing traversal of any port's fan-out and fan-in network
// through recursive calls to get_connected_to and get_provided_to. Each port's
// full name and type name can be retrieved using get_full_name and
// get_type_name methods inherited from ovm_component.
//------------------------------------------------------------------------------

virtual class ovm_port_component_base extends ovm_component;
   
  function new (string name, ovm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void get_connected_to(ref ovm_port_list list); endfunction
  virtual function void get_provided_to(ref ovm_port_list list); endfunction

  virtual function bit is_port(); endfunction
  virtual function bit is_export(); endfunction
  virtual function bit is_imp(); endfunction

endclass


//------------------------------------------------------------------------------
//
// CLASS: ovm_port_component #(PORT)
//
//------------------------------------------------------------------------------
// See description of ovm_port_base for information about this class
//------------------------------------------------------------------------------


// ovm_port_component - specializations 
// File /usr/local/cds/ovm-2.0/src/base/ovm_port_base.svh, line 74. 
// Original header declaration: 
//   class ovm_port_component  #(type PORT=ovm_void)
`include "ovm_port_component_ovm_port_base_sqr_if_base_ovm_sequence_item_ovm_sequence_item.svi"
`include "ovm_port_component_ovm_port_base_tlm_if_base_ovm_sequence_item_ovm_sequence_item.svi"
`include "ovm_port_component_ovm_port_base_tlm_if_base_reescalador_input_reescalador_input.svi"
`include "ovm_port_component_ovm_port_base_tlm_if_base_reescalador_output_reescalador_output.svi"




//------------------------------------------------------------------------------
//
// CLASS: ovm_port_base #(IF)
//
//------------------------------------------------------------------------------
//
// The base class for ports, exports, and implementations (imps). The template
// parameter, IF, specifies the base interface class for the port.  Derivations
// of this class must then implement that interface.
//
// The ovm_port_base class provides the means to connect the ports together.
// Later, after a process called "binding resolution," each port and export holds
// a list of all imps that connect to it, directly or indirectly via other ports
// and exports. In effect, we are collapsing the port's fanout, which can span
// several levels of hierarchy up and down, into a single array held local to the
// port. When accessing the interface via the port at run-time, the port merely
// looks up the indexed interface in this list and calls the appropriate
// interface method. 
//
// SV does not support multiple inheritance. Thus, two classes are used
// to define a single, logical port: ovm_port_base, which inherits from the
// user's interface class, and ovm_port_component, which inherits from
// ovm_component.  The ovm_port_base class constructor creates an instance of
// the ovm_port_component and passes a handle to itself to its constructor,
// effectively linking the two.
// 
// The OVM provides a complete set of ports, exports, and imps for the OSCI-
// standard TLM interfaces. These can be found in the .../src/tlm/ directory.
//
// get_name
// get_full_name
// get_parent
//   These methods provide the leaf name, the full name, and the handle to the
//   parent component, respectively. The implementations of these methods 
//   delegate to the port's component proxy. 
//
// min_size
// max_size
//   Returns the lower and upper bound on the required number of imp
//   connections.
//
// is_unbounded
//   Returns 1 if the max_size is set to OVM_UNBOUNDED_CONNECTIONS.
//
// is_port
// is_export
// is_imp
//   Returns 1 if true, 0 if false. The port type is a constructor argument.
//
// size
//   Returns the total number of imps connected to this port. The number is
//   only valid at and after the end_of_elaboration phase. It is 0 before then.
//
// set_if
//   Sets the default imp to use when calling an interface method. The default
//   is 0.  Use this to access a specific imp when size() > 0.
//
// connect
//   Binds this port to another port given as an argument after validating the
//   legality of the connection. See the connect and m_check_relationship
//   method implementations for more information.
//
// resolve_bindings
//   This callback is called just before entering the end_of_elaboration phase.
//   It recurses through this port's fanout to determine all the imp destina-
//   tions. It then checks against the required min and max connections.
//   After resolution, size() returns a valid value and set_if() can be used
//   to access a particular imp.
//   
//------------------------------------------------------------------------------

// ovm_port_base - specializations 
// File /usr/local/cds/ovm-2.0/src/base/ovm_port_base.svh, line 197. 
// Original header declaration: 
//   virtual class ovm_port_base  #(type IF=ovm_void)
`include "ovm_port_base_sqr_if_base_ovm_sequence_item_ovm_sequence_item.svi"
`include "ovm_port_base_tlm_if_base_ovm_sequence_item_ovm_sequence_item.svi"
`include "ovm_port_base_tlm_if_base_reescalador_input_reescalador_input.svi"
`include "ovm_port_base_tlm_if_base_reescalador_output_reescalador_output.svi"




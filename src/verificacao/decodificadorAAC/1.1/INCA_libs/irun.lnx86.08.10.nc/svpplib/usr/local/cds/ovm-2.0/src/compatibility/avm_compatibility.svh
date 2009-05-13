// $Id: avm_compatibility.svh,v 1.12 2008/07/18 10:15:20 redelman Exp $
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
`ifndef AVM_compatibility_SVH
`define AVM_compatibility_SVH

typedef ovm_object	       avm_transaction;
typedef ovm_env                avm_env;
typedef ovm_component          avm_threaded_component;
typedef ovm_component          avm_named_component;
typedef ovm_report_object      avm_report_client;
typedef ovm_report_handler     avm_report_handler;
typedef ovm_report_server      avm_report_server;
typedef ovm_reporter           avm_reporter;



typedef enum
{
  MESSAGE,
  WARNING,
  ERROR,
  FATAL
} severity;

typedef bit [4:0] action;

typedef enum action
{
  NO_ACTION = 5'b00000,
  DISPLAY   = 5'b00001,
  LOG       = 5'b00010,
  COUNT     = 5'b00100,
  EXIT      = 5'b01000,
  CALL_HOOK = 5'b10000
} action_type;


// So that you can just change Avm_ to Ovm_
typedef ovm_component          ovm_named_component;
typedef ovm_report_object      ovm_report_client;

`ifndef INCA
`ifndef SVPP

`define avm_to_ovm_uni(kind) \
class avm_``kind``_port #(type T=int) extends ovm_``kind``_port #(T); \
function new( string name, ovm_component parent, int min_size = 1, int max_size = 1 ); \
      super.new( name, parent, min_size, max_size ); \
endfunction : new \
endclass \
class avm_``kind``_export #(type T=int) extends ovm_``kind``_export #(T); \
function new( string name, ovm_component parent, int min_size = 1, int max_size = 1 ); \
      super.new( name, parent, min_size, max_size ); \
endfunction : new \
endclass \
class avm_``kind``_imp #(type T=int,IMP=int) extends ovm_``kind``_imp #(T,IMP); \
function new( string name, IMP imp); \
      super.new( name, imp ); \
endfunction : new \
endclass \

`define avm_to_ovm_bidi(kind) \
class avm_``kind``_port #(type REQ=int,RSP=int) extends ovm_``kind``_port #(REQ,RSP); \
function new( string name, ovm_component parent, int min_size = 1, int max_size = 1 ); \
      super.new( name, parent, min_size, max_size ); \
endfunction : new \
endclass \
class avm_``kind``_export #(type REQ=int,RSP=int) extends ovm_``kind``_export #(REQ,RSP); \
function new( string name, ovm_component parent, int min_size = 1, int max_size = 1 ); \
      super.new( name, parent, min_size, max_size ); \
endfunction : new \
endclass \
class avm_``kind``_imp #( type REQ = int , type RSP = int ,\
				type IMP = int ,\
				type REQ_IMP = IMP ,\
				type RSP_IMP = IMP )\
  extends ovm_``kind``_imp #( REQ, RSP, IMP, REQ_IMP, RSP_IMP);\
   function new( string name , IMP imp ,\
		 REQ_IMP req_imp = imp , RSP_IMP rsp_imp = imp );\
     super.new( name , imp , req_imp, rsp_imp);\
  endfunction \
endclass

`avm_to_ovm_uni(blocking_put)
`avm_to_ovm_uni(nonblocking_put)
`avm_to_ovm_uni(put)

`avm_to_ovm_uni(blocking_get)
`avm_to_ovm_uni(nonblocking_get)
`avm_to_ovm_uni(get)

`avm_to_ovm_uni(blocking_peek)
`avm_to_ovm_uni(nonblocking_peek)
`avm_to_ovm_uni(peek)

`avm_to_ovm_uni(blocking_get_peek)
`avm_to_ovm_uni(nonblocking_get_peek)
`avm_to_ovm_uni(get_peek)

`avm_to_ovm_bidi(blocking_master)
`avm_to_ovm_bidi(nonblocking_master)
`avm_to_ovm_bidi(master)

`avm_to_ovm_bidi(blocking_slave)
`avm_to_ovm_bidi(nonblocking_slave)
`avm_to_ovm_bidi(slave)

// Here we don't use the avm_to_ovm macro because we inherit
// avm_transport_* from ovm_blocking_transport_*.  AVM doesn't support
// nonblocking ad combined transport interface, only a blocking
// transport interface which is simply called "transport"

class avm_transport_port #(type REQ=int,RSP=int)
  extends ovm_blocking_transport_port #(REQ,RSP); 
  function new( string name, ovm_component parent,
                int min_size = 1, int max_size = 1 );
      super.new( name, parent, min_size, max_size );
  endfunction : new
endclass

class avm_transport_export #(type REQ=int,RSP=int)
  extends ovm_blocking_transport_export #(REQ,RSP);
  function new( string name, ovm_component parent,
                int min_size = 1, int max_size = 1 );
      super.new( name, parent, min_size, max_size );
  endfunction : new
endclass

`endif
`endif




// TLM channels
 
// avm_analysis_port - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 168. 
// Original header declaration: 
//   class avm_analysis_port  #(type T=int)

 

 
// avm_analysis_export - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 169. 
// Original header declaration: 
//   class avm_analysis_export  #(type T=int)

 

 
// avm_random_stimulus - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 170. 
// Original header declaration: 
//   class avm_random_stimulus  #(type T=int)

 

 
// avm_subscriber - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 171. 
// Original header declaration: 
//   virtual class avm_subscriber  #(type T=int)

 

//`avm_to_ovm_component(in_order_class_comparator)

// Policies

 
// avm_built_in_comp - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 179. 
// Original header declaration: 
//   class avm_built_in_comp  #(type T=int)

 

 
// avm_built_in_converter - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 180. 
// Original header declaration: 
//   class avm_built_in_converter  #(type T=int)

 

 
// avm_built_in_clone - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 181. 
// Original header declaration: 
//   class avm_built_in_clone  #(type T=int)

 

 
// avm_class_comp - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 182. 
// Original header declaration: 
//   class avm_class_comp  #(type T=int)

 

 
// avm_class_converter - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 183. 
// Original header declaration: 
//   class avm_class_converter  #(type T=int)

 

 
// avm_class_clone - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 184. 
// Original header declaration: 
//   class avm_class_clone  #(type T=int)

 


// avm_built_in_pair - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 184. 
// Original header declaration: 
//   class avm_built_in_pair  #( type T1 = int, type T2 = T1 )



// avm_class_pair - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 192. 
// Original header declaration: 
//   class avm_class_pair  #( type T1 = int, type T2 = T1 )



// avm_in_order_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 200. 
// Original header declaration: 
//   class avm_in_order_comparator  
//   #( type T = int ,
//      type comp_type = avm_built_in_comp #( T ) ,
//      type convert = avm_built_in_converter #( T ) , 
//      type pair_type = avm_built_in_pair #( T ) )



// avm_in_order_class_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 212. 
// Original header declaration: 
//   class avm_in_order_class_comparator  #( type T = int )



// avm_in_order_built_in_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 223. 
// Original header declaration: 
//   class avm_in_order_built_in_comparator  #( type T = int )



// avm_algorithmic_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 233. 
// Original header declaration: 
//   class avm_algorithmic_comparator  #( type BEFORE = int ,
//                                     type AFTER = int  ,
//                                     type TRANSFORMER = int )





// Provides a global reporter and a set of global reporting
// functions.  These can be use in modules or in any class
// not derived from avm_report_client.

//ovm_reporter _global_reporter = new();

function void avm_report_message(string id,
				 string message,
                                 int verbosity = 300,
				 string filename = "",
				 int line = 0);
  _global_reporter.ovm_report_info(id, message, verbosity, filename, line);
endfunction

function void avm_report_warning(string id,
                                 string message,
                                 int verbosity = 200,
				 string filename = "",
				 int line = 0);
  _global_reporter.ovm_report_warning(id, message, verbosity, filename, line);
endfunction

function void avm_report_error(string id,
                               string message,
                               int verbosity = 100,
			       string filename = "",
			       int line = 0);
  _global_reporter.ovm_report_error(id, message, verbosity, filename, line);
endfunction

function void avm_report_fatal(string id,
	                       string message,
                               int verbosity = 0,
			       string filename = "",
			       int line = 0);
  _global_reporter.ovm_report_fatal(id, message, verbosity, filename, line);
endfunction

// analysis_fifo - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 286. 
// Original header declaration: 
//   class analysis_fifo  #(type T = int)



// avm_transport_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 293. 
// Original header declaration: 
//   class avm_transport_imp  #(type REQ = int, type RSP = int, type IMP = int)

 // avm_transport_imp

// avm_analysis_imp - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 300. 
// Original header declaration: 
//   class avm_analysis_imp  #( type T = int , type IMP = int )



// avm_port_base - specializations 
// File /usr/local/cds/ovm-2.0/src/compatibility/avm_compatibility.svh, line 307. 
// Original header declaration: 
//   virtual class avm_port_base  #(type IF = ovm_object)




`endif


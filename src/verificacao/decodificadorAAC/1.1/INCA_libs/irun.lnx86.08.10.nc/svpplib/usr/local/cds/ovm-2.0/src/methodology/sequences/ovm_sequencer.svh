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


  typedef class ovm_sequence_base;

  typedef class ovm_seq_prod_if;
  typedef class ovm_seq_cons_if;

  typedef ovm_seq_item_pull_port_ovm_sequence_item_ovm_sequence_item ovm_seq_item_prod_if;


// ovm_sequencer - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/sequences/ovm_sequencer.svh, line 30. 
// Original header declaration: 
//   class ovm_sequencer  #(type REQ = ovm_sequence_item,
//                       type RSP = REQ)
`include "ovm_sequencer_ovm_sequence_item_ovm_sequence_item.svi"

  

typedef ovm_sequencer_ovm_sequence_item_ovm_sequence_item ovm_virtual_sequencer;

// Deprecated Class
class ovm_seq_prod_if extends ovm_component;

  string producer_name = "NOT CONNECTED";

  // constructor
  function new (string name="", ovm_component parent = null);
    super.new(name, parent);
  endfunction

  // data method do_print
  function void do_print (ovm_printer printer);
    super.do_print(printer);
    printer.print_string("sequence producer", producer_name);
  endfunction

  // polymorphic create method
  function ovm_object create (string name="");
    ovm_seq_prod_if i; i=new(name);
    return i;
  endfunction

  // return proper type name string
  virtual function string get_type_name();
    return "ovm_seq_prod_if";
  endfunction 

  // connect interface method for producer to consumer
  function void connect_if(ovm_seq_cons_if seq_if);
    ovm_component temp_comp;
    $cast(seq_if.consumer_seqr, get_parent());
    temp_comp = seq_if.get_parent();
    producer_name = temp_comp.get_full_name();
  endfunction

  // Macro to enable factory creation
  `ovm_component_registry(ovm_seq_prod_if, "ovm_seq_prod_if")

endclass

// Deprecated Class
class ovm_seq_cons_if extends ovm_component;

  // variable to hold the sequence consumer as an ovm_sequencer if the
  // consumer is that type
  ovm_sequencer_ovm_sequence_item_ovm_sequence_item consumer_seqr;

  // constructor
  function new (string name="", ovm_component parent = null);
    super.new(name, parent);
  endfunction

  // do_print for this object
  function void do_print (ovm_printer printer);
    super.do_print(printer);
    if (consumer_seqr != null)
      printer.print_string("sequence consumer", consumer_seqr.get_full_name());
    else
      printer.print_string("sequence consumer", "NOT_CONNECTED");
  endfunction

  // polymorphic creation
  function ovm_object create (string name="");
    ovm_seq_cons_if i; i=new(name);
    return i;
  endfunction

  // get_type_name implementation
  virtual function string get_type_name();
    return "ovm_seq_cons_if";
  endfunction 

  // method to connect this object to an ovm_sequence_prod_if
  function void connect_if(ovm_seq_prod_if seq_if);
    $cast(consumer_seqr, seq_if.get_parent());;
  endfunction

  // method to query who the current grabber of the connected sequencer is
  function ovm_sequence_base current_grabber();
    return consumer_seqr.current_grabber();
  endfunction
 
  // method to query if the connected sequencer is grabbed
  function bit is_grabbed();
    return consumer_seqr.is_grabbed();
  endfunction

  // method to start a sequence on the connected sequencer
  task start_sequence(ovm_sequence_base this_seq);
    consumer_seqr.start_sequence(this_seq);
  endtask

  // method to grab the connected sequencer
  task grab(ovm_sequence_base this_seq);
    consumer_seqr.grab(this_seq);
  endtask

  // method to ungrab the connected sequencer
  function void ungrab(ovm_sequence_base this_seq);
    consumer_seqr.ungrab(this_seq);
  endfunction

  // method to query if this interface object is connected
  function bit is_connected();
    if (consumer_seqr != null)
      return 1;
    else
      return 0;
  endfunction

  // method to query whether this interface is connected to a virtual sequencer
  // or sequencer
  function bit is_virtual_sequencer();
    ovm_virtual_sequencer vseqr;
    if (consumer_seqr == null)
      ovm_report_fatal("UNCSQR", "Cannot call connected_sequencer_type() on this unconnected interface.");
    else if (!$cast(vseqr, consumer_seqr))
      return 0;
    else
      return 1;
  endfunction

  // method to get the connecte sequencer's type name
  function string get_sequencer_type_name();
    if(consumer_seqr != null)
      return consumer_seqr.get_type_name();
    else
      return "NOT_CONNECTED";
  endfunction

  // Macro to enable factory creation
  `ovm_component_registry(ovm_seq_cons_if, "ovm_seq_cons_if")

endclass



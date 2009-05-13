// $Id: tlm_req_rsp.svh,v 1.10 2008/08/19 10:13:23 redelman Exp $
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

//------------------------------------------------------------------------------
//
// CLASS: tlm_req_rsp_channel
//
//------------------------------------------------------------------------------
// tlm_req_rsp_channel contains a request fifo and a response fifo.
// These fifos can be of any size. This channel is particularly useful
// for modeling pipelined protocols.
//------------------------------------------------------------------------------

// tlm_req_rsp_channel - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/tlm_req_rsp.svh, line 32. 
// Original header declaration: 
//   class tlm_req_rsp_channel  #(type REQ=int, type RSP=int)




//------------------------------------------------------------------------------
//
// CLASS: tlm_transport_channel
//
//------------------------------------------------------------------------------
// tlm_transport_channel is a tlm_req_rsp_channel that implements the
// transport interface. Because the requests and responses have a
// tightly coupled one to one relationship, the fifo sizes must be one.
//------------------------------------------------------------------------------

// tlm_transport_channel - specializations 
// File /usr/local/cds/ovm-2.0/src/tlm/tlm_req_rsp.svh, line 182. 
// Original header declaration: 
//   class tlm_transport_channel  #(type REQ=int, type RSP=int)



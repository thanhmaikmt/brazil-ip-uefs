// $Id: ovm_algorithmic_comparator.svh,v 1.3 2008/08/19 10:13:23 redelman Exp $
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

// 
// This is the algorithmic comparator class.
//
// It compares two different streams of data of types BEFORE
// and AFTER.
//
// The TRANSFORMER is a functor class which has a single
// method function AFTER transform( input BEFORE b ) -
// typically used to encapsulate an algorithm of some sort.
//
// Matches and mistmatches are reported into terms of AFTER
// transactions

// ovm_algorithmic_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_algorithmic_comparator.svh, line 35. 
// Original header declaration: 
//   class ovm_algorithmic_comparator  #( type BEFORE = int ,
//                                     type AFTER = int  ,
//                                     type TRANSFORMER = int )



// $Id: //dvt/vtech/dev/main/ovm/src/methodology/ovm_in_order_comparator.svh#9 $
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
// CLASS in_order_comparator
//
// in_order_comparator : compares two streams of data
//
// makes no assumptions about the relative ordering of the two streams
//
// T is the type of the two streams of data.
//
// comp and convert are functors which describe how to do
// comparison and printing for T.
//
// These parameters can be changed for different T's :
// however, we expect that the two pairs of classes above
// will be OK for most cases. Built in types ( such as ints,
// bits, logic, and structs ) are dealt with by using the
// default functors built_in_comp and built_in_converter, while
// classes should be dealt with by class_comp and
// class_converter, which in turn assume the existence of comp
// and convert2string functions in the class itself.
//----------------------------------------------------------------------

// ovm_in_order_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_in_order_comparator.svh, line 44. 
// Original header declaration: 
//   class ovm_in_order_comparator  
//   #( type T = int ,
//      type comp_type = ovm_built_in_comp #( T ) ,
//      type convert = ovm_built_in_converter #( T ) , 
//      type pair_type = ovm_built_in_pair #( T ) )



//----------------------------------------------------------------------
// CLASS in_order_built_in_comparator
//----------------------------------------------------------------------

// in_order_built_in_comparator uses the default ( ie,
// built_in ) comparison and printing policy classes.

// ovm_in_order_built_in_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_in_order_comparator.svh, line 152. 
// Original header declaration: 
//   class ovm_in_order_built_in_comparator  #( type T = int )

 

//----------------------------------------------------------------------
// CLASS in_order_class_comparator
//----------------------------------------------------------------------

// in_order_class_comparator uses the class comparison and
// printing policy classes. This ultimately relies on the
// existence of comp and convert2string methods in the
// transaction type T

// ovm_in_order_class_comparator - specializations 
// File /usr/local/cds/ovm-2.0/src/methodology/ovm_in_order_comparator.svh, line 179. 
// Original header declaration: 
//   class ovm_in_order_class_comparator  #( type T = int )



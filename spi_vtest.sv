`ifndef SPI_VTEST_INCLUDED_
`define SPI_VTEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_vtest
// <Description_here>
//--------------------------------------------------------------------------------------------
class spi_vtest extends uvm_test;
  `uvm_component_utils(spi_vtest)

  spi_env env;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_vtest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);

endclass : spi_vtest

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - spi_vtest
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_vtest::new(string name = "spi_vtest",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_vtest::build_phase(uvm_phase phase);
  super.build_phase(phase);
  env=spi_env::type_id::create("ENV",this);

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Extended Class
//--------------------------------------------------------------------------------------------
class spi_vtest1 extends spi_vtest
  `uvm_component_utils("spi_vtest1"

spi_virtual_seq vseq;

  extern function new(string name = "spi_vtest", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
endclass

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - spi_vtest
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_vtest::new(string name = "spi_vtest",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction:new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_vtest1::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction:build_phase
//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task spi_vtest::run_phase(uvm_phase phase);

  super.run_phase(phase);
  vseq=spi_virtual_seq::type_id::create("VSEQ");
  phase.raise_objection(this, "spi_vtest");
  vseq.start(env.vseqr)
  phase.drop_objection(this);

endtask : run_phase

`endif


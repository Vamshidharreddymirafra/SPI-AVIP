//--------------------------------------------------------------------------------------------
// SPI Virtual sequence
//--------------------------------------------------------------------------------------------
class spi_virtual_seq extends uvm_sequence#(uvm_sequence_item);
  //--------------------------------------------------------------------------------------------
  // factory registration
  //--------------------------------------------------------------------------------------------
  `uvm_object_utils(spi_virtual_seq)
   spi_virtual_seqr v_seqr;
   //--------------------------------------------------------------------------------------------
   // master and slave sequencer
   //--------------------------------------------------------------------------------------------
   master_seqr m_seqr;
   slave_seqr s_seqr;
   env_cfg cfg;
//--------------------------------------------------------------------------------------------
// extended class handles of master sequences
//--------------------------------------------------------------------------------------------
   M_SPI_FD_8b      m_fd_8b;
   M_SPI_FD_8b_ct   m_fd_spi_ct;
   M_SPI_FD_8b_ct   m_fd_spi_dct;
   M_SPI_RST         m_rst;
   M_SPI_HD_8b      m_hd_8b;
//--------------------------------------------------------------------------------------------
// extended class handles of slave sequences
//--------------------------------------------------------------------------------------------
   S_SPI_FD_8b      s_fd_8b;
   S_SPI_FD_8b_ct   s_fd_spi_ct;
   S_SPI_FD_8b_ct   s_fd_spi_dct;
   S_SPI_RST         s_rst;
   S_SPI_HD_8b      s_hd_8b;

//--------------------------------------------------------------------------------------------
// externally defined tasks and functions
//--------------------------------------------------------------------------------------------
   extern function new(string name="spi_virtual_seq);
   extern task body();
 endclass:spi_virtual_seq

 //--------------------------------------------------------------------------------------------
 // Constructor:new
 //--------------------------------------------------------------------------------------------
 function spi_virual_seq::new(string name="spi_virtual_seq);
   super.new(name);
 endfunction:new

//--------------------------------------------------------------------------------------------
//task:body
//--------------------------------------------------------------------------------------------

 task spi_virtual_seq::body();
   if(!uvm_config_db#(env_cfg) ::get(null,get_full_name(),"env_cfg",cfg))
     `uvm_fatal("V_SEQ","cannot get cfg");
     assert($cast(v_seqr,m_seqr))
      else
      begin
        `uvm_error("body","error in  $cast of virtual sequencer")
      end
     //configuring no of masters and slaves
     m_seqr=new[cfg.no_of_sources];
     s_seqr=new[cfg.no_of_clients];
     m_seqr=v_seqr.m_seqr;
     s_seqr=v_seqr.s_seqr;
endtask:body

//--------------------------------------------------------------------------------------------
// Extended class from virtual sequence
//--------------------------------------------------------------------------------------------
class vseq1 extends virtual_sequence;
  `uvm_object_utils(vseq1)

   extern function new(string name="vseq1");
   extern task body();
 endclass
 //--------------------------------------------------------------------------------------------
 // Constructor:new
 //--------------------------------------------------------------------------------------------

 function vseq1::new(string name="vseq1");
   super.new(name);
//--------------------------------------------------------------------------------------------
// task body
//--------------------------------------------------------------------------------------------

task vseq1::body();
  super.body();
//--------------------------------------------------------------------------------------------
// Creating object for master and slave sequences
//--------------------------------------------------------------------------------------------
m_fd_8b=M_SPI_FD_8b::type_id::create("m_fd_8b");
m_fd_spi_ct=M_SPI_FD_8b_ct::type_id::create("m_fd_spi_ct");
m_fd_spi_dct=M_SPI_FD_8b_dct::type_id::create("m_fd_spi_dct");
m_rst=M_SPI_RST::type_id::create("m_rst");
m_hd_8b=M_SPI_HD_8b::type_id::create("m_hd_8b");

s_fd_8b=S_SPI_FD_8b::type_id::create("s_fd_8b");
s_fd_spi_ct=S_SPI_FD_8b_ct::type_id::create("s_fd_spi_ct");
s_fd_spi_dct=S_SPI_FD_8b_dct::type_id::create("s_fd_spi_dct");
s_rst=S_SPI_RST::type_id::create("s_rst");
s_hd_8b=S_SPI_HD_8b::type_id::create("s_hd_8b");

if(cfg.has_m_agt)
  begin
    for(int i=0; i<cfg.no_of_sources; i++)
    begin
      //starting master sequences
      m_fd_8b.start(m_seqr)
      m_fd_sp_ct.start(m_seqr)
      m_fd_sp_dct.start(m_seqr)
      m_rst.start(m_seqr)
      m_hd_8b.start(m_seqr)
    end
  end

                    
if(cfg.has_s_agt)
  begin
    for(int i=0; i<cfg.no_of_clients; i++)
    begin
      //starting slave sequences
      s_fd_8b.start(s_seqr)
      s_fd_sp_ct.start(s_seqr)
      s_fd_sp_dct.start(s_seqr)
      s_rst.start(s_seqr)
      s_hd_8b.start(s_seqr)
    end
  end
join_any
endtask:body

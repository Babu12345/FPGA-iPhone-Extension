/*
 * Generated by Bluespec Compiler, version 2016.07.beta1 (build 34806, 2016-07-05)
 * 
 * On Sat Nov 10 14:44:02 UTC 2018
 * 
 */
#include "bluesim_primitives.h"
#include "mkTB.h"


/* String declarations */
static std::string const __str_literal_1("The first element in the output vector is: ", 43u);


/* Constructor */
MOD_mkTB::MOD_mkTB(tSimStateHdl simHdl, char const *name, Module *parent)
  : Module(simHdl, name, parent),
    __clk_handle_0(BAD_CLOCK_HANDLE),
    INST_abort(simHdl, "abort", this, 1u, (tUInt8)0u),
    INST_fired(simHdl, "fired", this, 1u, (tUInt8)0u, (tUInt8)0u),
    INST_fired_1(simHdl, "fired_1", this, 1u, (tUInt8)0u),
    INST_running(simHdl, "running", this, 1u, (tUInt8)0u, (tUInt8)0u),
    INST_start_reg(simHdl, "start_reg", this, 1u, (tUInt8)0u, (tUInt8)0u),
    INST_start_reg_1(simHdl, "start_reg_1", this, 1u, (tUInt8)0u, (tUInt8)0u),
    INST_start_reg_2(simHdl, "start_reg_2", this, 1u, (tUInt8)0u),
    INST_start_wire(simHdl, "start_wire", this, 1u, (tUInt8)0u),
    PORT_RST_N((tUInt8)1u)
{
  symbol_count = 15u;
  symbols = new tSym[symbol_count];
  init_symbols_0();
}


/* Symbol init fns */

void MOD_mkTB::init_symbols_0()
{
  init_symbol(&symbols[0u], "abort", SYM_MODULE, &INST_abort);
  init_symbol(&symbols[1u], "fired", SYM_MODULE, &INST_fired);
  init_symbol(&symbols[2u], "fired_1", SYM_MODULE, &INST_fired_1);
  init_symbol(&symbols[3u], "RL_action_l14c9", SYM_RULE);
  init_symbol(&symbols[4u], "RL_auto_finish", SYM_RULE);
  init_symbol(&symbols[5u], "RL_auto_start", SYM_RULE);
  init_symbol(&symbols[6u], "RL_fired__dreg_update", SYM_RULE);
  init_symbol(&symbols[7u], "RL_fsm_start", SYM_RULE);
  init_symbol(&symbols[8u], "RL_restart", SYM_RULE);
  init_symbol(&symbols[9u], "RL_start_reg__dreg_update", SYM_RULE);
  init_symbol(&symbols[10u], "running", SYM_MODULE, &INST_running);
  init_symbol(&symbols[11u], "start_reg", SYM_MODULE, &INST_start_reg);
  init_symbol(&symbols[12u], "start_reg_1", SYM_MODULE, &INST_start_reg_1);
  init_symbol(&symbols[13u], "start_reg_2", SYM_MODULE, &INST_start_reg_2);
  init_symbol(&symbols[14u], "start_wire", SYM_MODULE, &INST_start_wire);
}


/* Rule actions */

void MOD_mkTB::RL_start_reg__dreg_update()
{
  tUInt8 DEF_start_reg_2_whas_AND_start_reg_2_wget___d3;
  DEF_start_reg_2_whas_AND_start_reg_2_wget___d3 = INST_start_reg_2.METH_whas() && INST_start_reg_2.METH_wget();
  INST_start_reg_1.METH_write(DEF_start_reg_2_whas_AND_start_reg_2_wget___d3);
}

void MOD_mkTB::RL_fired__dreg_update()
{
  tUInt8 DEF_fired_1_whas_AND_fired_1_wget___d6;
  DEF_fired_1_whas_AND_fired_1_wget___d6 = INST_fired_1.METH_whas() && INST_fired_1.METH_wget();
  INST_fired.METH_write(DEF_fired_1_whas_AND_fired_1_wget___d6);
}

void MOD_mkTB::RL_restart()
{
  INST_start_wire.METH_wset((tUInt8)1u);
  INST_start_reg_2.METH_wset((tUInt8)1u);
}

void MOD_mkTB::RL_action_l14c9()
{
  INST_fired_1.METH_wset((tUInt8)1u);
  if (!(PORT_RST_N == (tUInt8)0u))
    dollar_display(sim_hdl, this, "s,3", &__str_literal_1, (tUInt8)1u);
}

void MOD_mkTB::RL_fsm_start()
{
  INST_start_wire.METH_wset((tUInt8)1u);
  INST_start_reg_2.METH_wset((tUInt8)1u);
  INST_start_reg.METH_write((tUInt8)0u);
}

void MOD_mkTB::RL_auto_start()
{
  INST_start_reg.METH_write((tUInt8)1u);
  INST_running.METH_write((tUInt8)1u);
}

void MOD_mkTB::RL_auto_finish()
{
  if (!(PORT_RST_N == (tUInt8)0u))
    dollar_finish(sim_hdl, "32", 0u);
}


/* Methods */


/* Reset routines */

void MOD_mkTB::reset_RST_N(tUInt8 ARG_rst_in)
{
  PORT_RST_N = ARG_rst_in;
  INST_start_reg_1.reset_RST(ARG_rst_in);
  INST_start_reg.reset_RST(ARG_rst_in);
  INST_running.reset_RST(ARG_rst_in);
  INST_fired.reset_RST(ARG_rst_in);
}


/* Static handles to reset routines */


/* Functions for the parent module to register its reset fns */


/* Functions to set the elaborated clock id */

void MOD_mkTB::set_clk_0(char const *s)
{
  __clk_handle_0 = bk_get_or_define_clock(sim_hdl, s);
}


/* State dumping routine */
void MOD_mkTB::dump_state(unsigned int indent)
{
  printf("%*s%s:\n", indent, "", inst_name);
  INST_abort.dump_state(indent + 2u);
  INST_fired.dump_state(indent + 2u);
  INST_fired_1.dump_state(indent + 2u);
  INST_running.dump_state(indent + 2u);
  INST_start_reg.dump_state(indent + 2u);
  INST_start_reg_1.dump_state(indent + 2u);
  INST_start_reg_2.dump_state(indent + 2u);
  INST_start_wire.dump_state(indent + 2u);
}


/* VCD dumping routines */

unsigned int MOD_mkTB::dump_VCD_defs(unsigned int levels)
{
  vcd_write_scope_start(sim_hdl, inst_name);
  vcd_num = vcd_reserve_ids(sim_hdl, 9u);
  unsigned int num = vcd_num;
  for (unsigned int clk = 0u; clk < bk_num_clocks(sim_hdl); ++clk)
    vcd_add_clock_def(sim_hdl, this, bk_clock_name(sim_hdl, clk), bk_clock_vcd_num(sim_hdl, clk));
  vcd_write_def(sim_hdl, bk_clock_vcd_num(sim_hdl, __clk_handle_0), "CLK", 1u);
  vcd_write_def(sim_hdl, num++, "RST_N", 1u);
  num = INST_abort.dump_VCD_defs(num);
  num = INST_fired.dump_VCD_defs(num);
  num = INST_fired_1.dump_VCD_defs(num);
  num = INST_running.dump_VCD_defs(num);
  num = INST_start_reg.dump_VCD_defs(num);
  num = INST_start_reg_1.dump_VCD_defs(num);
  num = INST_start_reg_2.dump_VCD_defs(num);
  num = INST_start_wire.dump_VCD_defs(num);
  vcd_write_scope_end(sim_hdl);
  return num;
}

void MOD_mkTB::dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkTB &backing)
{
  vcd_defs(dt, backing);
  vcd_prims(dt, backing);
}

void MOD_mkTB::vcd_defs(tVCDDumpType dt, MOD_mkTB &backing)
{
  unsigned int num = vcd_num;
  if (dt == VCD_DUMP_XS)
  {
    vcd_write_x(sim_hdl, num++, 1u);
  }
  else
    if (dt == VCD_DUMP_CHANGES)
    {
      if ((backing.PORT_RST_N) != PORT_RST_N)
      {
	vcd_write_val(sim_hdl, num, PORT_RST_N, 1u);
	backing.PORT_RST_N = PORT_RST_N;
      }
      ++num;
    }
    else
    {
      vcd_write_val(sim_hdl, num++, PORT_RST_N, 1u);
      backing.PORT_RST_N = PORT_RST_N;
    }
}

void MOD_mkTB::vcd_prims(tVCDDumpType dt, MOD_mkTB &backing)
{
  INST_abort.dump_VCD(dt, backing.INST_abort);
  INST_fired.dump_VCD(dt, backing.INST_fired);
  INST_fired_1.dump_VCD(dt, backing.INST_fired_1);
  INST_running.dump_VCD(dt, backing.INST_running);
  INST_start_reg.dump_VCD(dt, backing.INST_start_reg);
  INST_start_reg_1.dump_VCD(dt, backing.INST_start_reg_1);
  INST_start_reg_2.dump_VCD(dt, backing.INST_start_reg_2);
  INST_start_wire.dump_VCD(dt, backing.INST_start_wire);
}

/*
 * Generated by Bluespec Compiler, version 2016.07.beta1 (build 34806, 2016-07-05)
 * 
 * On Sat Nov 10 14:44:02 UTC 2018
 * 
 */

/* Generation options: */
#ifndef __model_mkTB_h__
#define __model_mkTB_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"

#include "bs_model.h"
#include "mkTB.h"

/* Class declaration for a model of mkTB */
class MODEL_mkTB : public Model {
 
 /* Top-level module instance */
 private:
  MOD_mkTB *mkTB_instance;
 
 /* Handle to the simulation kernel */
 private:
  tSimStateHdl sim_hdl;
 
 /* Constructor */
 public:
  MODEL_mkTB();
 
 /* Functions required by the kernel */
 public:
  void create_model(tSimStateHdl simHdl, bool master);
  void destroy_model();
  void reset_model(bool asserted);
  void get_version(unsigned int *year,
		   unsigned int *month,
		   char const **annotation,
		   char const **build);
  time_t get_creation_time();
  void * get_instance();
  void dump_state();
  void dump_VCD_defs();
  void dump_VCD(tVCDDumpType dt);
  tUInt64 skip_license_check();
};

/* Function for creating a new model */
extern "C" {
  void * new_MODEL_mkTB();
}

#endif /* ifndef __model_mkTB_h__ */

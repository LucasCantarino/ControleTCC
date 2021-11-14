/*
 * planta_completa.h
 *
 * Code generation for model "planta_completa".
 *
 * Model version              : 1.49
 * Simulink Coder version : 9.0 (R2018b) 24-May-2018
 * C source code generated on : Sun Nov  7 14:29:48 2021
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_planta_completa_h_
#define RTW_HEADER_planta_completa_h_
#include <stddef.h>
#include <float.h>
#include <string.h>
#ifndef planta_completa_COMMON_INCLUDES_
# define planta_completa_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#endif                                 /* planta_completa_COMMON_INCLUDES_ */

#include "planta_completa_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetContStateDisabled
# define rtmGetContStateDisabled(rtm)  ((rtm)->contStateDisabled)
#endif

#ifndef rtmSetContStateDisabled
# define rtmSetContStateDisabled(rtm, val) ((rtm)->contStateDisabled = (val))
#endif

#ifndef rtmGetContStates
# define rtmGetContStates(rtm)         ((rtm)->contStates)
#endif

#ifndef rtmSetContStates
# define rtmSetContStates(rtm, val)    ((rtm)->contStates = (val))
#endif

#ifndef rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag
# define rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm) ((rtm)->CTOutputIncnstWithState)
#endif

#ifndef rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag
# define rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm, val) ((rtm)->CTOutputIncnstWithState = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
# define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
# define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetIntgData
# define rtmGetIntgData(rtm)           ((rtm)->intgData)
#endif

#ifndef rtmSetIntgData
# define rtmSetIntgData(rtm, val)      ((rtm)->intgData = (val))
#endif

#ifndef rtmGetOdeF
# define rtmGetOdeF(rtm)               ((rtm)->odeF)
#endif

#ifndef rtmSetOdeF
# define rtmSetOdeF(rtm, val)          ((rtm)->odeF = (val))
#endif

#ifndef rtmGetOdeY
# define rtmGetOdeY(rtm)               ((rtm)->odeY)
#endif

#ifndef rtmSetOdeY
# define rtmSetOdeY(rtm, val)          ((rtm)->odeY = (val))
#endif

#ifndef rtmGetPeriodicContStateIndices
# define rtmGetPeriodicContStateIndices(rtm) ((rtm)->periodicContStateIndices)
#endif

#ifndef rtmSetPeriodicContStateIndices
# define rtmSetPeriodicContStateIndices(rtm, val) ((rtm)->periodicContStateIndices = (val))
#endif

#ifndef rtmGetPeriodicContStateRanges
# define rtmGetPeriodicContStateRanges(rtm) ((rtm)->periodicContStateRanges)
#endif

#ifndef rtmSetPeriodicContStateRanges
# define rtmSetPeriodicContStateRanges(rtm, val) ((rtm)->periodicContStateRanges = (val))
#endif

#ifndef rtmGetRTWLogInfo
# define rtmGetRTWLogInfo(rtm)         ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetZCCacheNeedsReset
# define rtmGetZCCacheNeedsReset(rtm)  ((rtm)->zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
# define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->zCCacheNeedsReset = (val))
#endif

#ifndef rtmGetdX
# define rtmGetdX(rtm)                 ((rtm)->derivs)
#endif

#ifndef rtmSetdX
# define rtmSetdX(rtm, val)            ((rtm)->derivs = (val))
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               ((rtm)->Timing.t)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T proporcional;                 /* '<S3>/proporcional' */
  real_T Saturation;                   /* '<S3>/Saturation' */
  real_T Sum1;                         /* '<S3>/Sum1' */
  real_T proporcional_b;               /* '<S2>/proporcional' */
  real_T Saturation_l;                 /* '<S2>/Saturation' */
  real_T Sum1_p;                       /* '<S2>/Sum1' */
  real_T integral;                     /* '<S2>/integral' */
  real_T integral_k;                   /* '<S3>/integral' */
} B_planta_completa_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T DiscreteTransferFcn2_states;  /* '<Root>/Discrete Transfer Fcn2' */
  real_T DiscreteTransferFcn3_states;  /* '<Root>/Discrete Transfer Fcn3' */
  real_T DiscreteTransferFcn_states;   /* '<S3>/Discrete Transfer Fcn' */
  real_T DiscreteTransferFcn_states_b; /* '<S2>/Discrete Transfer Fcn' */
  real_T DiscreteTimeIntegrator_DSTATE;/* '<Root>/Discrete-Time Integrator' */
  real_T Memory_PreviousInput;         /* '<Root>/Memory' */
  real_T DiscreteTransferFcn2_tmp;     /* '<Root>/Discrete Transfer Fcn2' */
  real_T DiscreteTransferFcn3_tmp;     /* '<Root>/Discrete Transfer Fcn3' */
  real_T Memory_PreviousInput_a;       /* '<S3>/Memory' */
  real_T DiscreteTransferFcn_tmp;      /* '<S3>/Discrete Transfer Fcn' */
  real_T Memory_PreviousInput_j;       /* '<S2>/Memory' */
  real_T DiscreteTransferFcn_tmp_d;    /* '<S2>/Discrete Transfer Fcn' */
  struct {
    void *LoggedData[2];
  } Scope_PWORK;                       /* '<Root>/Scope' */

  struct {
    void *LoggedData;
  } Scope1_PWORK;                      /* '<Root>/Scope1' */

  struct {
    void *LoggedData;
  } Scope2_PWORK;                      /* '<Root>/Scope2' */

  struct {
    void *LoggedData;
  } ToWorkspace1_PWORK;                /* '<Root>/To Workspace1' */

  struct {
    void *LoggedData;
  } Scope_PWORK_c;                     /* '<S2>/Scope' */

  struct {
    void *LoggedData;
  } Scope1_PWORK_j;                    /* '<S2>/Scope1' */

  struct {
    void *LoggedData;
  } Scope2_PWORK_k;                    /* '<S2>/Scope2' */

  struct {
    void *LoggedData;
  } Scope_PWORK_k;                     /* '<S3>/Scope' */

  struct {
    void *LoggedData;
  } Scope1_PWORK_k;                    /* '<S3>/Scope1' */

  struct {
    void *LoggedData;
  } Scope2_PWORK_h;                    /* '<S3>/Scope2' */
} DW_planta_completa_T;

/* Continuous states (default storage) */
typedef struct {
  real_T Integrator_CSTATE;            /* '<S3>/Integrator' */
  real_T Integrator_CSTATE_l;          /* '<S2>/Integrator' */
} X_planta_completa_T;

/* State derivatives (default storage) */
typedef struct {
  real_T Integrator_CSTATE;            /* '<S3>/Integrator' */
  real_T Integrator_CSTATE_l;          /* '<S2>/Integrator' */
} XDot_planta_completa_T;

/* State disabled  */
typedef struct {
  boolean_T Integrator_CSTATE;         /* '<S3>/Integrator' */
  boolean_T Integrator_CSTATE_l;       /* '<S2>/Integrator' */
} XDis_planta_completa_T;

#ifndef ODE3_INTG
#define ODE3_INTG

/* ODE3 Integration Data */
typedef struct {
  real_T *y;                           /* output */
  real_T *f[3];                        /* derivatives */
} ODE3_IntgData;

#endif

/* Parameters (default storage) */
struct P_planta_completa_T_ {
  real_T Step1_Time;                   /* Expression: 0
                                        * Referenced by: '<Root>/Step1'
                                        */
  real_T Step1_Y0;                     /* Expression: 0
                                        * Referenced by: '<Root>/Step1'
                                        */
  real_T Step1_YFinal;                 /* Expression: 0.3
                                        * Referenced by: '<Root>/Step1'
                                        */
  real_T Constant1_Value;              /* Expression: 0
                                        * Referenced by: '<Root>/Constant1'
                                        */
  real_T Memory_InitialCondition;      /* Expression: 0
                                        * Referenced by: '<Root>/Memory'
                                        */
  real_T integral_Gain;                /* Expression: 0.431649422606147
                                        * Referenced by: '<Root>/integral'
                                        */
  real_T DiscreteTransferFcn2_NumCoef[2];/* Expression: [0.0005, 0.0005]
                                          * Referenced by: '<Root>/Discrete Transfer Fcn2'
                                          */
  real_T DiscreteTransferFcn2_DenCoef[2];/* Expression: [1, -1]
                                          * Referenced by: '<Root>/Discrete Transfer Fcn2'
                                          */
  real_T DiscreteTransferFcn2_InitialSta;/* Expression: 0
                                          * Referenced by: '<Root>/Discrete Transfer Fcn2'
                                          */
  real_T proporcional_Gain;            /* Expression: 6.152724053393891
                                        * Referenced by: '<Root>/proporcional'
                                        */
  real_T derivativo_Gain;              /* Expression: 4.547238746968530
                                        * Referenced by: '<Root>/derivativo'
                                        */
  real_T DiscreteTransferFcn3_NumCoef[2];/* Expression: [0.001976, 0.001976]
                                          * Referenced by: '<Root>/Discrete Transfer Fcn3'
                                          */
  real_T DiscreteTransferFcn3_DenCoef[2];/* Expression: [1, -1.004]
                                          * Referenced by: '<Root>/Discrete Transfer Fcn3'
                                          */
  real_T DiscreteTransferFcn3_InitialSta;/* Expression: 0
                                          * Referenced by: '<Root>/Discrete Transfer Fcn3'
                                          */
  real_T Constant1_Value_k;            /* Expression: 0.1
                                        * Referenced by: '<S1>/Constant1'
                                        */
  real_T Constant_Value;               /* Expression: 0.5
                                        * Referenced by: '<S1>/Constant'
                                        */
  real_T Memory_InitialCondition_c;    /* Expression: 0
                                        * Referenced by: '<S3>/Memory'
                                        */
  real_T proporcional_Gain_f;          /* Expression: 372
                                        * Referenced by: '<S3>/proporcional'
                                        */
  real_T Integrator_IC;                /* Expression: 0
                                        * Referenced by: '<S3>/Integrator'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 1000
                                        * Referenced by: '<S3>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: 0
                                        * Referenced by: '<S3>/Saturation'
                                        */
  real_T DiscreteTransferFcn_NumCoef[2];/* Expression: [2.514e-05 2.514e-05]
                                         * Referenced by: '<S3>/Discrete Transfer Fcn'
                                         */
  real_T DiscreteTransferFcn_DenCoef[2];/* Expression: [1 -0.9975]
                                         * Referenced by: '<S3>/Discrete Transfer Fcn'
                                         */
  real_T DiscreteTransferFcn_InitialStat;/* Expression: 0
                                          * Referenced by: '<S3>/Discrete Transfer Fcn'
                                          */
  real_T Memory_InitialCondition_o;    /* Expression: 0
                                        * Referenced by: '<S2>/Memory'
                                        */
  real_T proporcional_Gain_g;          /* Expression: 308
                                        * Referenced by: '<S2>/proporcional'
                                        */
  real_T Integrator_IC_p;              /* Expression: 0
                                        * Referenced by: '<S2>/Integrator'
                                        */
  real_T Saturation_UpperSat_l;        /* Expression: 1232
                                        * Referenced by: '<S2>/Saturation'
                                        */
  real_T Saturation_LowerSat_a;        /* Expression: 0
                                        * Referenced by: '<S2>/Saturation'
                                        */
  real_T DiscreteTransferFcn_NumCoef_a[2];/* Expression: [2.868e-05 2.868e-05]
                                           * Referenced by: '<S2>/Discrete Transfer Fcn'
                                           */
  real_T DiscreteTransferFcn_DenCoef_j[2];/* Expression: [1 -0.995]
                                           * Referenced by: '<S2>/Discrete Transfer Fcn'
                                           */
  real_T DiscreteTransferFcn_InitialSt_n;/* Expression: 0
                                          * Referenced by: '<S2>/Discrete Transfer Fcn'
                                          */
  real_T Constant1_Value_f;            /* Expression: 0.1
                                        * Referenced by: '<S4>/Constant1'
                                        */
  real_T DiscreteTimeIntegrator_gainval;/* Computed Parameter: DiscreteTimeIntegrator_gainval
                                         * Referenced by: '<Root>/Discrete-Time Integrator'
                                         */
  real_T DiscreteTimeIntegrator_IC;    /* Expression: 0
                                        * Referenced by: '<Root>/Discrete-Time Integrator'
                                        */
  real_T integral_Gain_k;              /* Expression: 2795
                                        * Referenced by: '<S2>/integral'
                                        */
  real_T integral_Gain_d;              /* Expression: 1766
                                        * Referenced by: '<S3>/integral'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_planta_completa_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;
  RTWSolverInfo solverInfo;
  X_planta_completa_T *contStates;
  int_T *periodicContStateIndices;
  real_T *periodicContStateRanges;
  real_T *derivs;
  boolean_T *contStateDisabled;
  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;
  real_T odeY[2];
  real_T odeF[3][2];
  ODE3_IntgData intgData;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    int_T numContStates;
    int_T numPeriodicContStates;
    int_T numSampTimes;
  } Sizes;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    uint32_T clockTick1;
    uint32_T clockTickH1;
    time_T tFinal;
    SimTimeStep simTimeStep;
    boolean_T stopRequestedFlag;
    time_T *t;
    time_T tArray[2];
  } Timing;
};

/* Block parameters (default storage) */
extern P_planta_completa_T planta_completa_P;

/* Block signals (default storage) */
extern B_planta_completa_T planta_completa_B;

/* Continuous states (default storage) */
extern X_planta_completa_T planta_completa_X;

/* Block states (default storage) */
extern DW_planta_completa_T planta_completa_DW;

/* Model entry point functions */
extern void planta_completa_initialize(void);
extern void planta_completa_step(void);
extern void planta_completa_terminate(void);

/* Real-time Model object */
extern RT_MODEL_planta_completa_T *const planta_completa_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'planta_completa'
 * '<S1>'   : 'planta_completa/IDA'
 * '<S2>'   : 'planta_completa/Malha Interna L'
 * '<S3>'   : 'planta_completa/Malha Interna R'
 * '<S4>'   : 'planta_completa/VOLTA'
 */
#endif                                 /* RTW_HEADER_planta_completa_h_ */

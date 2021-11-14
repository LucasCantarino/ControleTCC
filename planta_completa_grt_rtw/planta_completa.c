/*
 * planta_completa.c
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

#include "planta_completa.h"
#include "planta_completa_private.h"

/* Block signals (default storage) */
B_planta_completa_T planta_completa_B;

/* Continuous states */
X_planta_completa_T planta_completa_X;

/* Block states (default storage) */
DW_planta_completa_T planta_completa_DW;

/* Real-time model */
RT_MODEL_planta_completa_T planta_completa_M_;
RT_MODEL_planta_completa_T *const planta_completa_M = &planta_completa_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  planta_completa_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  planta_completa_step();
  planta_completa_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  planta_completa_step();
  planta_completa_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model step function */
void planta_completa_step(void)
{
  /* local block i/o variables */
  real_T rtb_DiscreteTransferFcn;
  real_T rtb_DiscreteTransferFcn_k;
  real_T rtb_Divide;
  real_T rtb_DiscreteTimeIntegrator;
  real_T rtb_Step1;
  real_T rtb_Sum_g;
  real_T rtb_integral;
  real_T rtb_Sum_o;
  if (rtmIsMajorTimeStep(planta_completa_M)) {
    /* set solver stop time */
    if (!(planta_completa_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&planta_completa_M->solverInfo,
                            ((planta_completa_M->Timing.clockTickH0 + 1) *
        planta_completa_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&planta_completa_M->solverInfo,
                            ((planta_completa_M->Timing.clockTick0 + 1) *
        planta_completa_M->Timing.stepSize0 +
        planta_completa_M->Timing.clockTickH0 *
        planta_completa_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(planta_completa_M)) {
    planta_completa_M->Timing.t[0] = rtsiGetT(&planta_completa_M->solverInfo);
  }

  if (rtmIsMajorTimeStep(planta_completa_M)) {
    /* Step: '<Root>/Step1' */
    if ((((planta_completa_M->Timing.clockTick1+
           planta_completa_M->Timing.clockTickH1* 4294967296.0)) * 0.001) <
        planta_completa_P.Step1_Time) {
      rtb_Step1 = planta_completa_P.Step1_Y0;
    } else {
      rtb_Step1 = planta_completa_P.Step1_YFinal;
    }

    /* End of Step: '<Root>/Step1' */

    /* Sum: '<Root>/Sum' incorporates:
     *  Memory: '<Root>/Memory'
     */
    rtb_Sum_g = rtb_Step1 - planta_completa_DW.Memory_PreviousInput;

    /* DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn2' incorporates:
     *  Gain: '<Root>/integral'
     */
    planta_completa_DW.DiscreteTransferFcn2_tmp =
      (planta_completa_P.integral_Gain * rtb_Sum_g -
       planta_completa_P.DiscreteTransferFcn2_DenCoef[1] *
       planta_completa_DW.DiscreteTransferFcn2_states) /
      planta_completa_P.DiscreteTransferFcn2_DenCoef[0];

    /* DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn3' incorporates:
     *  Gain: '<Root>/derivativo'
     */
    planta_completa_DW.DiscreteTransferFcn3_tmp =
      (planta_completa_P.derivativo_Gain * rtb_Sum_g -
       planta_completa_P.DiscreteTransferFcn3_DenCoef[1] *
       planta_completa_DW.DiscreteTransferFcn3_states) /
      planta_completa_P.DiscreteTransferFcn3_DenCoef[0];

    /* Product: '<S1>/Multiply' incorporates:
     *  Constant: '<S1>/Constant'
     *  Constant: '<S1>/Constant1'
     *  DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn2'
     *  DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn3'
     *  Gain: '<Root>/proporcional'
     *  Sum: '<Root>/Sum1'
     */
    rtb_Sum_o = (((planta_completa_P.DiscreteTransferFcn2_NumCoef[0] *
                   planta_completa_DW.DiscreteTransferFcn2_tmp +
                   planta_completa_P.DiscreteTransferFcn2_NumCoef[1] *
                   planta_completa_DW.DiscreteTransferFcn2_states) +
                  planta_completa_P.proporcional_Gain * rtb_Sum_g) +
                 (planta_completa_P.DiscreteTransferFcn3_NumCoef[0] *
                  planta_completa_DW.DiscreteTransferFcn3_tmp +
                  planta_completa_P.DiscreteTransferFcn3_NumCoef[1] *
                  planta_completa_DW.DiscreteTransferFcn3_states)) *
      planta_completa_P.Constant1_Value_k * planta_completa_P.Constant_Value;

    /* Sum: '<S1>/Sum' incorporates:
     *  Constant: '<Root>/Constant1'
     */
    rtb_Sum_g = planta_completa_P.Constant1_Value + rtb_Sum_o;

    /* Sum: '<S3>/Sum' incorporates:
     *  Memory: '<S3>/Memory'
     */
    rtb_integral = rtb_Sum_g - planta_completa_DW.Memory_PreviousInput_a;

    /* Gain: '<S3>/proporcional' */
    planta_completa_B.proporcional = planta_completa_P.proporcional_Gain_f *
      rtb_integral;
  }

  /* Saturate: '<S3>/Saturation' incorporates:
   *  Integrator: '<S3>/Integrator'
   */
  if (planta_completa_X.Integrator_CSTATE >
      planta_completa_P.Saturation_UpperSat) {
    planta_completa_B.Saturation = planta_completa_P.Saturation_UpperSat;
  } else if (planta_completa_X.Integrator_CSTATE <
             planta_completa_P.Saturation_LowerSat) {
    planta_completa_B.Saturation = planta_completa_P.Saturation_LowerSat;
  } else {
    planta_completa_B.Saturation = planta_completa_X.Integrator_CSTATE;
  }

  /* End of Saturate: '<S3>/Saturation' */

  /* Sum: '<S3>/Sum1' */
  planta_completa_B.Sum1 = planta_completa_B.proporcional +
    planta_completa_B.Saturation;
  if (rtmIsMajorTimeStep(planta_completa_M)) {
    /* DiscreteTransferFcn: '<S3>/Discrete Transfer Fcn' */
    planta_completa_DW.DiscreteTransferFcn_tmp = (planta_completa_B.Sum1 -
      planta_completa_P.DiscreteTransferFcn_DenCoef[1] *
      planta_completa_DW.DiscreteTransferFcn_states) /
      planta_completa_P.DiscreteTransferFcn_DenCoef[0];
    rtb_DiscreteTransferFcn = planta_completa_P.DiscreteTransferFcn_NumCoef[0] *
      planta_completa_DW.DiscreteTransferFcn_tmp +
      planta_completa_P.DiscreteTransferFcn_NumCoef[1] *
      planta_completa_DW.DiscreteTransferFcn_states;

    /* Sum: '<S2>/Sum' incorporates:
     *  Memory: '<S2>/Memory'
     *  Sum: '<S1>/Sum1'
     */
    rtb_Sum_o = (rtb_Sum_g - rtb_Sum_o) -
      planta_completa_DW.Memory_PreviousInput_j;

    /* Gain: '<S2>/proporcional' */
    planta_completa_B.proporcional_b = planta_completa_P.proporcional_Gain_g *
      rtb_Sum_o;
  }

  /* Saturate: '<S2>/Saturation' incorporates:
   *  Integrator: '<S2>/Integrator'
   */
  if (planta_completa_X.Integrator_CSTATE_l >
      planta_completa_P.Saturation_UpperSat_l) {
    planta_completa_B.Saturation_l = planta_completa_P.Saturation_UpperSat_l;
  } else if (planta_completa_X.Integrator_CSTATE_l <
             planta_completa_P.Saturation_LowerSat_a) {
    planta_completa_B.Saturation_l = planta_completa_P.Saturation_LowerSat_a;
  } else {
    planta_completa_B.Saturation_l = planta_completa_X.Integrator_CSTATE_l;
  }

  /* End of Saturate: '<S2>/Saturation' */

  /* Sum: '<S2>/Sum1' */
  planta_completa_B.Sum1_p = planta_completa_B.proporcional_b +
    planta_completa_B.Saturation_l;
  if (rtmIsMajorTimeStep(planta_completa_M)) {
    /* DiscreteTransferFcn: '<S2>/Discrete Transfer Fcn' */
    planta_completa_DW.DiscreteTransferFcn_tmp_d = (planta_completa_B.Sum1_p -
      planta_completa_P.DiscreteTransferFcn_DenCoef_j[1] *
      planta_completa_DW.DiscreteTransferFcn_states_b) /
      planta_completa_P.DiscreteTransferFcn_DenCoef_j[0];
    rtb_DiscreteTransferFcn_k = planta_completa_P.DiscreteTransferFcn_NumCoef_a
      [0] * planta_completa_DW.DiscreteTransferFcn_tmp_d +
      planta_completa_P.DiscreteTransferFcn_NumCoef_a[1] *
      planta_completa_DW.DiscreteTransferFcn_states_b;

    /* Product: '<S4>/Divide' incorporates:
     *  Constant: '<S4>/Constant1'
     *  Sum: '<S4>/Sum1'
     */
    rtb_Divide = (rtb_DiscreteTransferFcn - rtb_DiscreteTransferFcn_k) /
      planta_completa_P.Constant1_Value_f;

    /* DiscreteIntegrator: '<Root>/Discrete-Time Integrator' */
    rtb_DiscreteTimeIntegrator =
      planta_completa_DW.DiscreteTimeIntegrator_DSTATE;

    /* ToWorkspace: '<Root>/To Workspace1' */
    if (rtmIsMajorTimeStep(planta_completa_M)) {
      rt_UpdateLogVar((LogVar *)(LogVar*)
                      (planta_completa_DW.ToWorkspace1_PWORK.LoggedData),
                      &rtb_Divide, 0);
    }

    /* Gain: '<S2>/integral' */
    planta_completa_B.integral = planta_completa_P.integral_Gain_k * rtb_Sum_o;

    /* Gain: '<S3>/integral' */
    planta_completa_B.integral_k = planta_completa_P.integral_Gain_d *
      rtb_integral;
  }

  if (rtmIsMajorTimeStep(planta_completa_M)) {
    /* Matfile logging */
    rt_UpdateTXYLogVars(planta_completa_M->rtwLogInfo,
                        (planta_completa_M->Timing.t));
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(planta_completa_M)) {
    if (rtmIsMajorTimeStep(planta_completa_M)) {
      /* Update for Memory: '<Root>/Memory' */
      planta_completa_DW.Memory_PreviousInput = rtb_DiscreteTimeIntegrator;

      /* Update for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn2' */
      planta_completa_DW.DiscreteTransferFcn2_states =
        planta_completa_DW.DiscreteTransferFcn2_tmp;

      /* Update for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn3' */
      planta_completa_DW.DiscreteTransferFcn3_states =
        planta_completa_DW.DiscreteTransferFcn3_tmp;

      /* Update for Memory: '<S3>/Memory' */
      planta_completa_DW.Memory_PreviousInput_a = rtb_DiscreteTransferFcn;

      /* Update for DiscreteTransferFcn: '<S3>/Discrete Transfer Fcn' */
      planta_completa_DW.DiscreteTransferFcn_states =
        planta_completa_DW.DiscreteTransferFcn_tmp;

      /* Update for Memory: '<S2>/Memory' */
      planta_completa_DW.Memory_PreviousInput_j = rtb_DiscreteTransferFcn_k;

      /* Update for DiscreteTransferFcn: '<S2>/Discrete Transfer Fcn' */
      planta_completa_DW.DiscreteTransferFcn_states_b =
        planta_completa_DW.DiscreteTransferFcn_tmp_d;

      /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' */
      planta_completa_DW.DiscreteTimeIntegrator_DSTATE +=
        planta_completa_P.DiscreteTimeIntegrator_gainval * rtb_Divide;
    }
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(planta_completa_M)) {
    /* signal main to stop simulation */
    {                                  /* Sample time: [0.0s, 0.0s] */
      if ((rtmGetTFinal(planta_completa_M)!=-1) &&
          !((rtmGetTFinal(planta_completa_M)-
             (((planta_completa_M->Timing.clockTick1+
                planta_completa_M->Timing.clockTickH1* 4294967296.0)) * 0.001)) >
            (((planta_completa_M->Timing.clockTick1+
               planta_completa_M->Timing.clockTickH1* 4294967296.0)) * 0.001) *
            (DBL_EPSILON))) {
        rtmSetErrorStatus(planta_completa_M, "Simulation finished");
      }
    }

    rt_ertODEUpdateContinuousStates(&planta_completa_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick0 and the high bits
     * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++planta_completa_M->Timing.clockTick0)) {
      ++planta_completa_M->Timing.clockTickH0;
    }

    planta_completa_M->Timing.t[0] = rtsiGetSolverStopTime
      (&planta_completa_M->solverInfo);

    {
      /* Update absolute timer for sample time: [0.001s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 0.001, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       * Timer of this task consists of two 32 bit unsigned integers.
       * The two integers represent the low bits Timing.clockTick1 and the high bits
       * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
       */
      planta_completa_M->Timing.clockTick1++;
      if (!planta_completa_M->Timing.clockTick1) {
        planta_completa_M->Timing.clockTickH1++;
      }
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void planta_completa_derivatives(void)
{
  XDot_planta_completa_T *_rtXdot;
  _rtXdot = ((XDot_planta_completa_T *) planta_completa_M->derivs);

  /* Derivatives for Integrator: '<S3>/Integrator' */
  _rtXdot->Integrator_CSTATE = planta_completa_B.integral_k;

  /* Derivatives for Integrator: '<S2>/Integrator' */
  _rtXdot->Integrator_CSTATE_l = planta_completa_B.integral;
}

/* Model initialize function */
void planta_completa_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)planta_completa_M, 0,
                sizeof(RT_MODEL_planta_completa_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&planta_completa_M->solverInfo,
                          &planta_completa_M->Timing.simTimeStep);
    rtsiSetTPtr(&planta_completa_M->solverInfo, &rtmGetTPtr(planta_completa_M));
    rtsiSetStepSizePtr(&planta_completa_M->solverInfo,
                       &planta_completa_M->Timing.stepSize0);
    rtsiSetdXPtr(&planta_completa_M->solverInfo, &planta_completa_M->derivs);
    rtsiSetContStatesPtr(&planta_completa_M->solverInfo, (real_T **)
                         &planta_completa_M->contStates);
    rtsiSetNumContStatesPtr(&planta_completa_M->solverInfo,
      &planta_completa_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&planta_completa_M->solverInfo,
      &planta_completa_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&planta_completa_M->solverInfo,
      &planta_completa_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&planta_completa_M->solverInfo,
      &planta_completa_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&planta_completa_M->solverInfo, (&rtmGetErrorStatus
      (planta_completa_M)));
    rtsiSetRTModelPtr(&planta_completa_M->solverInfo, planta_completa_M);
  }

  rtsiSetSimTimeStep(&planta_completa_M->solverInfo, MAJOR_TIME_STEP);
  planta_completa_M->intgData.y = planta_completa_M->odeY;
  planta_completa_M->intgData.f[0] = planta_completa_M->odeF[0];
  planta_completa_M->intgData.f[1] = planta_completa_M->odeF[1];
  planta_completa_M->intgData.f[2] = planta_completa_M->odeF[2];
  planta_completa_M->contStates = ((X_planta_completa_T *) &planta_completa_X);
  rtsiSetSolverData(&planta_completa_M->solverInfo, (void *)
                    &planta_completa_M->intgData);
  rtsiSetSolverName(&planta_completa_M->solverInfo,"ode3");
  rtmSetTPtr(planta_completa_M, &planta_completa_M->Timing.tArray[0]);
  rtmSetTFinal(planta_completa_M, 10.0);
  planta_completa_M->Timing.stepSize0 = 0.001;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    planta_completa_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(planta_completa_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(planta_completa_M->rtwLogInfo, (NULL));
    rtliSetLogT(planta_completa_M->rtwLogInfo, "tout");
    rtliSetLogX(planta_completa_M->rtwLogInfo, "");
    rtliSetLogXFinal(planta_completa_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(planta_completa_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(planta_completa_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(planta_completa_M->rtwLogInfo, 0);
    rtliSetLogDecimation(planta_completa_M->rtwLogInfo, 1);
    rtliSetLogY(planta_completa_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(planta_completa_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(planta_completa_M->rtwLogInfo, (NULL));
  }

  /* block I/O */
  (void) memset(((void *) &planta_completa_B), 0,
                sizeof(B_planta_completa_T));

  /* states (continuous) */
  {
    (void) memset((void *)&planta_completa_X, 0,
                  sizeof(X_planta_completa_T));
  }

  /* states (dwork) */
  (void) memset((void *)&planta_completa_DW, 0,
                sizeof(DW_planta_completa_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(planta_completa_M->rtwLogInfo, 0.0,
    rtmGetTFinal(planta_completa_M), planta_completa_M->Timing.stepSize0,
    (&rtmGetErrorStatus(planta_completa_M)));

  /* Start for ToWorkspace: '<Root>/To Workspace1' */
  {
    int_T dimensions[1] = { 1 };

    planta_completa_DW.ToWorkspace1_PWORK.LoggedData = rt_CreateLogVar(
      planta_completa_M->rtwLogInfo,
      0.0,
      rtmGetTFinal(planta_completa_M),
      planta_completa_M->Timing.stepSize0,
      (&rtmGetErrorStatus(planta_completa_M)),
      "omega",
      SS_DOUBLE,
      0,
      0,
      0,
      1,
      1,
      dimensions,
      NO_LOGVALDIMS,
      (NULL),
      (NULL),
      0,
      1,
      0.001,
      1);
    if (planta_completa_DW.ToWorkspace1_PWORK.LoggedData == (NULL))
      return;
  }

  /* InitializeConditions for Memory: '<Root>/Memory' */
  planta_completa_DW.Memory_PreviousInput =
    planta_completa_P.Memory_InitialCondition;

  /* InitializeConditions for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn2' */
  planta_completa_DW.DiscreteTransferFcn2_states =
    planta_completa_P.DiscreteTransferFcn2_InitialSta;

  /* InitializeConditions for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn3' */
  planta_completa_DW.DiscreteTransferFcn3_states =
    planta_completa_P.DiscreteTransferFcn3_InitialSta;

  /* InitializeConditions for Memory: '<S3>/Memory' */
  planta_completa_DW.Memory_PreviousInput_a =
    planta_completa_P.Memory_InitialCondition_c;

  /* InitializeConditions for Integrator: '<S3>/Integrator' */
  planta_completa_X.Integrator_CSTATE = planta_completa_P.Integrator_IC;

  /* InitializeConditions for DiscreteTransferFcn: '<S3>/Discrete Transfer Fcn' */
  planta_completa_DW.DiscreteTransferFcn_states =
    planta_completa_P.DiscreteTransferFcn_InitialStat;

  /* InitializeConditions for Memory: '<S2>/Memory' */
  planta_completa_DW.Memory_PreviousInput_j =
    planta_completa_P.Memory_InitialCondition_o;

  /* InitializeConditions for Integrator: '<S2>/Integrator' */
  planta_completa_X.Integrator_CSTATE_l = planta_completa_P.Integrator_IC_p;

  /* InitializeConditions for DiscreteTransferFcn: '<S2>/Discrete Transfer Fcn' */
  planta_completa_DW.DiscreteTransferFcn_states_b =
    planta_completa_P.DiscreteTransferFcn_InitialSt_n;

  /* InitializeConditions for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' */
  planta_completa_DW.DiscreteTimeIntegrator_DSTATE =
    planta_completa_P.DiscreteTimeIntegrator_IC;
}

/* Model terminate function */
void planta_completa_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * planta_completa_data.c
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

/* Block parameters (default storage) */
P_planta_completa_T planta_completa_P = {
  /* Expression: 0
   * Referenced by: '<Root>/Step1'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Step1'
   */
  0.0,

  /* Expression: 0.3
   * Referenced by: '<Root>/Step1'
   */
  0.3,

  /* Expression: 0
   * Referenced by: '<Root>/Constant1'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Memory'
   */
  0.0,

  /* Expression: 0.431649422606147
   * Referenced by: '<Root>/integral'
   */
  0.431649422606147,

  /* Expression: [0.0005, 0.0005]
   * Referenced by: '<Root>/Discrete Transfer Fcn2'
   */
  { 0.0005, 0.0005 },

  /* Expression: [1, -1]
   * Referenced by: '<Root>/Discrete Transfer Fcn2'
   */
  { 1.0, -1.0 },

  /* Expression: 0
   * Referenced by: '<Root>/Discrete Transfer Fcn2'
   */
  0.0,

  /* Expression: 6.152724053393891
   * Referenced by: '<Root>/proporcional'
   */
  6.1527240533938912,

  /* Expression: 4.547238746968530
   * Referenced by: '<Root>/derivativo'
   */
  4.54723874696853,

  /* Expression: [0.001976, 0.001976]
   * Referenced by: '<Root>/Discrete Transfer Fcn3'
   */
  { 0.001976, 0.001976 },

  /* Expression: [1, -1.004]
   * Referenced by: '<Root>/Discrete Transfer Fcn3'
   */
  { 1.0, -1.004 },

  /* Expression: 0
   * Referenced by: '<Root>/Discrete Transfer Fcn3'
   */
  0.0,

  /* Expression: 0.1
   * Referenced by: '<S1>/Constant1'
   */
  0.1,

  /* Expression: 0.5
   * Referenced by: '<S1>/Constant'
   */
  0.5,

  /* Expression: 0
   * Referenced by: '<S3>/Memory'
   */
  0.0,

  /* Expression: 372
   * Referenced by: '<S3>/proporcional'
   */
  372.0,

  /* Expression: 0
   * Referenced by: '<S3>/Integrator'
   */
  0.0,

  /* Expression: 1000
   * Referenced by: '<S3>/Saturation'
   */
  1000.0,

  /* Expression: 0
   * Referenced by: '<S3>/Saturation'
   */
  0.0,

  /* Expression: [2.514e-05 2.514e-05]
   * Referenced by: '<S3>/Discrete Transfer Fcn'
   */
  { 2.514E-5, 2.514E-5 },

  /* Expression: [1 -0.9975]
   * Referenced by: '<S3>/Discrete Transfer Fcn'
   */
  { 1.0, -0.9975 },

  /* Expression: 0
   * Referenced by: '<S3>/Discrete Transfer Fcn'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S2>/Memory'
   */
  0.0,

  /* Expression: 308
   * Referenced by: '<S2>/proporcional'
   */
  308.0,

  /* Expression: 0
   * Referenced by: '<S2>/Integrator'
   */
  0.0,

  /* Expression: 1232
   * Referenced by: '<S2>/Saturation'
   */
  1232.0,

  /* Expression: 0
   * Referenced by: '<S2>/Saturation'
   */
  0.0,

  /* Expression: [2.868e-05 2.868e-05]
   * Referenced by: '<S2>/Discrete Transfer Fcn'
   */
  { 2.868E-5, 2.868E-5 },

  /* Expression: [1 -0.995]
   * Referenced by: '<S2>/Discrete Transfer Fcn'
   */
  { 1.0, -0.995 },

  /* Expression: 0
   * Referenced by: '<S2>/Discrete Transfer Fcn'
   */
  0.0,

  /* Expression: 0.1
   * Referenced by: '<S4>/Constant1'
   */
  0.1,

  /* Computed Parameter: DiscreteTimeIntegrator_gainval
   * Referenced by: '<Root>/Discrete-Time Integrator'
   */
  0.001,

  /* Expression: 0
   * Referenced by: '<Root>/Discrete-Time Integrator'
   */
  0.0,

  /* Expression: 2795
   * Referenced by: '<S2>/integral'
   */
  2795.0,

  /* Expression: 1766
   * Referenced by: '<S3>/integral'
   */
  1766.0
};

.module / RAM / ABS = 0 FIR_PROGRAM;
/******** Initialize Constants and Variables *****************/
.const taps = 127;
.var / dm / circ data[taps];
.var / pm / circ fir_coefs[taps];
.init fir_coefs : ;
.var / dm / circ output_data[taps];
/******** Interrupt vector table *****************************/
reset_svc: jump start; rti; rti; rti;
/*00: reset */
irq2_svc: /*04: IRQ2 */
si = io(0); /* get next sample */
dm(i0, m0) = si; /* store in tap delay line */
jump fir; /* jump to fir filter */
nop; /* nop is placeholder */
irql1_svc: rti; rti; rti; rti; /*08: IRQL1 */
irql0_svc: rti; rti; rti; rti; /*0c: IRQL0 */
sp0tx_svc: rti; rti; rti; rti; /*10: SPORT0 tx */
sp0rx_svc: rti; rti; rti; rti; /*14: SPORT1 rx */
irqe_svc: rti; rti; rti; rti; /*18: IRQE */
bdma_svc: rti; rti; rti; rti; /*1c: BDMA */
sp1tx_svc: rti; rti; rti; rti; /*20: SPORT1 tx or IRQ1 */
sp1rx_svc: rti; rti; rti; rti; /*24: SPORT1 rx or IRQ0 */
timer_svc: rti; rti; rti; rti; /*28: timer */
pwdn_svc: rti; rti; rti; rti; /*2c: power down */
/******* START OF PROGRAM - initialize mask, pointers **********/
start:
/* set up various control registers */
ICNTL = 0x07; /* set IRQ2, IRQ1, IRQ0 edge sensitive */
IFC = 0xFF; /* clear all pending interrupts */
NOP; /* add nop because of one cycle */
/* synchronization delay of IFC */
SI = 0x0000;
DM(0x3FFF) = SI; /* sports not enabled */
/* sport1 set for IRQ1, IRQ0, FI, FO */
IMASK = 0x200; /* enable IRQ2 interrupt */
i0 = ^data; /* index to data buffer */
l0 = taps; /* length of data buffer */
m0 = 1; /* post modify value */
i4 = ^fir_coefs; /* index to fir_coefs buffer */
l4 = taps; /* length of fir_coefs buffer */
m4 = 1; /* post modify value */
i2 = ^output_data; /* index to data buffer */
l2 = taps; /* length of data buffer */
cntr = taps;
do zero until ce;
dm(i0, m0) = 0; /* clear out the tap delay data buffer */
zero: dm(i2, m0) = 0; /* clear out the output_data buffer */
/**** WAIT for IRQ2 Interrupt - then JUMP to INTERRUPT VECTOR **/
wait: idle; /* wait for IRQ2 interrupt */
jump wait;
/******* FIR FILTER interrupt subroutine ***********************/
fir cntr = taps - 1; /* set up loop counter */
mr = 0, mx0 = dm(i0, m0), my0 = pm(i4, m4);
/* fetch data and coefficient */
do fir1loop until ce; /* set up loop */
fir1loop: mr = mr + mx0*my0(ss), mx0 = dm(i0, m0), my0 = pm(i4, m4);
/* calculations */
/* if not ce jump fir1loop;*/
mr = mr + mx0*my0(rnd); /* round final result to 16-bits */
if mv sat mr; /* if overflow, saturate */
io(1) = mr1; /* send result to DAC */
dm(i2, m0) = mr1;
rti;

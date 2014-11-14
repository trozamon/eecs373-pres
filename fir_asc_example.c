

.module/RAM/ABS=0 EzHello;

#include 

#define taps 255 /* filter tap length */

.var/dm/circ filt_data[taps]; /* input data buffer */

.var/pm/circ filt_coeffs[taps]; /* coefficient buffer */

.init filt_coeffs:; /* initialize coefficients */

.external rx_buf, tx_buf;

.external init_cmds, stat_flag;

.external next_cmd, init_1847, init_system_regs, init_sport0;

...
...

/**************************************************************

* Interrupt service routines

**************************************************************/

/*----------------------------------------------------------------------

- FIR Filter

----------------------------------------------------------------------*/

input_samples:
ena sec_reg; /* use shadow register bank */
ax0 = dm (rx_buf + 1); /* read data from converter */
dm(i2,m1) = ax0; /* write new data into delay line, pointe
now pointing to oldest data */
cntr = taps - 1;
mr = 0, mx0 = dm(i2,m1), my0 = pm(i5,m5); /* clear accumulator, get first
data and coefficient value */
do filt_loop until ce; /* set-up zero-overhead loop */
filt_loop: mr = mr + mx0 * my0(ss), mx0 = dm(i2,m1), my0 = pm(i5,m5);
/* MAC and two data fetches */
mr = mr + mx0 * my0 (rnd); /* final multiply, round to 16-bit result */
if mv saat mr; /* check for overflow */
dm(tx_buf+1) = mr1;
dm(tx_buf+2) = mr1; /* output data to both channels */
rti;

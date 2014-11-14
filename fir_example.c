float fir_filter(float input, float *coef, int n, float *history)
{
	int i;
	float *hist_ptr, *hist1_ptr, *coef_ptr;
	float output;
	hist_ptr = history;
	hist1_ptr = hist_ptr; /* use for history update */
	coef_ptr = coef + n - 1; /* point to last coef */
	/*form output accumulation */
	output = *hist_ptr++ * (*coef_ptr - );
	for (i = 2; i < n; i++)
	{
		*hist1_ptr++ = *hist_ptr; /* update history array */
		output += (*hist_ptr++) * (*coef_ptr - );
	}
	output += input * (*coef_ptr); /* input tap */
	*hist1_ptr = input; /* last history */
	return(output);
}

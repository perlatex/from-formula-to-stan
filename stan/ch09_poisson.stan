// Chapter 9: Poisson regression
//
//   y_i      ~ Poisson(lambda_i)
//   log lambda_i = alpha + beta * x_i
//   alpha    ~ Normal(2, 0.5)
//   beta     ~ Normal(0, 0.3)

data {
  int<lower=0> N;               // number of survey sites
  vector[N] x;                  // habitat cover, standardized
  array[N] int<lower=0> y;      // number of bird species observed
}

parameters {
  real alpha;                   // log expected count at average cover
  real beta;                    // change in log expected count per SD of cover
}

model {
  // Priors
  target += normal_lpdf(alpha | 2, 0.5);
  target += normal_lpdf(beta | 0, 0.3);

  // Likelihood (log link built into poisson_log)
  target += poisson_log_lpmf(y | alpha + beta * x);
}

generated quantities {
  array[N] int y_rep = poisson_log_rng(alpha + beta * x);
}

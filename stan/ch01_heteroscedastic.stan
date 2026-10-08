// Chapter 1: Linear regression whose residual SD changes with x
//
//   y_i         ~ Normal(mu_i, sigma_i)
//   mu_i        = alpha + beta * x_i
//   log sigma_i = gamma0 + gamma1 * x_i

data {
  int<lower=0> N;               // number of observations
  vector[N] x;                  // predictor (task difficulty)
  vector[N] y;                  // outcome (reaction time, ms)
}

parameters {
  real alpha;                   // intercept of the mean
  real beta;                    // slope of the mean
  real gamma0;                  // intercept of log SD
  real gamma1;                  // slope of log SD
}

model {
  vector[N] mu = alpha + beta * x;
  vector[N] sigma = exp(gamma0 + gamma1 * x);   // one SD per observation

  // Priors
  target += normal_lpdf(alpha | 400, 100);
  target += normal_lpdf(beta | 0, 50);
  target += normal_lpdf(gamma0 | 3, 2);
  target += normal_lpdf(gamma1 | 0, 1);

  // Likelihood
  target += normal_lpdf(y | mu, sigma);
}

generated quantities {
  array[N] real y_rep = normal_rng(alpha + beta * x, exp(gamma0 + gamma1 * x));
}

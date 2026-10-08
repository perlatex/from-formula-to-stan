// Chapter 8: Logistic regression with adjustable priors and a prior-only switch
//
//   y_i        ~ Bernoulli(inv_logit(alpha + beta * x_i))   (skipped if prior_only = 1)
//   alpha      ~ Normal(0, alpha_sd)
//   beta       ~ Normal(0, beta_sd)

data {
  int<lower=0> N;                       // number of patients
  vector[N] x;                          // dose, centered
  array[N] int<lower=0, upper=1> y;     // 1 = responded, 0 = did not respond
  real<lower=0> alpha_sd;               // prior SD of the intercept
  real<lower=0> beta_sd;                // prior SD of the slope
  int<lower=0, upper=1> prior_only;     // 1 = ignore the data (prior predictive check)
}

parameters {
  real alpha;                           // log-odds of response at the average dose
  real beta;                            // change in log-odds per dose unit
}

model {
  // Priors
  target += normal_lpdf(alpha | 0, alpha_sd);
  target += normal_lpdf(beta | 0, beta_sd);

  // Likelihood, switched off for the prior predictive check
  if (!prior_only) {
    target += bernoulli_logit_lpmf(y | alpha + beta * x);
  }
}

generated quantities {
  real p_avg = inv_logit(alpha);                       // response probability at the average dose
  array[N] int y_rep = bernoulli_logit_rng(alpha + beta * x);
}

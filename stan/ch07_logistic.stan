// Chapter 7: Logistic regression
//
//   y_i       ~ Bernoulli(p_i)
//   logit(p_i) = alpha + beta * x_i
//   alpha     ~ Normal(0, 1.5)
//   beta      ~ Normal(0, 1)

data {
  int<lower=0> N;                       // number of trials
  vector[N] x;                          // stimulus intensity, centered at 5
  array[N] int<lower=0, upper=1> y;     // 1 = detected, 0 = missed
}

parameters {
  real alpha;                           // log-odds of detection at x = 0
  real beta;                            // change in log-odds per unit of intensity
}

model {
  // Priors
  target += normal_lpdf(alpha | 0, 1.5);
  target += normal_lpdf(beta | 0, 1);

  // Likelihood: the only line that differs in kind from Chapter 5
  target += bernoulli_logit_lpmf(y | alpha + beta * x);
}

generated quantities {
  vector[N] p = inv_logit(alpha + beta * x);           // detection probability
  array[N] int y_rep = bernoulli_logit_rng(alpha + beta * x);
  vector[N] log_lik;
  for (i in 1:N) {
    log_lik[i] = bernoulli_logit_lpmf(y[i] | alpha + beta * x[i]);
  }
}

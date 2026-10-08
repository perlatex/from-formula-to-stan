// Chapter 1: Linear regression with constant residual SD
//
//   y_i   ~ Normal(alpha + beta * x_i, sigma)

data {
  int<lower=0> N;               // number of observations
  vector[N] x;                  // predictor (task difficulty)
  vector[N] y;                  // outcome (reaction time, ms)
}

parameters {
  real alpha;                   // intercept
  real beta;                    // slope
  real<lower=0> sigma;          // residual SD, the same for every observation
}

model {
  // Priors
  target += normal_lpdf(alpha | 400, 100);
  target += normal_lpdf(beta | 0, 50);
  target += exponential_lpdf(sigma | 0.02);

  // Likelihood
  target += normal_lpdf(y | alpha + beta * x, sigma);
}

generated quantities {
  array[N] real y_rep = normal_rng(alpha + beta * x, sigma);
}

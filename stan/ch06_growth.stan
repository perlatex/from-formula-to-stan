// Chapter 6: Linear regression used to practise running and diagnosing
//
//   y_i   ~ Normal(alpha + beta * x_i, sigma)

data {
  int<lower=0> N;               // number of plants
  vector[N] x;                  // fertilizer dose (g), centered
  vector[N] y;                  // plant height (cm)
}

parameters {
  real alpha;                   // height at the average dose
  real beta;                    // height gain per gram of fertilizer
  real<lower=0> sigma;          // residual SD
}

model {
  // Priors
  target += normal_lpdf(alpha | 30, 10);
  target += normal_lpdf(beta | 0, 5);
  target += exponential_lpdf(sigma | 0.2);

  // Likelihood
  target += normal_lpdf(y | alpha + beta * x, sigma);
}

generated quantities {
  array[N] real y_rep = normal_rng(alpha + beta * x, sigma);
}

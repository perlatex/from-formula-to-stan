// Chapter 3: Data types and constraints
//
//   correct_i ~ Bernoulli(theta)            theta in (0, 1)
//   rt_i      ~ LogNormal(mu, sigma)        sigma > 0

data {
  int<lower=0> N;                           // number of trials
  array[N] int<lower=0, upper=1> correct;   // 1 = correct response, 0 = error
  vector<lower=0>[N] rt;                    // reaction time (ms), must be positive
}

parameters {
  real<lower=0, upper=1> theta;             // probability of a correct response
  real mu;                                  // mean of log reaction time
  real<lower=0> sigma;                      // SD of log reaction time
}

model {
  // Priors
  target += beta_lpdf(theta | 2, 2);
  target += normal_lpdf(mu | 6, 1);
  target += exponential_lpdf(sigma | 1);

  // Likelihood
  target += bernoulli_lpmf(correct | theta);
  target += lognormal_lpdf(rt | mu, sigma);
}

generated quantities {
  real median_rt = exp(mu);                 // median reaction time (ms)
}

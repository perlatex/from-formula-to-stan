// Chapter 3, Exercise 4: shifted lognormal with a data-dependent bound
//
//   rt_i - ndt ~ LogNormal(mu, sigma),   0 < ndt < min(rt)

data {
  int<lower=0> N;                       // number of trials
  vector<lower=0>[N] rt;                // reaction time (ms)
}

transformed data {
  real rt_min = min(rt);                // the shift cannot exceed the fastest response
}

parameters {
  real<lower=0, upper=rt_min> ndt;      // non-decision time (ms)
  real mu;                              // mean of log(rt - ndt)
  real<lower=0> sigma;                  // SD of log(rt - ndt)
}

model {
  // Priors
  target += normal_lpdf(ndt | 200, 100);
  target += normal_lpdf(mu | 6, 1);
  target += exponential_lpdf(sigma | 1);

  // Likelihood
  target += lognormal_lpdf(rt - ndt | mu, sigma);
}

// Chapter 6: A deliberately non-identified model
//
//   y_i ~ Normal(a1 + a2, sigma)
//   Only the sum a1 + a2 is informed by the data.

data {
  int<lower=0> N;               // number of plants
  vector[N] y;                  // plant height (cm)
}

parameters {
  real a1;
  real a2;
  real<lower=0> sigma;
}

model {
  // Very wide priors: only they keep a1 and a2 from drifting apart
  target += normal_lpdf(a1 | 0, 1000);
  target += normal_lpdf(a2 | 0, 1000);
  target += exponential_lpdf(sigma | 0.2);

  target += normal_lpdf(y | a1 + a2, sigma);
}

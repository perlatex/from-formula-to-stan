// Chapter 10: Complete pooling (all schools share one mean)
//
//   y_i ~ Normal(mu, sigma)

data {
  int<lower=0> N;                           // number of students
  vector[N] y;                              // math score
}

parameters {
  real mu;                                  // common mean
  real<lower=0> sigma;                      // within-school SD
}

model {
  target += normal_lpdf(mu | 70, 20);
  target += exponential_lpdf(sigma | 0.1);

  target += normal_lpdf(y | mu, sigma);
}

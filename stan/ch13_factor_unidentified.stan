// Chapter 13: The same factor model WITHOUT the sign constraint on lambda
//
//   (lambda, eta) and (-lambda, -eta) fit the data equally well.

data {
  int<lower=1> J;
  int<lower=1> K;
  matrix[J, K] y;
}

parameters {
  vector[K] nu;
  vector[K] lambda;                     // no <lower=0>: the sign is not identified
  vector<lower=0>[K] sigma;
  vector[J] eta;
}

model {
  target += normal_lpdf(nu | 50, 20);
  target += normal_lpdf(lambda | 0, 10);
  target += exponential_lpdf(sigma | 0.1);
  target += std_normal_lpdf(eta);

  for (k in 1:K) {
    target += normal_lpdf(y[, k] | nu[k] + lambda[k] * eta, sigma[k]);
  }
}

// Chapter 13: One-factor model with a continuous latent variable
//
//   y_jk  ~ Normal(nu_k + lambda_k * eta_j, sigma_k)
//   eta_j ~ Normal(0, 1)              fixes the location and scale of eta
//   lambda_k > 0                       fixes the sign of eta

data {
  int<lower=1> J;                       // number of students
  int<lower=1> K;                       // number of subtests
  matrix[J, K] y;                       // subtest scores
}

parameters {
  vector[K] nu;                         // intercept of each subtest
  vector<lower=0>[K] lambda;            // loading of each subtest on eta
  vector<lower=0>[K] sigma;             // residual SD of each subtest
  vector[J] eta;                        // latent ability of each student
}

model {
  // Priors
  target += normal_lpdf(nu | 50, 20);
  target += normal_lpdf(lambda | 0, 10);
  target += exponential_lpdf(sigma | 0.1);

  // Latent variable: declared like a parameter, given a standard normal prior
  target += std_normal_lpdf(eta);

  // Likelihood: one column per subtest
  for (k in 1:K) {
    target += normal_lpdf(y[, k] | nu[k] + lambda[k] * eta, sigma[k]);
  }
}

generated quantities {
  // McDonald's omega: share of total-score variance due to eta
  real omega = square(sum(lambda)) / (square(sum(lambda)) + sum(square(sigma)));
}

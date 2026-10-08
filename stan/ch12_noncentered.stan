// Chapter 12: Hierarchical model for group estimates (non-centered parameterization)
//
//   y_j       ~ Normal(theta_j, se_j)      se_j known
//   theta_j   = mu + tau * theta_raw_j
//   theta_raw ~ Normal(0, 1)
//   mu        ~ Normal(0, 5)
//   tau       ~ Normal+(0, 5)

data {
  int<lower=1> J;               // number of studies
  vector[J] y;                  // estimated effect in each study
  vector<lower=0>[J] se;        // standard error of each estimate
}

parameters {
  real mu;                      // average effect
  real<lower=0> tau;            // between-study SD
  vector[J] theta_raw;          // standardized study effects
}

transformed parameters {
  vector[J] theta = mu + tau * theta_raw;    // true effect in each study
}

model {
  target += normal_lpdf(mu | 0, 5);
  target += normal_lpdf(tau | 0, 5);

  target += std_normal_lpdf(theta_raw);      // non-centered: theta_raw does not depend on tau
  target += normal_lpdf(y | theta, se);
}

// Chapter 11: Hierarchical model for group estimates (centered parameterization)
//
//   y_j     ~ Normal(theta_j, se_j)      se_j known
//   theta_j ~ Normal(mu, tau)
//   mu      ~ Normal(0, 5)
//   tau     ~ Normal+(0, 5)

data {
  int<lower=1> J;               // number of studies
  vector[J] y;                  // estimated effect in each study
  vector<lower=0>[J] se;        // standard error of each estimate
}

parameters {
  real mu;                      // average effect
  real<lower=0> tau;            // between-study SD
  vector[J] theta;              // true effect in each study
}

model {
  target += normal_lpdf(mu | 0, 5);
  target += normal_lpdf(tau | 0, 5);

  target += normal_lpdf(theta | mu, tau);     // centered: theta is drawn around mu
  target += normal_lpdf(y | theta, se);
}

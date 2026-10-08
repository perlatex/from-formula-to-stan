// Chapter 12, Exercise 4: non-centering with offset and multiplier
//
//   theta_j ~ Normal(mu, tau), but Stan samples (theta_j - mu) / tau internally

data {
  int<lower=1> J;
  vector[J] y;
  vector<lower=0>[J] se;
}

parameters {
  real mu;
  real<lower=0> tau;
  vector<offset=mu, multiplier=tau>[J] theta;   // affine transform declared here
}

model {
  target += normal_lpdf(mu | 0, 5);
  target += normal_lpdf(tau | 0, 5);

  target += normal_lpdf(theta | mu, tau);       // written exactly like the centered model
  target += normal_lpdf(y | theta, se);
}

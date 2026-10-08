// Chapter 2: The same program with print() in each block,
// used only to count how often each block is executed.

data {
  int<lower=0> N;
  vector<lower=0>[N] y;
}

transformed data {
  real y_mean = mean(y);
  real y_sd = sd(y);
  vector[N] y_std = (y - y_mean) / y_sd;
  print("[transformed data]");
}

parameters {
  real mu_std;
  real<lower=0> sigma_std;
}

transformed parameters {
  real mu = y_mean + y_sd * mu_std;
  real<lower=0> sigma = y_sd * sigma_std;
  print("[transformed parameters]");
}

model {
  target += normal_lpdf(mu_std | 0, 1);
  target += exponential_lpdf(sigma_std | 1);
  target += normal_lpdf(y_std | mu_std, sigma_std);
  print("[model]");
}

generated quantities {
  real cv = sigma / mu;
  print("[generated quantities]");
}

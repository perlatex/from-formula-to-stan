// Chapter 12, Exercise 2: the Chapter 10 school model, non-centered
//
//   y_i       ~ Normal(alpha[school_i], sigma)
//   alpha     = mu + tau * alpha_raw
//   alpha_raw ~ Normal(0, 1)

data {
  int<lower=0> N;                           // number of students
  int<lower=1> J;                           // number of schools
  array[N] int<lower=1, upper=J> school;    // school of each student
  vector[N] y;                              // math score
}

parameters {
  real mu;
  real<lower=0> tau;
  vector[J] alpha_raw;                      // standardized school effects
  real<lower=0> sigma;
}

transformed parameters {
  vector[J] alpha = mu + tau * alpha_raw;   // school means
}

model {
  target += normal_lpdf(mu | 70, 20);
  target += exponential_lpdf(tau | 0.1);
  target += exponential_lpdf(sigma | 0.1);

  target += std_normal_lpdf(alpha_raw);
  target += normal_lpdf(y | alpha[school], sigma);
}

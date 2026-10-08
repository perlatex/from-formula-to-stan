// Chapter 10: Partial pooling (hierarchical model, centered parameterization)
//
//   y_i      ~ Normal(alpha[school_i], sigma)
//   alpha[j] ~ Normal(mu, tau)          the prior itself is learned
//   mu       ~ Normal(70, 20)
//   tau      ~ Exponential(0.1)
//   sigma    ~ Exponential(0.1)

data {
  int<lower=0> N;                           // number of students
  int<lower=1> J;                           // number of schools
  array[N] int<lower=1, upper=J> school;    // school of each student
  vector[N] y;                              // math score
}

parameters {
  real mu;                                  // population mean of school means
  real<lower=0> tau;                        // SD of school means
  vector[J] alpha;                          // school means
  real<lower=0> sigma;                      // within-school SD
}

model {
  // Hyperpriors
  target += normal_lpdf(mu | 70, 20);
  target += exponential_lpdf(tau | 0.1);
  target += exponential_lpdf(sigma | 0.1);

  // Population distribution of school means
  target += normal_lpdf(alpha | mu, tau);

  // Likelihood: student i belongs to school school[i]
  target += normal_lpdf(y | alpha[school], sigma);
}

generated quantities {
  real alpha_new = normal_rng(mu, tau);     // mean of a new, unobserved school
}

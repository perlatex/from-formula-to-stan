// Chapter 10: No pooling (each school estimated separately)
//
//   y_i      ~ Normal(alpha[school_i], sigma)
//   alpha[j] ~ Normal(70, 50)           independent, fixed and wide prior

data {
  int<lower=0> N;                           // number of students
  int<lower=1> J;                           // number of schools
  array[N] int<lower=1, upper=J> school;    // school of each student
  vector[N] y;                              // math score
}

parameters {
  vector[J] alpha;                          // school means
  real<lower=0> sigma;                      // within-school SD
}

model {
  target += normal_lpdf(alpha | 70, 50);
  target += exponential_lpdf(sigma | 0.1);

  target += normal_lpdf(y | alpha[school], sigma);
}

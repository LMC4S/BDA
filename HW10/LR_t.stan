data {
  int<lower=0> N;
  vector[N] x1;
  vector[N] x2;
  vector[N] y;
}
parameters {
  real beta0;
  real beta1;
  real beta2;
  real<lower=0> nu;
  real<lower=0> sigma;
}
model {
  target += exponential_lpdf(nu| .1);
  target += student_t_lpdf(y| nu+1, beta0 + beta1*x1 + beta2*x2, sigma);
}

data {
  int<lower=0> J;
  int<lower=0> I;
  matrix[J, I] S;
  matrix[J, I] W;
  matrix[J, I] IND;
}

parameters {
  real<lower=0, upper=100> alpha;
  real<lower=0, upper=100> beta;
  matrix<lower=0>[J, I] T;
}

transformed parameters {
  matrix[J, I] Lambda = IND*alpha + W*beta; 
  matrix[J, I] Prod = S * T;
  vector[J*I] Lambda_vec = to_vector(Lambda);
  vector[J*I] Prod_vec = to_vector(Prod);
  vector[J*I] T_vec = to_vector(T);
}


model {
  target += exponential_lpdf(T_vec | Lambda_vec);
  for (ind in 1:(J*I)) {
    target += (Prod_vec[ind] > 10 || Prod_vec[ind] <= 0);
  }
}




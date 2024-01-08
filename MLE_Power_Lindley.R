### Settings

n <- c(25, 50, 75, 100, 200); N <- 10000
alphas <- c(0.2, 1.5, 0.9); betas <- c(4, 1, 0.35)
library(ggplot2)

### Power Lindley PDF
dplindley <- function(x, alpha, beta){
  
  p <- ((alpha * beta^2) / (beta + 1)) * (1 + x^alpha) * x^(alpha - 1) *
    exp(-beta * (x^alpha))
  
  return(p)
}

### Power Lindley Plot

my.lab <- c(bquote(alpha == .(alphas[1]) ~ ", " ~ beta == .(betas[1])),
            bquote(alpha == .(alphas[2]) ~ ", " ~ beta == .(betas[2])), 
            bquote(alpha == .(alphas[3]) ~ ", " ~ beta == .(betas[3])))

x1 <- seq(0, 4, 0.0001)
df <- data.frame(x = x1, y = c(y1 = dplindley(x1, alphas[1], betas[1]),
                               y2 = dplindley(x1, alphas[2], betas[2]),
                               y3 = dplindley(x1, alphas[3], betas[3])), 
                 group = factor(rep(1:3, each = 40001)))

ggplot(df, aes(x = x, y = y, group = group, colour = group)) +
  geom_line(size = 1) +
  scale_colour_manual(name = "", values = c("#A11D21", "#003366", "green"),
                      labels = my.lab) +
  labs(x = "x", y = "Função Densidade de Probabilidade") +
  theme_bw() +
  theme(axis.title.y = element_text(colour = "black", size = 12),
        axis.title.x = element_text(colour = "black", size = 12),
        axis.text = element_text(colour = "black", size = 9.5),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.background = element_blank(),
        legend.text = element_text(size = 15),
        legend.position = c(0.55,0.85)) +
  scale_x_continuous(limits = c(0, 4)) +
  scale_y_continuous(limits = c(0, 2))


#Algorithm 1

Algoritmo1 <- function(n, alpha, beta){
  
  x <- numeric(n)
  u <- runif(n); e <- rexp(n, beta); g <- rgamma(n, 2, rate = beta)
  
  for (i in 1:n) {
    if(u[i] <= beta / (beta + 1)){
      
      x[i] <- e[i]^(1 / alpha)
      
    } else {
      
      x[i] <- g[i]^(1 / alpha)
      
    }}
  
  return(x)
}


#Algorithm 3

Algoritmo3 <- function(n, alpha, beta){
  x <- numeric(n)
  u <- runif(n)
  
  for (i in 1:n) {
    
    x[i] <- (-1 -(1/beta) - (1/beta)*
               lamW::lambertWm1(((beta + 1) / exp(beta + 1))* (1 - u[i]) * (-1)))^(1 / alpha)
    
  }
  
  return(x)
}


### Power Lindley log-likelihood function
loglik <- function(vetor, x){
  
  LL <- sum(log(dplindley(x = x, alpha = vetor[1], beta = vetor[2])))
  
  return(-LL)
}


### Monte-Carlo Loop Algorithm 1

df1 <- data.frame()

for (k in 1:3) {
  
  for (j in 1:5){
    
    soma_parametros <- c(0, 0)
    soma_var <- c(0,0)
    
    for(i in 1:N){
      
      x <- Algoritmo1(n[j], alphas[k], betas[k])
      fit <- suppressWarnings(optim(c(alphas[k], betas[k]), loglik, x = x,
                                    method = "Nelder-Mead")$par)
      
      
      soma_parametros <- soma_parametros + fit
      soma_var <- soma_var + (fit - c(alphas[k], betas[k]))^2
    }
    
    vies_alpha <- round(soma_parametros[1]/N - alphas[k], 4)
    eqm_alpha <-  round(soma_var[1]/N + vies_alpha^2, 4)
    vies_beta <-  round(soma_parametros[2]/N - betas[k], 4)
    eqm_beta <-  round(soma_var[2]/N + vies_beta^2, 4)
    
    df1 <- rbind(df1, c(alphas[k], betas[k], n[j],
                        vies_alpha, eqm_alpha, vies_beta, eqm_beta))
  }
}

names(df1)[1] <- "Alpha"; names(df1)[2] <- "Beta"; names(df1)[3] <- "n"
names(df1)[4] <- "Vies Alpha"; names(df1)[5] <- "EQM Alpha"
names(df1)[6] <- "Vies Beta"; names(df1)[7] <- "EQM Beta"

knitr::kable(df1, caption = "Tabela do Algoritmo 1")


### Monte-Carlo Loop Algorithm 3

df3 <- data.frame()

for (k in 1:3) {
  
  for (j in 1:5){
    
    soma_parametros <- c(0, 0)
    soma_var <- c(0,0)
    
    for(i in 1:N){
      
      x <- Algoritmo3(n[j], alphas[k], betas[k])
      fit <- suppressWarnings(optim(c(alphas[k], betas[k]), loglik, x = x,
                                    method = "Nelder-Mead")$par)
      
      
      soma_parametros <- soma_parametros + fit
      soma_var <- soma_var + (fit - c(alphas[k], betas[k]))^2
    }
    
    vies_alpha <- round(soma_parametros[1]/N - alphas[k], 4)
    eqm_alpha <-  round(soma_var[1]/N + vies_alpha^2, 4)
    vies_beta <-  round(soma_parametros[2]/N - betas[k], 4)
    eqm_beta <-  round(soma_var[2]/N + vies_beta^2, 4)
    
    df3 <- rbind(df3, c(alphas[k], betas[k], n[j],
                        vies_alpha, eqm_alpha, vies_beta, eqm_beta))
  }
}

names(df3)[1] <- "Alpha"; names(df3)[2] <- "Beta"; names(df3)[3] <- "n"
names(df3)[4] <- "Vies Alpha"; names(df3)[5] <- "EQM Alpha"
names(df3)[6] <- "Vies Beta"; names(df3)[7] <- "EQM Beta"

knitr::kable(df3, caption = "Tabela do Algoritmo 3")
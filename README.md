# MLE\_Power\_Lindley

## Objective
This case study main goal is to evaluate two different random numbers generation algorithms for the Power Lindley distribution, through the use of maximum likelihood estimators and Monte Carlo simulations.


## Justification

The Lindley distribution was proposed in 1958, sharing the name with it's author; however, the distribution suffers from many "lack of fit" problems in practical and theorical models. For this reason, the "Power Lindley" distribution was developed after a power transformation on the Lindley distribution. It's probability density function equation is:

$$f_{1}(t) = p \xi_{1} + (1 - p) \xi_{2}, \text{ where } p = \frac{\beta}{\beta + 1}, \text{ } \xi_{1}(t) = \beta e^{-\beta t}, \text{ } \xi_{2}(t) = \beta^2 t e^{-\beta t}$$

On a closer look, we can see that the Power Lindley distribution is a combination of a Weibull($\alpha,\beta$) and Generalized Gamma (2, $\alpha, \beta$) with a "mixture" component "p". 

Since we have a new distribution, it is natural to obtain good estimators for it's parameters. In this sense, we'll be using the maximum likelihood estimation method to obtain estimators for $\alpha$ and $\beta$, with a proof test to their Bias and Mean Squared Error.


## Choices and Metodology

Since we want to construct Power Lindley's ML estimators, we chose to generate random numbers from the Power Lindley distribution through two algorithms (1 and 3) proposed in the "Power Lindley distribution and associated inference" article, which this project relies on. Furthermore, the reading of the referenced article is highly advised for a much better understanding of this project and the Power Lindley distribution as a whole.


Using Monte Carlo loops, we ran 10k simulations of both algorithms, generating numbers with the following parameters:

* Total of numbers generated (n) - 25, 50, 75, 100 or 200;
* ($\alpha, \beta$) - (0.2, 4), (1.5, 1) or (0.9, 0.35).

Then, for every possible combination of these values, we calculated the ML estimators and obtained their respective bias and MSE. This way, we managed to test Power Lindley's MLE and the algorithms proposed in the mentioned article at the same time.

The whole explanation and analysis of this project can be found in the 'Trabalho-Matheus-Erbisti.Rmd' file, even though it is written in Portuguese. The final results were satisfactory, showing small values for bias and MSE in both estimators, and is very similar to what was showed in the article. However, we can see that the $\beta$ estimator is usually much more sensitive to a smaller sample size than $\alpha$ is, having much worse metrics for a same "n" sample size.

## License and Contact

This project was created by Matheus Erbisti, with guidance from Professor Helton Saulo. It falls under the MIT License, which means you are free to use and adapt this code at your will, just make sure to reference us!

If you need to make contact about this project, you can reach out to me on LinkedIn (https://www.linkedin.com/in/matheus-erbisti-b74168172/) or via e-mail at matheuserbisti@hotmail.com.


Thank you for your attention!

# ann_mlp
Artificial Neural Network - Multilayer Perceptron - Predicting The Class of Breast Cancer using VHDL

Desenvolvido por: Vitor Martins Barbosa
Num_ID: 12099991

Programa desenvolvido afim de realizar a validação de um conjunto de dados sobre a classe do câncer de mama (benigno ou maligno).
A base de dados foi adquirida através do link: http://neuroph.sourceforge.net/tutorials/PredictingBreastCancer/PredictingBreastCancer.html.

Classificação:

A base de dados é separada da seguinte maneira:

-70% para treinamento;
-15% para validação;
-15% para teste.

Toda etapa de treinamento (levantamento dos pesos) é realizada utilizando o algoritmo do matlab.

Validação:

Os pesos são levantados na classificação e passado para o algoritmo do VHDL, assim, como os dados de entrada a ser desejado.

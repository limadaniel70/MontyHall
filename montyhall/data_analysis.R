library(ggplot2)
library(readr)
library(tidyr)
library(dplyr)
library(scales)

data <- read_csv("../montyhall.csv")

#----

names(data) <- c("Ficar", "Trocar")

data_gather <- data %>% 
  pivot_longer(cols = c(Ficar, Trocar), names_to = "Estrategia", values_to = "Ganhou")

ratio <- nrow(filter(data_gather, Estrategia == "Trocar", Ganhou == TRUE)) /
  nrow(filter(data_gather, Estrategia == "Ficar", Ganhou == TRUE))

data_qtd <- data.frame(
  "estrategia" = c(
    "vitorias_trocando",
    "perdas_trocando",
    "vitorias_ficando",
    "perdas_ficando"
  ),
  "valores" = c(nrow(
    filter(data_gather, Estrategia == "Trocar", Ganhou == TRUE)
  ), nrow(
    filter(data_gather, Estrategia == "Trocar", Ganhou == FALSE)
  ), nrow(
    filter(data_gather, Estrategia == "Ficar", Ganhou == TRUE)
  ), nrow(
    filter(data_gather, Estrategia == "Ficar", Ganhou == FALSE)
  ))
)

resultados <- data %>% 
  mutate(Index = row_number())

resultados$Ficar <- cummean(resultados$Ficar)
resultados$Trocar <- cummean(resultados$Trocar)

resultados_longer <- resultados %>% 
  pivot_longer(cols = c(Ficar, Trocar), names_to = "Estratégia", values_to = "acertos") 
#----

# Ratio
ggplot(data_gather, aes(Estrategia, fill = Ganhou, label = Ganhou)) +
  geom_bar(width = 0.5) +
  scale_fill_manual(
    values = c("TRUE" = "green", "FALSE" = "red"),
    labels = c("Falso", "Verdadeiro")
  ) +
  theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) +
  labs(
    y = NULL,
    title = "Vitórias em Função da Estratégia",
    subtitle = sprintf("Razão entre vitórias 'Trocar' e 'Ficar': %f", ratio)
  )

#----

# Qtd
ggplot(data_qtd, aes(
  x = reorder(estrategia, valores),
  y = valores,
  fill = estrategia
)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_fill_manual(
    values = c(
      "vitorias_trocando" = "green",
      "perdas_trocando" = "red",
      "vitorias_ficando" = "darkgreen",
      "perdas_ficando" = "darkred"
    )
  ) +
  geom_text(aes(label = valores), vjust = -0.3) +
  scale_y_continuous(labels = comma_format(big.mark = ".", decimal.mark = ",")) +
  theme(axis.title.x = element_blank(), axis.text.x = element_blank()) +
  labs(title = "Qtd. de Vitórias e Perdas Para Cada Estratégia", y = "Qtd.", x = NULL)

#----

#PROB
ggplot(head(resultados_longer, 10000), aes(x = Index, y = acertos, colour = Estratégia)) +
  geom_line() +
  geom_hline(yintercept = 1/3, linetype = "dashed", color = "red", size = 1) +
  geom_hline(yintercept = 2/3, linetype = "dashed", color = "green", size = 1) +
  scale_y_continuous(labels = percent_format()) +
  labs(
    x = NULL,
    y = "Probabilidade",
    title = "Probabilidade de Vencer"
  )


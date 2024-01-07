title: "R Notebook"
output: html_notebook
---



This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
library("tidyverse")
setwd("/Users/ajssz/Desktop/Rcoding")
female <- read.csv("female.csv")
head(female)
```

```{r}
is.data.frame(female)
```


```{r}
library(tidyverse)
female <- female %>%
  filter(Country.Name == "Spain" | Country.Name == "Pakistan" | Country.Name == "Italy")
head(female)
```


```{r}


female <- female[ -c(1,2,4,5:8,10:11,13:15)] %>%
  rename("2014"= 2, "2017" = 3, "2021" = 4)

head(female)
```

```{r}
transpose_f <- data.frame(t(female[-1]))
colnames(transpose_f) <- female[,1]
head(transpose_f)
```


```{r}
print(sapply(transpose_f,class))
```


```{r}
transpose_f$Spain = as.numeric(as.character(transpose_f$Spain))
transpose_fPakistan = as.numeric(as.character(transpose_f$Pakistan))
transpose_f$Italy = as.numeric(as.character((transpose_f$Italy)))
head(transpose_f)
```


```{r}
summarise_each(transpose_f,list(mean))
```


```{r}
library(ggplot2)
year <- c(2014,2017,2021)
ggplot(data = transpose_f, aes(x = year,y = Pakistan, group = 1)) + geom_line() + geom_point()

```


```{r}
setwd("/Users/ajssz/Desktop/Rcoding")
male <- read.csv(file = "male.csv")
male <- male %>%
  filter(Country.Name == "Spain" | Country.Name == "Pakistan" | Country.Name == "Italy")

male <- male[ -c(1,2,4,5:8,10:11,13:15)] %>%
  rename("2014"= 2, "2017" = 3, "2021"= 4)
head(male)

```
```{r}
transpose_m <- data.frame(t(male[-1]))
colnames(transpose_m) <- male[, 1]

transpose_m$Spain = as.numeric(as.character(transpose_m$Spain))
transpose_m$Pakistan = as.numeric(as.character(transpose_m$Pakistan))
transpose_m$Italy = as.numeric(as.character((transpose_m$Italy)))

head(transpose_m)
```



```{r}
library("dplyr")
transpose_m <- dplyr::rename(transpose_m, "Spain_m" = 1, "Pakistan_m" = 2, "Italy_m" = 3)

head(transpose_m)
```



```{r}

transpose_m <- rownames_to_column(transpose_m, var = "Year")
tranpose_f <- rownames_to_column(tranpose_f, var = "Year")

```




```{r}
acct_owner_by_gender <- merge(x = transpose_m, y = transpose_f, by = "Year",all.x = TRUE)
acct_owner_by_gender <- rename(acct_owner_by_gender, "Italy" = 7)
head(acct_owner_by_gender)
```


```{r}

gfg_plot <- ggplot(acct_owner_by_gender, aes(x=year)) +
  geom_line(aes(y = Pakistan), color = "black") +
  geom_line(aes(y = Pakistan_m), color = "red") +
  geom_line(aes(y = Spain), color = "green") +
  geom_line(aes(y = Spain_m), color = "blue") +
  geom_line(aes(y = 'Italy'), color = "purple") +
  geom_line(aes(y = 'Italy_m'), color = "violet")
  print(gfg_plot + labs(y = "Level of Education Percentage", x = "Year"))

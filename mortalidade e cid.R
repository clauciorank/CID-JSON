library(jsonlite)
library(dplyr)
library(rvest)
library(stringr)




CID10Codigos <- fromJSON('http://cid.api.mokasoft.org/cid10')

### Tabela capitulos cid 


cap_cid <- read_html('http://tabnet.datasus.gov.br/cgi/sih/mxcid10.htm') %>% html_table()

cap_cid <- cap_cid[[3]]
colnames(cap_cid) <- cap_cid[2,]
cap_cid <- cap_cid %>% slice(-c(1:3))


causabas$let <- substring(causabas$CAUSABAS, 1,1)
causabas$num <- substring(causabas$CAUSABAS,2,3)


zero_ninenine <- paste0(0:99) %>% str_pad(2, pad = '0', side = 'left')


cap1 <- paste(c(paste0('A', zero_ninenine), paste0('B', zero_ninenine)), collapse = ',')
cap2 <- paste(c(paste0('C', zero_ninenine), 
                paste0('D', paste0(0:48) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap3 <- paste(c(paste0('D', paste0(50:89) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap4 <- paste(c(paste0('E', paste0(00:90) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap5 <- paste(c(paste0('F', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap6 <- paste(c(paste0('G', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap7 <- paste(c(paste0('H', paste0(00:59) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap8 <- paste(c(paste0('H', paste0(60:95) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap9 <- paste(c(paste0('I', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap10 <- paste(c(paste0('J', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap11 <- paste(c(paste0('K', paste0(00:93) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap12 <- paste(c(paste0('L', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap13 <- paste(c(paste0('M', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap14 <- paste(c(paste0('N', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap15 <- paste(c(paste0('O', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap16 <- paste(c(paste0('P', paste0(00:96) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap17 <- paste(c(paste0('Q', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap18 <- paste(c(paste0('R', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap19 <- paste(c(paste0('S', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left')),
                 paste0('T', paste0(00:98) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap20 <- paste(c(paste0('V', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left')),
                 paste0('W', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left')),
                 paste0('X', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left')),
                 paste0('Y', paste0(00:98) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
cap21 <- paste(c(paste0('Z', paste0(00:99) %>% str_pad(2, pad = '0', side = 'left'))), collapse = ',')
capunk <- ''



cap_cid$codigos <- c(cap1,cap2,cap3,cap4,cap5,cap6,cap7,cap8,cap9,cap10,cap11,cap12,cap13,cap14,
  cap15,cap16,cap17,cap18,cap19,cap20,cap21,capunk)



capitulos <- c()
counter <- 0
for (i in a$codigo){
  indexcapitulo <- grep(substring(i,1,2), cap_cid$codigos)
  if(length(indexcapitulo == 1)){
    capitulos <- append(capitulos, cap_cid$Capítulo[indexcapitulo])
  }else{
    capitulos <- append(capitulos, cap_cid$Capítulo[22])
  }
  counter <- counter + 1
  print(counter)
}


unique(capitulos)


a$capitulos <- capitulos

cap_cid2 <- cap_cid %>% select(1:2) %>% rename('capitulos' = Capítulo)


a <- a %>% left_join(cap_cid2, by = 'capitulos')


c <- a %>% select(codigo, nome, 'capitulo' = capitulos, 'descricao_capitulo' = Descrição)


data <- toJSON(c)


write(data, '~/Documents/Mortalidade/CID to JSON/cid-todos.json')


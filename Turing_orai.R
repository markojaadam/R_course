magneskartya <- list('A'=list('0'=list(1,'jobb','B'),
                              '1'=list(1,'bal','C')),
                     'B'=list('0'=list(1,'bal','A'),
                              '1'=list(1,'jobb','B')),
                     'C'=list('0'=list(1,'bal','B'),
                              '1'=list(1,'jobb','ALLJ')),
                     'ALLJ' = 'None')
szalag <- c(0)
pozicio <- 1
allapot <- 'A'

terjeszd_ki <- function(irany) {
  if (irany=='jobb') {
    szalag <<- c(szalag,0)
  } else if (irany == 'bal'){
    szalag <<- c(0,szalag)
    pozicio <<- pozicio + 1
  }
}

olvasd_ki <- function() {
  return(toString(szalag[pozicio]))
}

irja_ra <- function(szimbolum) {
  szalag[pozicio] <<- szimbolum
}

lepkedj <- function(irany) {
  if (irany == 'bal') {
    pozicio <<- pozicio - 1
  } else if (irany == 'jobb'){
    pozicio <<- pozicio + 1
  }
}

feladat <- function(allapot) {
  ertek <- olvasd_ki()
  teendo <- magneskartya[[allapot]][[ertek]]
  irja_ra(teendo[[1]])
  allapot <<- teendo[[3]]
  if (pozicio == 1 & teendo[[2]] == 'bal') {
    terjeszd_ki('bal')
  } else if (pozicio == length(szalag) & teendo[[2]] == 'jobb') {
    terjeszd_ki('jobb')
  }
  lepkedj(teendo[[2]])
}

helyzet_kiiras <- function() {
  cat('Allapot: ',allapot,',Pozicio: ',pozicio,',Szalag: ',szalag,'\n')
}

while (allapot != 'ALLJ') {
  feladat(allapot)
  helyzet_kiiras()
  Sys.sleep(0.2)
}
# -------- Print, writeLines és cat függvények --------

print(1)
print('Ez egy szöveg')
print('Ez egy szöveg\nEz egy másik szöveg')

# Mi a különbség?
writeLines('Ez egy szöveg\nEz egy másik szöveg')
cat('Ez egy szöveg\nEz egy másik szöveg')

# Itt még semmi
writeLines(c('Ez egy szöveg','Ez egy másik szöveg'))
cat(c('Ez egy szöveg','Ez egy másik szöveg'))
cat(c('Ez egy szöveg','Ez egy másik szöveg'),sep='\n')

## A cat() függvény:
?cat
# Mit tartalmazhat a file?
cat('Ez egy szöveg\nEz egy másik szöveg\n',file='output1.txt')
cat('Ez egy harmadik szöveg\nEz egy negyedik szöveg\n',file='output1.txt')
# És most?
cat('Ez egy negyedik szöveg\nEz egy ötödik szöveg\n',file='output1.txt',append=TRUE)

## writeLines:
?writeLines
fileConn <- file("output2.txt")
writeLines('Ez egy hatodik szöveg\nEz egy hetedik szöveg\n', con=fileConn)
close(fileConn)
writeLines('Ez egy nyolcadik szöveg\nEz egy kilencedik szöveg\n', con=fileConn)

# Na még egyszer:
fileConn<-file("output2.txt")
writeLines('Ez egy nyolcadik szöveg\nEz egy kilencedik szöveg\n', con=fileConn)
close(fileConn)

# Mi az eredmény?

# Így lehet hozzáfűzni az új szöveget:
fileConn<-file("output2.txt", open="a")
writeLines('Ez egy tizedik szöveg\nEz egy tizenegyedik szöveg\n', con=fileConn)
close(fileConn)

# Egyszerű beolvasás
fileConn<-file("output2.txt", open="r")
readLines(fileConn)
szoveg <-readLines(fileConn)
writeLines(szoveg)
close(fileConn)
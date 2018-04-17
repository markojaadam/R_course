# 0.1 Libraryk behívása ----------
require(stringr)

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
fileConn<-file("output2.txt")
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

# ----   Az R alapvető szintaktikája ----

# Ezt jó megjegyezni!!!

#     operátor(állítás) {
#         parancs
#     }


# 3 Feltételhez kötött végrehajtás ----------
# Mi van, ha feltételhez szeretnénk kötni valamely parancs teljesítését?
# Például.: Írj ki valamit, ha a szám értéke nagyobb 100-nál

x <- 101
print('A szam nagyobb szaznal')


x <- 99
print("A szam kisebb szaznal")

# 3.1 Az if parancs ----------
# Megvizsgálja, hogy az adott állítás igaz-e és csak akkor hajtja végre a megadott utasítást, ha igaz.
# Szintaktika:

#     if(<<állítás>>) {
#       csináld-ezt-meg-azt-ha-<<állítás>>-igaz
#     }

# Mit lesz az eredménye a végrehajtásnak?


x <- 99
if (x > 100) {
  print('Juhu, a szam nagyobb szaznal.')
}

# És most?

x <- 101
if (x > 100) {
  print('Juhu, a szam nagyobb szaznal.')
}

# Prettify: Sok elrendezésben lefut a kódunk, az elsődleges szempont mindig az áttekinthetőség:

if (x > 100) {
  print('Juhu, a szam nagyobb szaznal.')
}

if (x > 100) {
print('Juhu, a szam nagyobb szaznal.')
}

if (x > 100) {print('Juhu, a szam nagyobb szaznal.')}

if (x > 100)
  {print('Juhu, a szam nagyobb szaznal.')}

# 3.2 Az else kapcsoló ----------

# Mi van, ha akkor is szeretnénk valami mást végrehajtani, ha nem teljesül az állítás, pl. írja ki, hogy sajnos a szám nem nagyobb 100-nál 

# else parancs: akkor hejtódik végre, ha az if mögött állítás nem teljesül.
# Szintaktika:

#     if(<<állítás>>) {
#       csináld-ezt-meg-azt-ha-<<állítás>>-igaz
#     } else {
#       csinálj-valami-mást
#     }

x <- 101
if (x > 100) {
  print('Juhu, a szam nagyobb szaznal.')
} else {
  print('Sajnos a szam nem nagyobb 100-nal')
}

x <- 100
if (x > 100) {
  print('Juhu, a szam nagyobb szaznal.')
} else {
  print('Sajnos a szam nem nagyobb 100-nal')
}

# -------- Az else if kapcsoló --------
# Mi van, ha arra is szeretnenk egy kiirast, ha a szam pont 100?
# Az else if közbeiktatása: ha nem igaz az if mögötti állítás, de az else if mögötti igen, akkor végrehajtja.
# Szintaktika:

#     if(<<állítás1>>) {
#       csinád-ezt-meg-azt-ha-<<állítás1>>-igaz
#     } else if(<<allitas2>>) {
#       csinál-valami-mást-ha-<<állítás1>>-nem-igaz-de-<<állítás2>>-igaz
#     } else {
#       csinál-valami-mást-ha-egyik-állítás-sem-igaz
#     }

x = 100
if (x > 100) {
  print("Juhu, a szam nagyobb szaznal.")
} else if (x == 100) {
  print("Hoho, a szam pont 100!")
} else {
  print("Sajnos a szam kisebb 100-nal")
}

# Van különbség az alábbi két parancs végrehajtásának eredményében?

x = 0.5
if (x < 2) {
  print("Kisebb, mint ketto")
}
if (x < 1) {
  print("Kisebb, mint egy")
}

x = 0.5
if (x < 2) {
  print("Kisebb, mint ketto")
} else if (x < 1) {
  print("Kisebb, mint egy")
}

# 3.4.1 Feladat ----------
# Csináljunk egy olyan döntési struktúrát, ami meghatározza, hogy az adott szám osztható-e tízzel, kettővel, vagy öttel.
# Ha tízzel osztható, csak annyit írjon ki, hogy tízzel osztható, ha kettővel, vagy öttel osztható, ha pedig egyikkel sem, akkor írja ki,
# hogy nem osztható egyikkel sem.
# Segítség: oszthatóság ellenőrzése: x%%y = x/y osztás maradéka

# 4 Ciklusok ----------

# 4.1 A while ciklus ----------
# Mi van, ha ugyanazt a műveletet többször szeretnénk elvégezni, például írd ki örször azt, hogy "a"?

# Favágó megoldás:

print('a')
print('a')
print('a')
print('a')
print('a')

# Jó lenne egy olyan lehetőség, amivel megmondhatjuk neki, hányszor végezze el az adott műveletet, például:

#     csináld(5) {
#         print('a')
#     }

# Erre jó a ciklus!
# Az R 2 fajta ciklust ismer:
#      while: (alacsonyabb szintű)
#      for: (magasabb szintű)

# A while ciklus szintaktikája:
#     
#     while(<<állítás>>) {
#       csináld-ezt-meg-azt-amíg-<<állítás>>-igaz
#     }

# Jelentése: Hajtsd végre a megadott parancsot, ameddig az állítás igaz
# Minden végrehajtás után ellenőrzi, hogy igaz-e az állítás!


# Mit csinálhat ez a parancs?

while(TRUE) {
  print('Hello world!')
}

# És ez?

while(FALSE) {
  print('Hello world!')
}

# Látszólag egyiknek sem volt értelme. Az első végtelen végrehajtáshoz vezetett, a második pedig nem csinált semmit.
# Akkor mégis hogyan működhet a while parancs, hogyan válhatna hasznunkra?

# A megoldás: iterátor változó:


i <- 1 # iterator valtozo
while(i < 5) { # Csinald, amig i kisebb 5-nel
  # ird ki i erteket
  print(i)
  # noveld meg i-t eggyel,
  # ezutan visszater a ciklus elejere
  i = i+1
}

# Vagy írjuk ki ötször azt, hogy "a":


i = 1
while (i <= 5) {
  print('a')
  i = i + 1 # ezt a sort soha ne felejtsuk el while ciklusnal!!! Ellenkezo esetben vegtelen ciklus...
}


# 4.1.1 Előltesztelő és hátultesztelő ciklusok: a break parancs használata ------------------

# A break parancs azonnal megszakítja a ciklus futását:

while(TRUE) {
  print('Hello world!')
  break
}

while(TRUE) {
  break
  print('Hello world!')    
}

# Így nézne ki az iterátor értékét kiíró függvény hátultesztlő változata:

i <- 1
while (TRUE) {
  print(i)
  i = i + 1
  if (i >= 5) {
      break
  }
}

# Egy kis kitérő:
# 4.1.2 műveletek vektorokkal ----------

v1 <- c('a','b','c','d')
print(v1)

# 4.1.2.1 Az append parancs ----------

# Hozzáad egy elemet a listához:

print(v1)
v1 <- append(v1,'e')
print(v1)

# 4.1.2.2 Vektor elemeinek száma és indexelés ----------

# A length visszaadja a lista elemeinek számát:

length(v1)

# Érvényes indexelés:

v1[1]

# Érvénytelen indexelés (az index magasabb, mint a lista elemeinek a száma):

v1[10]

# A negatív index visszaadja az egész listát, a negatívan indexelt elemet kivéve:

v1[-3]

# Vektor segítségével több elemet is lekérhetünk:

v1[c(1:3)]
# Ez egyenértékű a következővel:
v1[1:3]

# Azonban:
v1[1,3]
v1[c(1,3)]


# A vektor és a length kombinálásával visszakérhetjük a listánk utolsó x elemét:

v1[c(3:length(v1))]
v1[3:length(v1)]

# 4.1.3 Feladat ----------

# Készítsünk a while ciklus segítségével olyan vektort, ami kettő hatványait tartalmazza
# Legyen a maximum 2^20!
# Segítség: A hatványozás operátora a "^", vagy a "**".


# Ha ez kész, paraméterezzük változó (mondjuk x) segítségével a vektorunk maximális elemszámát!


# Írjatok olyan parancsot, ami tetszőleges hosszúságú Fibonacci számsort állít elő!
# Fibonacci-sor:
# Olyan sorozat, amely minden n-edik elemének értéke megegyezik az n-1-edik és az n-2-edik elem összegével:
# 0, 1, 1, 2, 3, 5, 8, 13, 21, stb.

# 4.2 A for ciklus ----------

# Hogyan tudnánk egymás után kiíratni a v1 vektor értékeit?

print(v1)

# "Favágó" megoldás a while ciklussal:

i <- 1
while (i <= length(v1)) {
    print(v1[i])
    i = i + 1
}

# Ennél van egy egyszerűbb módszer!
# A for cilus: végigmegy a vektor összes elemén.
# A ciklusban létrehozunk egy iterátor változót, ami minden körben a vektor soron következő elemének értékét veszi fel.
# Szintaktika:

#     for (<<iterátor>> in <<vektor>>): {
#       csinald-ezt-meg-azt, pl.
#       print(<<iterátor>>) --> kiírja a vektor soron következő elemét.
#     }


for (elem in v1) {
    print(elem)
}

# A for ciklus működik szekvenciákon is:

seq(0,10,2)

# Mi fog történni a parancs végrehajtásakor?

for (i in seq(0,10,2)) {
    print(i^2)
}

# 4.2.1 Feladat ----------
# Csináljuk meg a korábbi, hatványos példát a for ciklus és a seq parancs kombinálásával!

v2 <- c(3, 7, 4, 2, 123, 5678, 134, 23, 57, 23324)
# Készítsünk v3 néven olyan vektort, aminek az első eleme a v2 vektor első elemének az egyszerese, a második a v2 második elemének a kétszerese, a harmadik a v2 harmadik elemének háromszorosa, stb, az n-edik elem a v2 n-edik elemének n-szerese.

# Íjrunk egy olyan parancsot, ami megkeresi az x-nél kisebb összes prímszámot!

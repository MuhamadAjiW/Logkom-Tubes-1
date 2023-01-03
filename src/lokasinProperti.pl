/* Lokasi */
/*Deklarasi Fakta*/
/*lokasi(X): X adalah sebuah lokasi yang valid pada Map*/
lokasi(go).
lokasi(cc).
lokasi(cc1).
lokasi(cc2).
lokasi(cc3).
lokasi(jl).
lokasi(tx).
lokasi(tx1).
lokasi(tx2).
lokasi(fp).
lokasi(wt).
lokasi(gc).
lokasi(wc).

/*Deklarasi Rules*/
/*lokasi(X): X adalah sebuah lokasi yang valid pada Map*/
lokasi(X) :- properti(X).

/*kepemilikanProperti(Properti, Pemilik): Pemilik adalah pemilik dari Properti*/
kepemilikanProperti(Properti, Pemilik):- asetProperti(Pemilik, Properti).

/*biayaSewaProperti(Properti, BiayaSewa): BiayaSewa adalah biaya sewa dari Properti saat ini*/
biayaSewaProperti(Properti, BiayaSewa):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Tanah', hargaSewaProperti(Properti, HargaSewaTanah, _, _, _, _), BiayaSewaAsli is HargaSewaTanah, 
                                        (isBlock(Properti), BiayaSewaTemp is BiayaSewaAsli*2 ; BiayaSewaTemp is BiayaSewaAsli), 
                                        (
                                            asetProperti(Pemilik, Properti),
                                            worldCupCurrent(Penyelenggara, Lokasi),
                                            (
                                                Lokasi == Properti, Penyelenggara == Pemilik, BiayaSewa is BiayaSewaTemp*2;
                                                BiayaSewa is BiayaSewaTemp
                                            )
                                        ;
                                            BiayaSewa is BiayaSewaTemp 
                                        ), !.
biayaSewaProperti(Properti, BiayaSewa):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Bangunan1', hargaSewaProperti(Properti, _, HargaSewaBangunan1, _, _, _), BiayaSewaAsli is HargaSewaBangunan1,
                                        (isBlock(Properti), BiayaSewaTemp is BiayaSewaAsli*2 ; BiayaSewaTemp is BiayaSewaAsli), 
                                        (
                                            asetProperti(Pemilik, Properti),
                                            worldCupCurrent(Penyelenggara, Lokasi),
                                            (
                                                Lokasi == Properti, Penyelenggara == Pemilik, BiayaSewa is BiayaSewaTemp*2;
                                                BiayaSewa is BiayaSewaTemp
                                            )
                                        ;
                                            BiayaSewa is BiayaSewaTemp 
                                        ), !.
biayaSewaProperti(Properti, BiayaSewa):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Bangunan2', hargaSewaProperti(Properti, _, _, HargaSewaBangunan2, _, _), BiayaSewaAsli is HargaSewaBangunan2 ,
                                        (isBlock(Properti), BiayaSewaTemp is BiayaSewaAsli*2 ; BiayaSewaTemp is BiayaSewaAsli), 
                                        (
                                            asetProperti(Pemilik, Properti),
                                            worldCupCurrent(Penyelenggara, Lokasi),
                                            (
                                                Lokasi == Properti, Penyelenggara == Pemilik, BiayaSewa is BiayaSewaTemp*2;
                                                BiayaSewa is BiayaSewaTemp
                                            )
                                        ;
                                            BiayaSewa is BiayaSewaTemp 
                                        ), !.
biayaSewaProperti(Properti, BiayaSewa):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Bangunan3', hargaSewaProperti(Properti, _, _, _, HargaSewaBangunan3, _), BiayaSewaAsli is HargaSewaBangunan3 ,
                                        (isBlock(Properti), BiayaSewaTemp is BiayaSewaAsli*2 ; BiayaSewaTemp is BiayaSewaAsli), 
                                        (
                                            asetProperti(Pemilik, Properti),
                                            worldCupCurrent(Penyelenggara, Lokasi),
                                            (
                                                Lokasi == Properti, Penyelenggara == Pemilik, BiayaSewa is BiayaSewaTemp*2;
                                                BiayaSewa is BiayaSewaTemp
                                            )
                                        ;
                                            BiayaSewa is BiayaSewaTemp 
                                        ), !.
biayaSewaProperti(Properti, BiayaSewa):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Landmark', hargaSewaProperti(Properti, _, _, _, _, HargaSewaLandmark), BiayaSewaAsli is HargaSewaLandmark ,
                                        (isBlock(Properti), BiayaSewaTemp is BiayaSewaAsli*2 ; BiayaSewaTemp is BiayaSewaAsli), 
                                        (
                                            asetProperti(Pemilik, Properti),
                                            worldCupCurrent(Penyelenggara, Lokasi),
                                            (
                                                Lokasi == Properti, Penyelenggara == Pemilik, BiayaSewa is BiayaSewaTemp*2;
                                                BiayaSewa is BiayaSewaTemp
                                            )
                                        ;
                                            BiayaSewa is BiayaSewaTemp 
                                        ), !.

/*biayaProperti(Properti, Biaya): Biaya adalah harga dari Properti*/
nilaiProperti(Properti, Nilai):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Tanah', hargaProperti(Properti, HargaTanah, _, _, _, _), Nilai = HargaTanah, !.
nilaiProperti(Properti, Nilai):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Bangunan1', hargaProperti(Properti, HargaTanah, HargaBangunan1, _, _, _), Nilai = (HargaTanah + HargaBangunan1), !.
nilaiProperti(Properti, Nilai):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Bangunan2', hargaProperti(Properti, HargaTanah, HargaBangunan1, HargaBangunan2, _, _), Nilai = (HargaTanah + HargaBangunan1 + HargaBangunan2), !.
nilaiProperti(Properti, Nilai):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Bangunan3', hargaProperti(Properti, HargaTanah, HargaBangunan1, HargaBangunan2, HargaBangunan3, _), Nilai = (HargaTanah + HargaBangunan1 + HargaBangunan2 + HargaBangunan3), !.
nilaiProperti(Properti, Nilai):- tingkatanProperti(Properti, TingkatanProperti), TingkatanProperti=='Landmark', hargaProperti(Properti, HargaTanah, HargaBangunan1, HargaBangunan2, HargaBangunan3, HargaLandmark), Nilai = (HargaTanah + HargaBangunan1 + HargaBangunan2 + HargaBangunan3 + HargaLandmark), !.

/*biayaAkuisisiProperti(Properti, BiayaAkuisisi): BiayaAkuisisi adalah biaya akuisisi dari Properti saat ini*/
biayaAkuisisiProperti(Properti, BiayaAkuisisi):- \+ landmark(Properti), nilaiProperti(Properti, Nilai), BiayaAkuisisi = Nilai*2, !.
biayaAkuisisiProperti(_Properti, BiayaAkuisisi):- BiayaAkuisisi is 'tidak bisa diakuisisi', !.

/*tingkatanProperti(Properti, TingkatanProperti): TingkatanProperti adalah tingkatan properti dari Properti saat ini*/
tingkatanProperti(Properti, TingkatanProperti):- tingkatanAset(Properti, TingkatanAset), TingkatanProperti = TingkatanAset.


/*checkLocationDetail(X): Menampilkan detail lokasi X*/
checkLocationDetail(X):- properti(X), kepemilikanProperti(X,Pemilik),
    write('Nama Lokasi         : '), idProperti(X, NamaProperti, _), write(NamaProperti), nl,
    write('Deskripsi Lokasi    : '), idProperti(X, _, DeskripsiProperti), write(DeskripsiProperti), nl,nl,

    write('Kepemilikan         : '), write(Pemilik), nl,
    write('Biaya Sewa Saat Ini : '), biayaSewaProperti(X, BiayaSewa), write(BiayaSewa), nl,
    write('Biaya Akuisisi      : '), biayaAkuisisiProperti(X, BiayaAkuisisi), Biaya = BiayaAkuisisi, write(Biaya), nl,
    write('Tingkatan Properti  : '), tingkatanProperti(X, TingkatanProperti), write(TingkatanProperti), nl, !.

checkLocationDetail(X):- properti(X),
    write('Nama Lokasi         : '), idProperti(X, NamaProperti, _), write(NamaProperti), nl,
    write('Deskripsi Lokasi    : '), idProperti(X, _, DeskripsiProperti), write(DeskripsiProperti), nl,nl,

    write('Kepemilikan         : Tidak ada'), nl,
    write('Biaya Sewa Saat Ini : 0'), nl,
    write('Biaya Akuisisi      : 0'), nl,
    write('Tingkatan Properti  : Tanah'), nl, !.

checkLocationDetail(X):- lokasi(X), X=='go', 
    write('Nama Lokasi         : '), write('GO'), nl,
    write('Deskripsi Lokasi    : '), nl,
    write('Pemain mendapatkan uang sebanyak 200$ ketika menginjak atau melewati daerah ini.'), nl,
    write('Pemain juga dapat meningkatkan properti miliknya saat menginjak daerah ini.'), nl, !.

checkLocationDetail(X):- lokasi(X), (X =='cc1' ; X == 'cc2' ; X = 'cc3'), 
    write('Nama Lokasi         : '), write('Chance Card'), nl,
    write('Deskripsi Lokasi    : '), nl,
    write('Pemain mendapatkan kartu tertentu secara acak apabila menginjak daerah ini.'), nl,
    write('Jenis Kartu: '), nl,
    write('1. Kartu Keluar Jail   : Pemain dapat menggunakan kartu ini saat berada di dalam penjara untuk'), nl,
    write('                        langsung keluar tanpa menunggu tiga kali giliran atau membayar denda.'), nl,
    write('2. Kartu Hadiah        : Pemain langsung mendapatkan uang berdasarkan nilai yang tertera pada kartu tersebut.'), nl,
    write('                        Nilainya dapat diacak dan nominalnya dibebaskan selama tidak merusak flow permainan (balanced).'), nl,
    write('3. Kartu Game Center   : Pemain akan langsung pindah ke tempat Tax berikutnya (terdekat) dan langsung dikenai pajak.'), nl,
    write('4. Kartu Go            : Pemain akan langsung pindah ke GO'), nl,
    write('5. Kartu World Tour    : Pemain akan langsung pindah ke World Tour dan dapat berkeliling dunia.'), nl,
    write('6. Kartu Sakti         : Pemain dapat menggunakan kartu ini saat berada di properti lawan dan akan membayar biaya sewa secara gratis.'), nl,
    write('7. Kartu World Cup     : Pemain akan langsung pindah ke World'), nl,
    write('8. Kartu Tax           : Pemain akan langsung pindah ke tempat Tax berikutnya (terdekat) dan langsung dikenai pajak.'), nl,
    write('9. Kartu Go To Jail    : Pemain langsung ditransportasi ke lokasi Penjara dan dipenjara. Permainan dilanjutkan oleh pemain selanjutnya.'), nl,
    write('10. Kartu Free Parking : Pemain langsung ditransportasi ke free parking.'), nl,
    write('11. Kartu Terpalak     : Saldo Pemain dikurangkan sejumlah nominal acak.'), nl,
    write('12. Kartu Beri Saldo   : Saldo Pemain dikurangkan sejumlah nominal acak dan Saldo tersebut diberikan ke pemain lawan.'), nl,
    write('13. Kartu Sita Properti: Properti Pemain disita jika properti tersebut bukan landmark.'), nl,
    write('14. Kartu Jual Properti: Properti Pemain dijual paksa dan mendapatkan Saldo senilai 80% dari nilai asli.'), nl, !.

checkLocationDetail(X):- lokasi(X), X=='jl', 
    write('Nama Lokasi         : '), write('Jail'), nl,
    write('Deskripsi Lokasi    : '), nl,
    write('Pemain akan masuk penjara apabila pemain mendapatkan kartu masuk penjara atau mendapatkan double 3 kali berturut-turut.'), nl, 
    write('Pemain akan langsung dipindahkan ke “jail” dan akan diberi kesempatan untuk bermain dadu selama tiga kali giliran.'), nl, nl,
    write('Terdapat 4 mekanisme sebagai berikut untuk keluar dari penjara:'), nl,
    write('1. Apabila terdapat dadu yang double sebelum tiga kali giliran, pemain langsung keluar dari penjara.'), nl,
    write('2. Apabila pemain sudah melempar dadu sebanyak tiga kali, pemain keluar dari penjara.'), nl,
    write('3. Pemain mempunyai kartu untuk lolos dari penjara. Pada giliran berikutnya, pemain dapat memilih untuk mengaktifkannya.'), nl,
    write('4. Pemain dapat membayar pada giliran berikutnya sehingga lolos dari penjara lalu dapat langsung melempar dadu.'), nl, !.

checkLocationDetail(X):- lokasi(X), X=='fp', 
    write('Nama Lokasi         : '), write('Free Parking'), nl,
    write('Deskripsi Lokasi    : '), nl,
    write('Pemain yang menginjak daerah ini tidak mendapatkan efek apa-apa. Pemain dapat melakukan giliran setelahnya seperti biasa.'), nl, !.

checkLocationDetail(X):- lokasi(X), X=='wt', 
    write('Nama Lokasi         : '), write('World Tour'),nl,
    write('Deskripsi Lokasi    : '), nl,
    write('Bila pemain mendarat di kotak ini, pemain akan diberikan kesempatan untuk berpindah ke lokasi manapun di map kecuali kotak World Tour.'), nl,
    write('Perpindahan pemain tidak menggunakan konsep teleport (langsung berpindah dari kotak World Tour ke kotak tujuan akhir) melainkan berjalan'), nl,
    write('melewati kotak-kotak lainnya, pemain harus membayar 50$ untuk bisa berpindah'), nl.

checkLocationDetail(X):- lokasi(X), X =='tx', 
    write('Nama Lokasi         : '), write('Tax'), nl,
    write('Deskripsi Lokasi    : '), nl,
    write('Pemain yang mencapai daerah TX wajib membayar pajak sejumlah 10% dari total aset yang dimilikinya.'),nl, 
    write('Aset tersebut termasuk uang yang dimiliki dan semua nilai aset properti yang dimiliki.'), nl.

checkLocationDetail(X):- lokasi(X), X =='gc', 
    write('Nama Lokasi         : '),  write('Game Center'), nl,
    write('Deskripsi Lokasi    : '), nl,
    write('Pemain bisa memilih untuk bermain di game center atau tidak jika menginjak tile ini.'), nl,
    write('Permainan di game center ini adalah menebak sisi yang akan muncul dari koin yang dilempar.'), nl,
    write('Jika pemain memilih untuk bermain, ia harus membayar $50 untuk memulai permainan.'), nl,
    write('Permainan berakhir jika pemain salah menebak sisi koin, pemain berhasil menebak dengan benar 3 kali,'), nl,
    write('atau pemain memilih untuk berhenti bermain dan mengklaim hadiahnya.'), nl,
    write('Jika pemain berhasil menebak dengan benar, tetapi pada saat tebakan selanjutnya ia salah,'), nl,
    write('hadiah yang telah dikumpulkan sebelumnya menjadi 0.'), nl, nl, 

    write('Rincian Hadiah: '), nl,
    write('Hadiah1 : Jika berhasil menebak dengan benar satu kali ($150)'), nl,
    write('Hadiah2 : Jika berhasil menebak dengan benar dua kali ($300)'), nl,
    write('Hadiah3 : Jika berhasil menebak dengan benar tiga kali ($500)'),nl, !.

checkLocationDetail(X):- lokasi(X), X=='wc', 
    write('Nama Lokasi         : '), write('Free Parking'), nl,
    write('Deskripsi Lokasi    : '), nl, !. % Tambahin deskripsi di newline

checkLocationDetail(X):- write(X), write(' bukan merupakan lokasi yang valid'), nl, fail.


/* Properti */

/*Deklarasi Fakta*/
/*landmark(X): X adalah sebuah landmark*/
:- dynamic(landmark/1).
/*properti(X): X adalah sebuah properti */
properti(a1).
properti(a2).
properti(b1).
properti(b2).
properti(b3).
properti(c1).
properti(c2).
properti(c3).
properti(d1).
properti(d2).
properti(d3).
properti(e1).
properti(e2).
properti(f1).
properti(f2).
properti(f3).
properti(g1).
properti(g2).
properti(g3).
properti(h1).
properti(h2).

/* idProperti(Properti, NamaProperti, DeskripsiProperti) : Fakta tentang identitas dari Properti*/
idProperti(a1, 'Jakarta', 'Ibukota Indonesia').
idProperti(a2, 'Kuala Lumpur', 'Ibukota Malaysia').
idProperti(b1, 'Dhaka', 'Ibukota Bangladesh').
idProperti(b2, 'Islamabad', 'Ibukota Pakistan').
idProperti(b3, 'New Delhi', 'Ibukota India').
idProperti(c1, 'Beijing', 'Ibukota China').
idProperti(c2, 'Seoul', 'Ibukota Korea Selatan').
idProperti(c3, 'Tokyo', 'Ibukota Jepang').
idProperti(d1, 'Moskow', 'Ibukota Rusia').
idProperti(d2, 'Copenhagen', 'Ibukota Denmark').
idProperti(d3, 'Stockholm', 'Ibukota Swedia').
idProperti(e1, 'Berlin', 'Ibukota Jerman').
idProperti(e2, 'Paris', 'Ibukota Prancis').
idProperti(f1, 'Roma', 'Ibukota Italia').
idProperti(f2, 'Madrid', 'Ibukota Spanyol').
idProperti(f3, 'Lisbon', 'Ibukota Portugal').
idProperti(g1, 'Mexico City', 'Ibukota Meksiko').
idProperti(g2, 'Ottawa', 'Ibukota Kanada').
idProperti(g3, 'Brasilia', 'Ibukota Brazil').
idProperti(h1, 'Athena', 'Ibukota Yunani').
idProperti(h2, 'Kairo', 'Ibukota Mesir').

/* hargaProperti(Properti, HargaTanah, HargaBangunan1, HargaBangunan2, HargaBangunan3, HargaLandmark): Fakta tentang harga pada Properti*/
hargaProperti(a1, 50, 100, 150, 200, 250).
hargaProperti(a2, 60, 110, 160, 210, 260).
hargaProperti(b1, 100, 150, 200, 250, 300).
hargaProperti(b2, 100, 150, 200, 250, 300).
hargaProperti(b3, 120, 170, 220, 270, 320).
hargaProperti(c1, 150, 250, 350, 450, 550).
hargaProperti(c2, 150, 250, 350, 450, 550).
hargaProperti(c3, 180, 280, 380, 480, 580).
hargaProperti(d1, 200, 300, 400, 500, 600).
hargaProperti(d2, 200, 300, 400, 500, 600).
hargaProperti(d3, 220, 320, 420, 520, 620).
hargaProperti(e1, 220, 370, 520, 670, 820).
hargaProperti(e2, 240, 390, 540, 690, 840).
hargaProperti(f1, 280, 430, 580, 730, 880).
hargaProperti(f2, 280, 430, 580, 730, 880).
hargaProperti(f3, 300, 450, 600, 750, 900).
hargaProperti(g1, 300, 500, 700, 900, 1100).
hargaProperti(g2, 300, 500, 700, 900, 1100).
hargaProperti(g3, 320, 520, 720, 920, 1120).
hargaProperti(h1, 360, 560, 760, 960, 1160).
hargaProperti(h2, 400, 600, 800, 1000, 1200).

/* hargaSewaProperti(Properti, HargaSewaTanah, HargaSewaBangunan1, HargaSewaBangunan2, HargaSewaBangunan3, HargaSewaLandmark): Fakta tentang harga hargaSewa pada Properti*/
hargaSewaProperti(a1, 5, 18, 30, 90, 250).
hargaSewaProperti(a2, 10, 30, 60, 180, 450).
hargaSewaProperti(b1, 10, 40, 90, 270, 550).
hargaSewaProperti(b2, 10, 40, 90, 270, 550).
hargaSewaProperti(b3, 16, 50, 100, 300, 600).
hargaSewaProperti(c1, 16, 50, 150, 450, 750).
hargaSewaProperti(c2, 16, 50, 150, 450, 750).
hargaSewaProperti(c3, 20, 60, 180, 500, 900).
hargaSewaProperti(d1, 20, 70, 200, 550, 950).
hargaSewaProperti(d2, 20, 70, 200, 550, 950).
hargaSewaProperti(d3, 30, 80, 220, 600, 1000).
hargaSewaProperti(e1, 30, 90, 250, 700, 1050).
hargaSewaProperti(e2, 40, 100, 300, 750, 1100).
hargaSewaProperti(f1, 40, 110, 330, 800, 1150).
hargaSewaProperti(f2, 40, 110, 330, 800, 1150).
hargaSewaProperti(f3, 50, 120, 360, 850, 1200).
hargaSewaProperti(g1, 50, 130, 390, 900, 1275).
hargaSewaProperti(g2, 50, 130, 390, 900, 1275).
hargaSewaProperti(g3, 60, 150, 450, 1000, 1400).
hargaSewaProperti(h1, 60, 175, 500, 1100, 1500).
hargaSewaProperti(h2, 80, 200, 600, 1400, 2000).

/*Deklarasi Rules*/

/*checkPropertyDetail(X): Menampilkan detail dari suatu properti*/
checkPropertyDetail(X):- properti(X), 
    write('Nama Properti         : '), idProperti(X, NamaProperti, _), write(NamaProperti), nl,
    write('Deskripsi Properti    : '), idProperti(X, _, DeskripsiProperti), write(DeskripsiProperti), nl,nl,
    
    write('Harga Tanah           : '), hargaProperti(X, HargaTanah, _, _, _, _) , write(HargaTanah), nl,
    write('Harga Bangunan 1      : '), hargaProperti(X, _, HargaBangunan1, _, _, _) , write(HargaBangunan1), nl,
    write('Harga Bangunan 2      : '), hargaProperti(X, _, _, HargaBangunan2, _, _) , write(HargaBangunan2), nl,
    write('Harga Bangunan 3      : '), hargaProperti(X, _, _, _, HargaBangunan3, _) , write(HargaBangunan3), nl,
    write('Harga Landmark        : '), hargaProperti(X, _, _, _, _, HargaLandmark) , write(HargaLandmark), nl,nl,

    write('Harga Sewa Tanah      : '), hargaSewaProperti(X, HargaSewaTanah, _, _, _, _) , write(HargaSewaTanah), nl,
    write('Harga Sewa Bangunan 1 : '), hargaSewaProperti(X, _, HargaSewaBangunan1, _, _, _) , write(HargaSewaBangunan1), nl,
    write('Harga Sewa Bangunan 2 : '), hargaSewaProperti(X, _, _, HargaSewaBangunan2, _, _) , write(HargaSewaBangunan2), nl,
    write('Harga Sewa Bangunan 3 : '), hargaSewaProperti(X, _, _, _, HargaSewaBangunan3, _) , write(HargaSewaBangunan3), nl,
    write('Harga Sewa Landmark   : '), hargaSewaProperti(X, _, _, _, _, HargaSewaLandmark) , write(HargaSewaLandmark), nl, !.

checkPropertyDetail(X):- write(X), write(' bukan merupakan sebuah properti'), nl.


/*ambilAlihProperti(Properti, PemilikLama, PemilikBaru) */
ambilAlihProperti(Properti, PemilikLama, PemilikBaru) :-  
        tingkatanProperti(Properti, TingkatanProperti), biayaAkuisisiProperti(Properti, BiayaAkuisisi), 
        subtBalance(PemilikBaru, BiayaAkuisisi), addBalance(PemilikLama, BiayaAkuisisi), % transfer duit
        removePosession(PemilikLama, Properti), addPosession(PemilikBaru, Properti, TingkatanProperti). % transfer kepemilikan
    

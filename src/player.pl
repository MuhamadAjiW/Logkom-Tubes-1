/*DEPENDENCY KE lokasinproperti.pl*/


/*
TODO
-Tambahin angel card waktu move
-Tambahin aksi landing waktu move
-Integrasiin fitur dari non properti
*/


/*DATA Pemain*/

/*Current pemain*/
:-dynamic(currentPemain/1).
currentPemain(p1).
/*predikat pemain*/
pemain(p1).
pemain(p2).
/*data lokasiPemain*/
:-dynamic(lokasiPemain/2).
lokasiPemain(p1, go).
lokasiPemain(p2, go).
/*data duit*/
:-dynamic(balance/2).
balance(p1, 300).
balance(p2, 300).
/*data kondisi bangkrut*/
:-dynamic(bangkrut/2).
bangkrut(p1, false).
bangkrut(p2, false).
/*data properti*/
:-dynamic(asetProperti/2).
:-dynamic(tingkatanAset/2).
/*data properti yang dimiliki dalam array*/
    /*ini perlu buat ngitung asset, susah rekursinya kalo gak pake array*/
:-dynamic(posessionArr/2).
/*posessionArr(p1, []).*/
/*posessionArr(p2, []).*/
:-dynamic(lewatGO/2).
lewatGO(p1, 0).
lewatGO(p2, 0).



/*TEMP untuk debugging*/
asetProperti(p1, d1).
asetProperti(p2, a2).
asetProperti(p1, a1).
asetProperti(p2, g1).
asetProperti(p2, b2).
asetProperti(p2, b3).

tingkatanAset(d1, 'Tanah').
tingkatanAset(a2, 'Tanah').
tingkatanAset(a1, 'Tanah').

tingkatanAset(g1, 'Tanah').
tingkatanAset(b2, 'Tanah').
tingkatanAset(b3, 'Tanah').
posessionArr(p1, [d1,a1]).
posessionArr(p2, [g1,b2,b3,a2]).


/*AKHIR TEMP*/


/*Basic-----------------------------------------------*/
changeBalance(Pemain, New):-
    /*ganti duit direct*/
    pemain(Pemain),
    retract(balance(Pemain, _X)),
    asserta(balance(Pemain, New)).
addBalance(Pemain, Amount):-
    /*ganti duit ditambahin*/
    pemain(Pemain),
    balance(Pemain, Old),
    New is Old + Amount,
    changeBalance(Pemain, New).
subtBalance(Pemain, Amount):-
    /*ganti duit dikurangin*/
    pemain(Pemain),
    balance(Pemain, Old),
    New is Old - Amount,
    changeBalance(Pemain, New).

changeLokasiPemain(Pemain, New):-
    /*ganti lokasi direct*/
    pemain(Pemain),
    retract(lokasiPemain(Pemain, _X)),
    asserta(lokasiPemain(Pemain, New)).

changePlayerDirect(X):-
    /*ganti player secara direct*/
    retract(currentPemain(_)),
    asserta(currentPemain(X)).

switchPlayer:-
    /*ganti player selang seling*/
    currentPemain(X),
    X == p1,
    retract(currentPemain(_)),
    asserta(currentPemain(p2)).
switchPlayer:-
    /*ganti player selang seling*/
    currentPemain(X),
    X == p2,
    retract(currentPemain(_)),
    asserta(currentPemain(p1)).


/*ganti lokasiPemain dari nilai integer*/
inNextLocations(_Pemain, H, [H|T], T).
    /*rekursif untuk basis jika Head = Lokasi*/
inNextLocations(Pemain, LokasiPemain, [_H|T], X):-
    /*rekursif untuk basis jika Head != Lokasi*/
    inNextLocations(Pemain, LokasiPemain, T, X).
nextLocations(Pemain, Output):-
    /*rekursif untuk nyari array elemen selanjutnya di array berdasarkan posisi sekarang*/
    lokasiPemain(Pemain, X),
    listLokasi(ListLokasi),
    inNextLocations(Pemain, X, ListLokasi, Output).

/*Check tempat landing buat move, masukin command sesuai keperluan*/
/*Non Properti*/
landingJail(Pemain):-
    1 = 1.
landingCC(Pemain):-
    1 = 1.
landingWT(Pemain):-
    1 = 1.
landingTX(Pemain):-
    1 = 1.
landingGC(Pemain):-
    write('Apakah kamu ingin menguji keberuntunganmu??? (Masukkan angka: )'),
    write('1. Ya'), nl,
    write('2. Tidak'), nl,
    write('Pilihan: '), read(Pilihan),
    currentPemain(Pemain),
    (
        Pilihan == 1, subtBalance(Pemain,50), playGameCenter
        ;
        Pilihan == 2 
    ),
    write('===Terima Kasih Telah Berkunjung ke Game Center===').

landingNonProperti(Pemain):-
    /*detektor mendarat player di non properti*/
    lokasiPemain(Pemain, Lokasi),
    (
        Lokasi == jl,
        nl , write('Masuk penjara'), nl, nl,
        landingJail(Pemain)
        ;
        (Lokasi == cc1;Lokasi == cc2;Lokasi == cc3),
        nl , write('Masuk chance card'), nl, nl,
        landingCC(Pemain)
        ;
        (Lokasi == tx1;Lokasi == tx2),
        nl , write('Masuk pajak'), nl, nl,
        landingTX(Pemain)
        ;
        Lokasi == wt,
        nl , write('Masuk world tour'), nl, nl,
        landingWT(Pemain)
        ;
        lokasi == gc,
        nl, write('====SELAMAT DATANG DI GAME CENTER==='), nl, nl,
        landingGC(Pemain)
    ).

/* Properti */
landingPropertiLawan(Pemain):-
    /*aksi jika player mendarat di properti selain sendiri*/
    currentPemain(Pemain),
    biayaSewaProperti(Lokasi, BiayaSewa),
    (
        card(Pemain, 6), 
        write('Apakah kamu ingin menggunakan Angel Card?[y/n]'), nl,
        read(Answer),
        (
            Answer == y, subtBalance(Pemain, BiayaSewa), write('Berhasil mengaktifkan Angel Card'), nl, nl, retract(card(Pemain, 6)), !
            ;
            Answer == n, subtBalance(Pemain, BiayaSewa), asetProperti(PemainLawan, Lokasi) ,addBalance(PemainLawan, BiayaSewa), write('Biaya sewa properti berhasil dibayar'), !
            ;
            Answer \= y, Answer \= n, write('Input tidak valid'), nl, nl, landingPropertiLawan(Pemain), !
        )
        ;
        subtBalance(Pemain, BiayaSewa),
        balance(Pemain, Uang), 
    ),

    (Uang >= 0, write('Ambil Alih?(ya/tidak) '), read(AmbilAlih),
        (
            AmbilAlih == ya, biayaAkuisisiProperti(Lokasi, BiayaAkuisisi), 
                (
                    (Uang-BiayaAkuisisi)>= 0, asetProperti(PemilikLama, Lokasi), ambilAlihProperti(Lokasi, PemilikLama, Pemain), landingPropertiSendiri(Pemain)
                    ;
                    write('Kurang $'), Kekurangan is (BiayaAkuisisi - Uang), write(Kekurangan), write('Bos! Gaya Elit, Ekonomi Sulid') 
                )
            ;
            AmbilAlih == tidak
        )
        ;
        checkBangkrut(Pemain) 
    ).
landingPropertiSendiri(Pemain):-
    /*aksi jika player mendarat di properti sendiri*/
    balance(Pemain, Uang),
    lokasiPemain(Pemain, Lokasi),
    tingkatanAset(Lokasi, CurrentTingkat),
    (
        CurrentTingkat == 'Landmark',!
        ;
        repeat,
            printMap,
            write('Sekarang giliran: '), write(Pemain), nl,
            write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,
            nl , write('Mau menambah properti?'), nl, nl,
            write('Aksi: '),
            read(Input),
            (
                Input == help,
                nl, write('Perintah yang tersedia'), nl,
                write('tambah.: Menambah properti'), nl,
                write('    landmark dapat dibeli setelah dua putaran'), nl,
                write('tidak.: tidak menambah properti'), nl, fail
                ;
                Input == tidak,
                write('Properti tidak ditambah'), nl
                ;
                Input == tambah,
                (repeat, 
                    lokasiPemain(Pemain, LokasiBeli),
                    checkPropertyDetail(LokasiBeli),

                    nl, write('Uang Anda: '), write(Uang), nl,
                    write('Properti yang mau dibeli: '),
                
                    read(InputPilihan),
                    (
                        InputPilihan == help,
                        nl, write('Perintah yang tersedia'), nl,
                        write('bangunan1.: beli Bangunan1'), nl,
                        write('bangunan2.: beli Bangunan2'), nl,
                        write('bangunan3.: beli Bangunan3'), nl,
                        write('landmark.: beli Landmark'), nl,
                        write('cancel.: tidak jadi membeli properti'), nl, nl, fail
                        ;
                        InputPilihan == tanah,
                        write('Kamu sudah memiliki tingkatan bangunan ini'), nl, fail
                        ;
                        InputPilihan == bangunan1,
                            (CurrentTingkat == 'Tanah',
                            hargaProperti(LokasiBeli,_, HargaBeli,_,_,_),
                            (
                                Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                                ;
                                write('Bangunan1 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                                subtBalance(Pemain, HargaBeli),
                                removePosession(Pemain, LokasiBeli),
                                addPosession(Pemain, LokasiBeli, 'Bangunan1')
                            )
                            ;
                            write('Kamu sudah memiliki tingkatan bangunan ini'), nl, fail
                            )
                        ;
                        InputPilihan == bangunan2,
                        hargaProperti(LokasiBeli,_, _, HargaBeli,_,_),
                            ((CurrentTingkat == 'Tanah' ; CurrentTingkat == 'Bangunan1'),
                            (
                                Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                                ;
                                write('Bangunan2 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                                subtBalance(Pemain, HargaBeli),
                                removePosession(Pemain, LokasiBeli),
                                addPosession(Pemain, LokasiBeli, 'Bangunan2')
                            )
                            ;
                            write('Kamu sudah memiliki tingkatan bangunan ini'), nl, fail
                            )
                        ;
                        InputPilihan == bangunan3,
                        hargaProperti(LokasiBeli,_, _,_, HargaBeli,_),
                            ((CurrentTingkat == 'Tanah' ; CurrentTingkat == 'Bangunan1' ; CurrentTingkat == 'Bangunan2'),
                            (
                                Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                                ;
                                write('Bangunan3 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                                subtBalance(Pemain, HargaBeli),
                                removePosession(Pemain, LokasiBeli),
                                addPosession(Pemain, LokasiBeli, 'Bangunan3')
                            )
                            ;
                            write('Kamu sudah memiliki tingkatan bangunan ini'), nl, fail
                            )
                        ;
                        InputPilihan == landmark,
                        hargaProperti(LokasiBeli,_, _, _,_, HargaBeli),
                        (
                            (
                            lewatGO(Pemain, KaliLewat2),
                            KaliLewat2 > 1,(
                                Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                                ;
                                write('Landmark berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                                subtBalance(Pemain, HargaBeli),
                                removePosession(Pemain, LokasiBeli),
                                addPosession(Pemain, LokasiBeli, 'Landmark')
                            )
                            ;
                            write('landmark belum bisa dibeli'), nl, fail
                            )
                        )
                        ;
                        InputPilihan == cancel
                        ;
                        InputPilihan \= help,
                        write('Input tidak valid'), nl, nl, fail
                    )    
                )
                ;
                Input \= help,
                write('Input tidak valid'), nl, nl, fail
            )
    )
    .
landingPropertiKosong(Pemain):-
    /*aksi jika player mendarat di properti kosong*/
    printMap,
    write('Sekarang giliran: '), write(Pemain), nl,
    write('Tulis \'help.\' untuk memberikan daftar perintah yang tersedia'), nl, nl,

    balance(Pemain, Uang),
    nl , write('Mau beli?'), nl, nl,
    write('Aksi: '),
    read(Input),

    (
        Input == help,
        nl, write('Perintah yang tersedia'), nl,
        write('beli.: beli properti'), nl,
        write('    landmark dapat dibeli setelah dua putaran'), nl,
        write('tidak.: tidak membeli properti'), nl, nl,
        landingPropertiKosong(Pemain)
        ;
        Input == tidak,
        write('Properti tidak dibeli'), nl
        ;
        Input == beli,
        (repeat, 
            lokasiPemain(Pemain, LokasiBeli),
            checkPropertyDetail(LokasiBeli),

            nl, write('Uang Anda: '), write(Uang), nl,
            write('Properti yang mau dibeli: '),
        
            read(InputPilihan),
            (
                InputPilihan == help,
                nl, write('Perintah yang tersedia'), nl,
                write('tanah.: beli Tanah'), nl,
                write('bangunan1.: beli Bangunan1'), nl,
                write('bangunan2.: beli Bangunan2'), nl,
                write('bangunan3.: beli Bangunan3'), nl,
                write('landmark.: beli Landmark'), nl,
                write('cancel.: tidak jadi membeli properti'), nl, nl, fail
                ;
                InputPilihan == tanah,
                hargaProperti(LokasiBeli, HargaBeli, _,_,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Tanah berhasil dibeli! '), nl, 
                    idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli),
                    addPosession(Pemain, LokasiBeli, 'Tanah')
                )
                ;
                InputPilihan == bangunan1,
                hargaProperti(LokasiBeli,_, HargaBeli,_,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan1 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli),
                    addPosession(Pemain, LokasiBeli, 'Bangunan1')
                )
                ;
                InputPilihan == bangunan2,
                hargaProperti(LokasiBeli,_, _, HargaBeli,_,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan2 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli),
                    addPosession(Pemain, LokasiBeli, 'Bangunan2')
                )
                ;
                InputPilihan == bangunan3,
                hargaProperti(LokasiBeli,_, _,_, HargaBeli,_),
                (
                    Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                    ;
                    write('Bangunan3 berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                    subtBalance(Pemain, HargaBeli),
                    addPosession(Pemain, LokasiBeli, 'Bangunan3')
                )
                ;
                InputPilihan == landmark,
                hargaProperti(LokasiBeli,_, _, _,_, HargaBeli),
                (
                    lewatGO(Pemain, KaliLewat2),
                    KaliLewat2 > 1,(
                        Uang < HargaBeli, write('Yahh... Uangmu tidak Cukup :('), write('Uangmu kurang $'), write(HargaBeli-Uang), write('lagi!') ,fail
                        ;
                        write('Landmark berhasil dibeli! '), nl, idProperti(LokasiBeli, NamaPropertiBeli, _),  write(NamaPropertiBeli),write(' Sekarang menjadi milikmu'), nl,
                        subtBalance(Pemain, HargaBeli),
                        addPosession(Pemain, LokasiBeli, 'Landmark')
                    )
                    ;
                    write('landmark belum bisa dibeli'), nl,
                    landingPropertiKosong(Pemain),fail
                )
                ;
                InputPilihan == cancel
                ;
                InputPilihan \= help,
                write('Input tidak valid'), nl, nl, fail
            )    
        )
        ;
        Input \= help,
        write('Input tidak valid'), nl, nl,
        landingPropertiKosong(Pemain)
    ).

landingProperti(Pemain):-
    /*detektor mendarat player di properti*/
    lokasiPemain(Pemain, Lokasi),
    (
        \+ asetProperti(_Siapapun, Lokasi),
        nl , write('Properti kosong'), nl, nl,
        landingPropertiKosong(Pemain)
        ;
        asetProperti(Pemain, Lokasi),
        nl , write('Properti milik sendiri'), nl, nl,
        landingPropertiSendiri(Pemain)
        ;
        asetProperti(Pemainlain, Lokasi),
        Pemainlain \= Pemain,
        nl , write('Properti milik orang lain'), nl, nl,
        landingPropertiLawan(Pemain)
    ).

checkLokasi(Pemain):-
    /*detektor mendarat player di properti atau non*/
    lokasiPemain(Pemain, Lokasi),
    
    (
        properti(Lokasi),
        nl , write('Properti'), nl, nl,
        landingProperti(Pemain)
        ;
        nl, write('Bukan Properti'), nl, nl,
        landingNonProperti(Pemain)
    ).


/*Move*/
inMove(Pemain, X, []):-
    /*rekursif untuk list supaya sirkuler*/
    addBalance(Pemain, 200),
    balance(Pemain, Uang),

    nl, write(Pemain), write(" melewati go, uangmu sekarang, "), write(Uang), nl, nl,

    lewatGO(Pemain, KaliLewat),
    KaliLewatBaru is KaliLewat + 1,

    retract(lewatGO(Pemain, _)),
    asserta(lewatGO(Pemain, KaliLewatBaru)),
    
    listLokasi(ListLokasi),
    inMove(Pemain, X, ListLokasi).
inMove(Pemain, 1, [H|_T]):-
    /*rekursif untuk basis jika nilai integernya 1*/
    changeLokasiPemain(Pemain, H),!.
    
inMove(Pemain, X, [_H|T]):-
    /*rekursif untuk basis jika nilai integernya bukan 1*/
    A is X-1,
    inMove(Pemain, A, T).
move(Pemain, X):-
    /*ganti lokasi dari nilai integer*/
    listLokasi(ListLokasi),
    lokasiPemain(Pemain, Lokasi),
    inNextLocations(Pemain, Lokasi, ListLokasi, Output),
    inMove(Pemain, X, Output),!.

/*properti----------------------------------------------*/
addPosession(Pemain, Properti, Level):-
    /*nambahin posession di paling depan*/
    \+ asetProperti(Pemain, Properti),
    properti(Properti),
    posessionArr(Pemain, OldArr),
    retract(posessionArr(Pemain, _X)),

    asserta(asetProperti(Pemain, Properti)),
    asserta(tingkatanAset(Properti, Level)),
    
    asserta(posessionArr(Pemain, [Properti|OldArr])),!.

addPosession(_Pemain, _Properti, _Level):-
    write('Properti tidak valid'), nl.

inRemovePosession(_Pemain, Properti, [Properti|T], T).
    /*rekursif buat basis ngeluarin properti dari posession*/
inRemovePosession(Pemain, Properti, [H|T], [H|Next]):-
    /*rekursif buat ngeluarin properti dari posession*/
    inRemovePosession(Pemain, Properti, T, Next).

removePosession(Pemain, Properti):-
    /*ngeluarin properti dari posession*/
    asetProperti(Pemain, Properti),
    posessionArr(Pemain, OldArr),
    inRemovePosession(Pemain, Properti, OldArr, NewArr),
    
    retract(asetProperti(Pemain, Properti)),
    retract(tingkatanAset(Properti, _X)),

    retract(posessionArr(Pemain, _Arr)),
    asserta(posessionArr(Pemain, NewArr)),!.

removePosession(_Pemain, _Properti):-
    write('Properti tidak valid'), nl.


sellProperti(Pemain, Properti):-
    /*ngejual properti dari posession dengan harga 80%*/
    asetProperti(Pemain, Properti),
    nilaiProperti(Properti, Nilai),
    HargaJual is Nilai*80/100,
    addBalance(Pemain, HargaJual),
    removePosession(Pemain, Properti),!.

sellProperti(_Pemain, _Properti):-
    /*kalo properti tidak dimiliki*/
    write('Properti tidak valid'), nl.


inJumlahAsset(_Pemain, 0, []).
inJumlahAsset(Pemain, X, [H|T]):-
    /*rekursif untuk ngitung jumlah asset*/
    nilaiProperti(H, Nilai),
    inJumlahAsset(Pemain, A, T),
    X is Nilai + A,!.
jumlahAsset(Pemain, Output):-
    /*ngitung jumlah asset*/
    posessionArr(Pemain, PossArr),
    inJumlahAsset(Pemain, Output, PossArr).
totalAsset(Pemain, Output):-
    /*ngitung asset + balance*/
    jumlahAsset(Pemain, Asset),
    balance(Pemain, Uang),
    Output is Asset + Uang.

inShowProperties(_Pemain, _X, []).
inShowProperties(Pemain, X, [H|T]):-
    /*rekursif show properties*/
    tingkatanAset(H, Tingkat),
    write(X), write('. '), write(H), write(' - '), write(Tingkat),nl,
    A is X + 1,
    inShowProperties(Pemain, A, T).
showProperties(Pemain):-
    /*print properti yang dimiliki player dalam bentuk daftar*/
    posessionArr(Pemain, PossArr),
    inShowProperties(Pemain, 1, PossArr),!.

checkPlayerDetail(Pemain):-
    /*print informasi player*/
    pemain(Pemain),
    lokasiPemain(Pemain, Lokasi),
    balance(Pemain, Uang),
    jumlahAsset(Pemain, Asset),
    totalAsset(Pemain, Total),

    nl, write('Informasi '), write(Pemain), nl, nl,

    write('Lokasi                        : ' ), write(Lokasi), nl,
    write('Total Uang                    : ' ), write(Uang), nl,
    write('Total Nilai Properti          : ' ), write(Asset),nl,
    write('Total Aset                    : '), write(Total),nl,nl,

    write('Daftar Kepemilikan Properti   : ' ),nl,
    showProperties(Pemain),

    write('Daftar Kepemilikan Card       : '),nl.

    /*Masuk ke sini yang card*/

playerDetail(_Pemain):-
    write("Nama pemain tidak valid").



/*Bangkrut---------------------------------------------*/
checkBangkrut(Pemain):-
    /*bangkrut kalo duit < 0*/
    /*kalo asset masih bisa dijual bakal masuk resolve bangkrut*/
    balance(Pemain, X),
    (X < 0,

        jumlahAsset(Pemain, AssetValue),
        (AssetValue * 80/100 + X) < 0,

        nl,
        write('Pemain '), write(Pemain), write(' telah bangkrut'), nl,

        pemain(Pemainlain),
        Pemainlain \= Pemain,

        write('Pemenangnya adalah '), write(Pemainlain),nl,nl,
        write('Permainan telah berakhir, terima kasih telah bermain monopoli boku no prolog'),nl,

        write('panggil \'resetGame.\' untuk mereset kembali ke kondisi semula'),nl,

        retract(bangkrut(Pemain, _X)),
        asserta(bangkrut(Pemain, true)),!
    ;X < 0,
    
        jumlahAsset(Pemain, AssetValue),
        (AssetValue * 80/100 + X) >= 0,
        nl,
        write('Uangmu tidak mencukupi untuk membayar, kamu harus memilih properti untuk dijual'),nl,
        retract(bangkrut(Pemain, _X)),
        asserta(bangkrut(Pemain, true)),
        resolveBangkrut(Pemain)
    ;X >= 0).

resolveBangkrut(Pemain):-
    /*buat resolve kalo ada yang bangkrut*/
    balance(Pemain, Utang),nl,
    write('Utangmu senilai '), write(Utang), nl,
    write('properti yang kamu miliki adalah sebagai berikut'), nl,
    showProperties(Pemain),

    nl,write('atau tulis \'menyerah.\' jika tidak ingin melanjutkan permainan'), nl,
    write('Properti yang akan dijual: '),
    read(InputProperty),(
        InputProperty \= menyerah,
        sellProperti(Pemain, InputProperty),

        retract(bangkrut(Pemain, _X)),
        asserta(bangkrut(Pemain, false))
        ;
        InputProperty == menyerah,
        changeBalance(Pemain, -9999999999999999)
    ),
    checkBangkrut(Pemain),!.


resetGame:-
    /*buat retract semua fakta jadi kaya pas awal mulai*/
    retractall(bangkrut(_A, _B)),
    retractall(lokasiPemain(_C, _D)),
    retractall(bangkrut(_E, _F)),
    retractall(currentPemain(_G)),
    retractall(balance(_H, _I)),
    retractall(asetProperti(_K, _L)),
    retractall(tingkatanAset(_M, _N)),
    retractall(posessionArr(_O, _P)),
    retractall(lewatGO(_Q, _R)),

    asserta(currentPemain(p1)),
    asserta(lokasiPemain(p1, go)),
    asserta(lokasiPemain(p2, go)),
    asserta(balance(p1, 300)),
    asserta(balance(p2, 300)),
    asserta(bangkrut(p1, false)),
    asserta(bangkrut(p2, false)),
    asserta(lewatGO(p1, 0)),
    asserta(lewatGO(p1, 0)).




/*Blok---------------------------------------------*/
isBlock(a1):-
    pemain(Pemain),
    asetProperti(Pemain, a1),
    asetProperti(Pemain, a2).
isBlock(a2):-
    pemain(Pemain),
    asetProperti(Pemain, a1),
    asetProperti(Pemain, a2).
isBlock(b1):-
    pemain(Pemain),
    asetProperti(Pemain, b1),
    asetProperti(Pemain, b2),
    asetProperti(Pemain, b3).
isBlock(b2):-
    pemain(Pemain),
    asetProperti(Pemain, b1),
    asetProperti(Pemain, b2),
    asetProperti(Pemain, b3).
isBlock(b3):-
    pemain(Pemain),
    asetProperti(Pemain, b1),
    asetProperti(Pemain, b2),
    asetProperti(Pemain, b3).
isBlock(c1):-
    pemain(Pemain),
    asetProperti(Pemain, c1),
    asetProperti(Pemain, c2),
    asetProperti(Pemain, c3).
isBlock(c2):-
    pemain(Pemain),
    asetProperti(Pemain, c1),
    asetProperti(Pemain, c2),
    asetProperti(Pemain, c3).
isBlock(c3):-
    pemain(Pemain),
    asetProperti(Pemain, c1),
    asetProperti(Pemain, c2),
    asetProperti(Pemain, c3).
isBlock(d1):-
    pemain(Pemain),
    asetProperti(Pemain, d1),
    asetProperti(Pemain, d2),
    asetProperti(Pemain, d3).
isBlock(d2):-
    pemain(Pemain),
    asetProperti(Pemain, d1),
    asetProperti(Pemain, d2),
    asetProperti(Pemain, d3).
isBlock(d3):-
    pemain(Pemain),
    asetProperti(Pemain, d1),
    asetProperti(Pemain, d2),
    asetProperti(Pemain, d3).
isBlock(e1):-
    pemain(Pemain),
    asetProperti(Pemain, e1),
    asetProperti(Pemain, e2),
    asetProperti(Pemain, e3).
isBlock(e2):-
    pemain(Pemain),
    asetProperti(Pemain, e1),
    asetProperti(Pemain, e2),
    asetProperti(Pemain, e3).
isBlock(e3):-
    pemain(Pemain),
    asetProperti(Pemain, e1),
    asetProperti(Pemain, e2),
    asetProperti(Pemain, e3).
isBlock(f1):-
    pemain(Pemain),
    asetProperti(Pemain, f1),
    asetProperti(Pemain, f2),
    asetProperti(Pemain, f3).
isBlock(f2):-
    pemain(Pemain),
    asetProperti(Pemain, f1),
    asetProperti(Pemain, f2),
    asetProperti(Pemain, f3).
isBlock(f3):-
    pemain(Pemain),
    asetProperti(Pemain, f1),
    asetProperti(Pemain, f2),
    asetProperti(Pemain, f3).
isBlock(g1):-
    pemain(Pemain),
    asetProperti(Pemain, g1),
    asetProperti(Pemain, g2),
    asetProperti(Pemain, g3).
isBlock(g2):-
    pemain(Pemain),
    asetProperti(Pemain, g1),
    asetProperti(Pemain, g2),
    asetProperti(Pemain, g3).
isBlock(g3):-
    pemain(Pemain),
    asetProperti(Pemain, g1),
    asetProperti(Pemain, g2),
    asetProperti(Pemain, g3).
isBlock(h1):-
    pemain(Pemain),
    asetProperti(Pemain, h1),
    asetProperti(Pemain, h2).
isBlock(h2):-
    pemain(Pemain),
    asetProperti(Pemain, h1),
    asetProperti(Pemain, h2).

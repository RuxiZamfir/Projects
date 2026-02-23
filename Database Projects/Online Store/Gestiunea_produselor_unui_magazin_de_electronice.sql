#SOURCE C:/Users/Ruxi/Desktop/Proiect BD/Gestiunea_produselor_unui_magazin_de_electronice.sql


/*#############################################################*/
/*        PARTEA 1 - STERGEREA SI RECREAREA BAZEI DE DATE      */

DROP DATABASE electroniceBD;
CREATE DATABASE electroniceBD;
USE electroniceBD;

/*#############################################################*/




/*#############################################################*/
/*                  PARTEA 2 - CREAREA TABELELOR              */

CREATE TABLE tblClient( 
	idClient SMALLINT(3) ZEROFILL PRIMARY KEY NOT NULL AUTO_INCREMENT, 
	numeClient VARCHAR(30) NOT NULL,
	prenumeClient VARCHAR(30) NOT NULL, 
	mail VARCHAR(50) NOT NULL, 
	telefonClient CHAR(10) NOT NULL
	); 

CREATE TABLE tblCurier( 
	idCurier SMALLINT(3) ZEROFILL PRIMARY KEY NOT NULL AUTO_INCREMENT, 
	numeCurier VARCHAR(30) NOT NULL, 
	prenumeCurier VARCHAR(30) NOT NULL, 
	telefonCurier CHAR(10) NOT NULL 
	); 

CREATE TABLE tblComanda(
	idComanda SMALLINT(3) ZEROFILL PRIMARY KEY NOT NULL AUTO_INCREMENT,
	codClient SMALLINT(3) ZEROFILL NOT NULL,
	codCurier SMALLINT(3) ZEROFILL NOT NULL,
	dataComanda DATE NOT NULL,
	dataLivrare DATE NOT NULL,
	adresaLivrare VARCHAR(100) NOT NULL,
	tipPlata VARCHAR(30) NOT NULL,
	CONSTRAINT fk1_comanda FOREIGN KEY(codClient) REFERENCES tblClient(idClient) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk2_comanda FOREIGN KEY(codCurier) REFERENCES tblCurier(idCurier) ON DELETE CASCADE ON UPDATE CASCADE 
	);

CREATE TABLE tblFurnizor( 
	numeFurnizor VARCHAR(30) PRIMARY KEY NOT NULL ,
	adresaFurnizor VARCHAR(100),  
	telefonFurnizor CHAR(10) NOT NULL
	); 

CREATE TABLE tblElectronice(
	idProdus SMALLINT(3) ZEROFILL PRIMARY KEY NOT NULL AUTO_INCREMENT,
	codFurnizor  VARCHAR(30) NOT NULL, 
	tipProdus VARCHAR(50) NOT NULL,
	descriereProdus TEXT, 
	pretProdus DECIMAL(7,2) NOT NULL,
	CONSTRAINT fk_furnizor FOREIGN KEY(codFurnizor) REFERENCES tblFurnizor(numeFurnizor) ON DELETE CASCADE ON UPDATE CASCADE 
	);
	 
CREATE TABLE tblFactura( 
	codComanda SMALLINT(3) ZEROFILL NOT NULL ,
	codProdus SMALLINT(3) ZEROFILL NOT NULL ,
	pretVanzare DECIMAL(7,2)  NOT NULL, 
	cantitate SMALLINT(5) NOT NULL, 
	CONSTRAINT uniq1_factura UNIQUE(codComanda, codProdus),
	CONSTRAINT fk1_factura FOREIGN KEY(codComanda) REFERENCES tblComanda(idComanda) ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk2_factura FOREIGN KEY(codProdus)  REFERENCES tblElectronice(idProdus) ON DELETE CASCADE ON UPDATE CASCADE	 
	);	

/*#############################################################*/



/*#############################################################*/
/*         PARTEA 3 - INSERAREA INREGISTRARILOR IN TABELE      */
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Popescu","Ion","popescuion07@gmail.com","0754343555");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Vasile","Maria","vasile.maria@gmail.com","0748364643");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Matei","Marius","marius03matei@gmail.com","0751225864");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Constantin","Andrei","costiandrei1@gmail.com","0749918785");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Radu","Marius","radduumarius5@gmail.com","0774994425");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("George","Vasile","georgegeorge10@gmail.com","0745747866");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Gheorghe","Bogdan","bogdangheorghe2000@gmail.com","0746477788");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Ionescu","Andrei","andreiionescu99@gmail.com","0755576647");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Popa","Georgian","georgianpopa11@gmail.com","0724884320");
INSERT INTO tblClient (numeClient, prenumeClient, mail, telefonClient) VALUES ("Maria","Andreea","maryandreea00@gmail.com","0744592013");

INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Liviu", "Teodorel", "0766765678");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Sabareanu", "Andi", "0792913538");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Oproiu", "Tudor", "0754565754");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Tudoran", "Eduard", "0779345825");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Neacsu", "Eduard", "0766432525");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Nica", "Vlad", "0744533245");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Deaconu", "Mihai", "0743421853");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Barbu", "Razvan", "0775435444");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Popescu", "Ion", "0733445643");
INSERT INTO tblCurier (numeCurier, prenumeCurier, telefonCurier) VALUES ("Mateescu", "Luca", "0724388553");

INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("SAMSUNG","Soseaua Bucuresti-Ploiesti 42-44, Sector 6, Bucuresti","0756298369");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("HUAWEI","Strada Barbu Vacarescu 162-164 Sector 2, Bucuresti","0796265123");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("APPLE","Splaiul Independentei 7 Sector 5, Bucuresti","0714815982");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("LENOVO","Piata UniriI nr. 1 Sector 2, Bucuresti","0745896235");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("LG","B-dul Mircea Voda nr.44, Sector 5, Bucuresti","0785226647");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("ASUS","Strada Ion Campineanu 7 Sector 1, Bucuresti","0732568941");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("MOTOROLA","Bulevardul Iuliu Maniu 59 Sector 6, Bucuresti","0721001452");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("XIAOMI","Soseaua Pandurilor 90-92, Sector 3, Bucuresti","0348458523");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("HP","str. Izvor nr. 78, Sector 2, Bucuresti","0214569875");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("ACER","Bd. Basarabia, nr. 96, Sector 4,Bucuresti","0785962500");
INSERT INTO tblFurnizor (numeFurnizor, adresaFurnizor, telefonFurnizor) VALUES ("DELL","Calea Crangasi 22, Sector 6, Bucuresti","0754478522");

INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (1, 2,"2022-11-10","2022-11-20","Strada 7 Noiembrie nr.7, 725700, Suceava","CASH LA LIVRARE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (2, 1,"2022-11-24","2022-11-28","Strada  Manolescu Ion, nr. 6 bl. 128 sc. 1 et 1 ap. 8, sector 6,Bucuresti, 61217","CARD LA LIVRARE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (3, 3,"2022-11-29","2022-12-12","Bulevardul Tineretului,nr.406 Valcea","TRANSFER BANCAR ONLINE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (4, 2,"2022-11-25","2022-12-03","Strada Principala 234, Cacica, 727095","CASH LA LIVRARE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (5, 1,"2022-12-10","2022-12-15","Strada Rahovei nr. 266-268 bl. Corp 2 et 2 ap. Cam.3,  sector 1, Bucuresti, 050912","TRANSFER BANCAR ONLINE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (6, 4,"2022-12-5","2022-12-16","Bulevardul Bucuresti 9, Bl.8A, Prahova","CASH LA LIVRARE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (6, 5,"2022-12-6","2022-12-17","Bulevardul Bucuresti 9, Bl.8A, Prahova","CASH LA LIVRARE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (8,10,"2022-12-12","2022-12-24","Strada Luptei bl. 40 sc. A ap. 15, Sibiu, 550330","TRANSFER BANCAR ONLINE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (9, 9,"2022-12-28","2023-1-03","Strada Nicolae Caramfil 71-73, et.5, spatiul 10, Bucuresti","CARD LA LIVRARE");
INSERT INTO tblComanda (codClient, codCurier, dataComanda, dataLivrare, adresaLivrare, tipPlata) VALUES (10,8,"2022-12-24","2023-12-10","Strada Stefan cel Mare bl. 38 sc. A ap. 2, Bacau, 600358","TRANSFER BANCAR ONLINE");

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","laptop","MacBook Pro 16 Retina (Procesor Intel Core i7-9750H (12M Cache, up to 4.50 GHz), Coffee Lake, 16inch, Retina, Touch Bar, 16GB, 512GB SSD, AMD Radeon Pro 5300M @4GB, Mac OS Catalina, Layout INT, Gri",12999.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","laptop","MacBook Air (Procesor Apple M1 (12M Cache, up to 3.20 GHz), 13.3inch, Retina, 8GB, 256GB SSD, Integrated M1 Graphics, Mac OS Big Sur, Layout INT, Argintiu)",5637.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","laptop","MacBook Air (Procesor Apple M1 (12M Cache, up to 3.20 GHz), 13.3inch, Retina, 8GB, 512GB SSD, Integrated M1 Graphics, Mac OS Big Sur, Layout RO, Gri)",6564.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","telefon","iPhone 11, LCD IPS MultiTouch 6.1inch, 64GB Flash, Camera Duala 12MP, Wi-Fi, 4G, iOS (Negru)",2499.00);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","telefon","iPhone 14 Pro, LTPO Super Retina XDR OLED 6.1inch, 1TB Flash, Camera Quad 48 + 12 + 12 MP + TOF 3D LiDAR, Wi-Fi, 5G, iOS (Violet)",10399.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","telefon","iPhone 11, LCD IPS MultiTouch 6.1inch, 64GB Flash, Camera Duala 12MP, Wi-Fi, 4G, iOS (Negru)",2499.00);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","tableta","iPad 9 (2021), 10.2inch, Procesor Apple A13 Bionic, IPS LCD Capacitive touchscreen 10.2inch, 64GB Flash, 8 MP, Wi-Fi, Bluetooth, iOS (Gri Spatial)",2147.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","tableta","iPad Pro 12.9 Cellular (2022), Procesor Apple M2 Octa-Core, IPS LED Capacitive touchscreen 12.9inch, 2TB Flash, 16GB, Camera Duala 12+10 MP, Wi-Fi, Bluetooth, 5G, iPadOS (Gri)",14599.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("APPLE","tableta","iPad Air 4 (2020) Cellular, Procesor Hexa-Core, Liquid Retina IPS LCD Capacitive touchscreen 10.9inch, 256GB Flash, 6GB, 12MP, Wi-Fi, 4G, Bluetooth, iOS (Verde)",3899.00);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","laptop","TUF F15 FX506HE cu procesor Intel Core i5-11400H pana la 4.5 GHz, 15.6inch Full HD, IPS, 144Hz, 16GB, 512GB SSD,",4600);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","laptop","X415MA cu procesor Intel Celeron N4020, 14inch, Full HD, 4GB, 256GB SSD, Intel UHD Graphics 600",850);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","laptop","VivoBook 15 X1500EA cu procesor Intel Core i3-1115G4 pana la 4.10 GHz, 15.6inch, Full HD, IPS, 8GB, 256GB SSD, Intel UHD Graphics",1500);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","laptop","VivoBook 15 X1500EA cu procesor Intel Core i7-1165G7 pana la 4.70 GHz, 15.6inch, Full HD, IPS, 8GB, 512GB SSD, Intel Iris Xe Graphics",2456);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","laptop","Zenbook 14 OLED UX3402ZA cu procesor Intel Core i5-1240P pana la 4.40 GHz, 146inch, 2.8K, OLED 16GB, 512GB SSD, Intel Iris Xe Graphics",4999.56);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","telefon","ASUS ROG Phone 5, Procesor Octa-Core Qualcomm Snapdragon 888, AMOLED Capacitiv Touchscreen 6.786inch, 16GB RAM, 256GB Flash, Camera Tripla 64+13+5MP, Wi-Fi, 5G, Dual Sim, Android (Negru)",3500);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","telefon","ASUS ROG Phone 6D, Procesor MediaTek Dimensity 9000+, Ecran AMOLED 6.786inch, 12GB RAM, 256GB Flash, Camera Tripla 50+13+5MP, Wi-Fi, 5G, Dual Sim, Android (Gri)",4800);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","telefon","ROG Phone 6 Pro, Procesor Qualcomm SM8475 Snapdragon 8+ Gen 1 Octa-Core, Ecran AMOLED 6.786inch, 18GB RAM, 512GB Flash, Camera Tripla 50+13+5MP, Wi-Fi, 5G, Dual Sim, Android (Alb)",6599.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","telefon","Zenfone 8, Pocesor Qualcomm SM8350 Snapdragon 888 Octa-core, Super AMOLED Capacitive touchscreen 5.926inch, 8GB RAM, 128GB Flash, Camera Duala 64+12MP, 5G, Wi-Fi, Dual SIM, Android (Negru)",2636.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("ASUS","telefon","Zenfone 9, Pocesor Qualcomm Snapdragon 8+ Gen1 Octa-core, AMOLED Capacitive touchscreen 5.926inch, 8GB RAM, 128GB Flash, Camera Duala 50+12MP, 5G, Wi-Fi, Dual SIM, Android (Negru)",3299);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","VICTUS 15-fb0029nq cu procesor AMD Ryzen 5 5600H pana la 4.20 GHz, 15.6inch, Full HD, 8GB, 256GB SSD, Nvidia GeForce GTX 1650 4GB, INDIGO Blue",2599.23);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","15s-fq3019nq cu procesor Intel Celeron N4500, 15.6inch, HD, 4GB, 256GB SSD, Intel UHD Graphics, Dark Ash Silver",1599.97);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","VICTUS 15-fa0026nq cu procesor Intel Core i5-12500H pana la 4.50 GHz, 15.6inch, Full HD, 8GB, 512GB SSD, NVIDIA GeForce GTX 1650 4GB, INDIGO Blue",3996.42);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","250 G9 cu procesor Intel Core i5-1235U pana la 4.40 GHz, 15.6inch, Full HD, 8GB, 256GB SSD, Intel Iris Xe Graphics, INDIGO Blue",2399.54);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","250 G9 cu procesor Intel Core i5-1235U pana la 4.40 GHz, 15.6inch Full HD, 8GB, 512GB SSD, Intel Iris Xe Graphics, Dark Ash Silver",3254);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","ENVY x360 15-ey0011nn cu procesor AMD Ryzen 5 5625U pana la 4.30 GHz, 15.6inch Full HD, IPS, Touch 16GB, 512GB SSD, AMD Radeon Graphics, Nightfall Black",5499.75);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","Pavilion 17-cd2012nq cu procesor Intel Core i7-11370H, 17.3inch, Full HD, 16GB, 512GB SSD, NVIDIA GeForce RTX 3050 4GB, Black",5959.63);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HP","laptop","Legion 7 16ITHg6 cu procesor Intel Core i9-11980HK, 16inch, WQXGA, 165Hz, 32GB, 1TB SSD, NVIDIA GeForce RTX 3080 16GB, Storm Grey, 3y on-site Premium Care",15784.15);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("MOTOROLA","telefon","Moto G72, Procesor MediaTek Helio G99, Ecran P-OLED 6.55inch, 8GB RAM, 128GB Flash, Camera Tripla 108+8+2MP, Wi-Fi, 4G, Dual Sim, Android (Gri)",1299);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("MOTOROLA","telefon","Moto E32s, Procesor Mediatek MT6765V/CB Helio G37 Octa-Core, IPS LCD 6.5inch, 4GB RAM, 64GB Flash, Camera Tripla 16 + 2 + 2 MP, Wi-Fi, 4G, Dual SIM, Android (Gri)",750);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("MOTOROLA","telefon","Moto G60, Procesor Qualcomm SM7150 Snapdragon 732G, IPS LCD Capacitiv touchscreen 6.8inch, 6GB RAM, 128GB Flash, Camera Tripla 108+8+2MP, 4G, Wi-Fi, Dual SIM, Android (Negru)",1039);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("MOTOROLA","telefon","Defy (2021), Procesor Qualcomm SM6115 Snapdragon 662 Octa-Core, IPS LCD Capacitiv touchscreen 6.5inch, 4GB RAM, 64GB Flash, Camera Tripla 48+2+2MP, 4G, Wi-Fi, Dual SIM, Android (Verde)",949);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("MOTOROLA","telefon","Edge 20, Procesor Qualcomm Snapdragon 778G 5G, OLED Capacitiv touchscreen 6.7inch, 8GB RAM, 128GB Flash, Camera Tripla 108+8+16MP, 5G, Wi-Fi, Dual SIM, Android (Gri)",1550);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("MOTOROLA","telefon","Edge 20 Lite, Procesor MediaTek MT6853 Dimensity 720 5G, OLED Capacitiv touchscreen 6.7inch, 8GB RAM, 128GB Flash, Camera Tripla 108+8+2MP, 5G, Wi-Fi, Dual SIM, Android (Gri)",1250);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","telefon","Galaxy S21 FE, Dual SIM, 6GB RAM, 128GB, 5G, Graphite",2799.00);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","telefon","Galaxy S22, Dual SIM, 128GB, 8GB RAM, 5G, Phantom Black",3099.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","telefon","Galaxy A53, Dual SIM, 6GB RAM, 128GB, 5G, Awesome White",1599.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","laptop","XPS 15 9520, 15.6 inch Touchscreen, Intel i7-12700H (14C/20 T,4.7 GHz,24 MB cache,35 W), 16 GB RAM, 1 TB SSD, Nvidia RTX 3050Ti,Windows 11 Pro",14577.60);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","tableta","Galaxy Tab A8, Octa-Core, 10.5 inch, 3GB RAM, 32GB, WIFI, Gray",929.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","tableta","Galaxy Tab S8 Plus, Octa-Core, 12.4 inch, 8GB RAM, 128GB, 5G, SILVER",3999.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","tableta","Galaxy Tab S6 Lite (2022), Octa-Core, 10.4 inch, 64GB, 4GB RAM, Wi-Fi, Angora Blue",1514.00 );
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("SAMSUNG","tableta","Galaxy Tab A7 Lite, Octa-Core, 8.7 inch, 3GB RAM, 32GB, Wi-Fi, Gray",713.99 );

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("XIAOMI","telefon","Redmi 9A, Procesor MediaTek Helio G25 Octa-Core 2.0GHz, IPS LCD Capacitiv touchscreen 6.53inch, 2GB RAM, 32GB Flash, Camera 13MP, 4G, Wi-Fi, Dual SIM, Android (Gri)",519);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("XIAOMI","telefon","Redmi Note 10 Pro, Procesor Octa-Core Qualcomm SM7150 Snapdragon 732G, AMOLED Capacitive touchscreen 6.67inch, 6GB RAM, 128GB Flash, Camera Quad 108+8+5+2MP, Wi-Fi, 4G, Dual Sim, Android (Gri)",1199.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("XIAOMI","telefon","Redmi 9C, Procesor MediaTek Helio G35, Octa-Core 2.3GHz, IPS LCD Capacitive touchscreen 6.53inch, 3GB RAM, 64GB Flash, Camera Tripla 13+2+2MP, 4G, Wi-Fi, Dual SIM, Android (Gri)",629);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("XIAOMI","telefon","Mi 11 Ultra, Procesor Qualcomm SM8350 Snapdragon 888 Octa-Core, AMOLED Capacitive touchscreen 6.81inch, 120Hz refresh rate, 12GB RAM, 256GB Flash, Camera Tripla 50 + 48 + 48 MP, 5G, Wi-Fi, Dual SIM, Android (Negru)",4199);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("XIAOMI","tableta","Mi Pad 5, Procesor Qualcomm Snapdragon 860, Octa Core, Ecran IPS LCD Capacitive touch 11inch, 6GB RAM, 128GB Flash, 13MP, Wi-Fi, Bluetooth, Android (Alb)",1865.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("XIAOMI","tableta","Redmi Pad, Procesor Qualcomm Snapdragon 860, Octa Core, Ecran IPS LCD Capacitive touch, 10.61inch, 128GB, 4GB RAM, Wi-Fi, Bluetooth, Android, Mint Green",1569.99);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("DELL","laptop","Latitude E6440, Intel Core i5-4310M 2.70GHz, 8GB DDR3, 120GB SSD, DVD-RW, 14inch FHD + Windows 10 Home",1399);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("DELL","laptop","Latitude E5450 (Procesor Intel Core i5-5300U (3M Cache, up to 2.90 GHz), Broadwell, 14inch, 8GB DDR3, 240GB SSD, Webcam, Intel HD Graphics 5500)",1833.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("DELL","laptop","Latitude E5450 i5-5300U CPU  2.30GHz up to 2.90 GHz 4GB DDR3 500GB HDD 14inch 1366x768 Webcam Windows 10 Professional Preinstalat",1656.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("DELL","laptop","Latitude E7280, i5 - 6200U 2.3GHz up to 2.8GHz, 8GB DDR4, 256GB NVMe SSD, 12.5 inch FHD, Webcam, Soft Preinstalat Windows 10 PRO (Negru)",1877.99);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","telefon","Nova 9, Dual SIM, 8GB RAM, 128GB, 4G, Starry Blue",1199.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","telefon","Huawei nova Y70, 4GB RAM, 128GB, 4G, Crystal Blue",699.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","telefon","Huawei P30 Lite, Dual SIM, 128GB, 4G, Midnight Black",930.58);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","telefon","Huawei Y5P, Dual SIM, 32GB, 4G, Midnight Black",499.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","telefon","Huawei P50 Pro, 8GB RAM, 256GB, 4G, Golden Black",3699.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","laptop","MateBook D15 cu procesor Intel Core i3-1115G4 pana la 4.10 GHz, 15.6inch, Full HD, 8GB, 256GB SSD, Intel UHD Graphics, Windows 11 Home, Sliver",1899.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","laptop","MateBook D14 cu procesor Intel Core i3-1115G4 pana la 4.10 GHz, 14inch, Full HD, 8GB, 256GB SSD, Intel UHD Graphics, Windows 11 Home, Space Gray",1999.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","laptop","MateBook D15 cu procesor Intel Core i5-1135G7 pana la 4.20 GHz, 15.6inch, Full HD, 8GB, 512GB SSD, Intel Iris Xe Graphics, Free DOS, Silver",2364.52);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","laptop","MateBook 14 cu procesor AMD Ryzen 5 5500U pana la 4.00 GHz, 14inch 2K, 16GB, 512GB SSD, AMD Radeon Graphics, Windows 11 Home, Gray",3499.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","tableta","MatePad (2021), Octa-Core, 10.4inch, 4GB RAM, 64GB, Wi-Fi, Midnight Grey",799.99 );
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("HUAWEI","tableta","Matepad Paper, 4GB RAM, 64GB, Wi-Fi, husa si pen incluse, Black",1999.99);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","IdeaPad 3 15ITL6 cu procesor Intel Core i3-1115G4 pana la 4.10 GHz, 15.6inch, Full HD, IPS, 8GB, 512GB SSD, Intel UHD Graphics, No OS, Sand",1699.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","V15 G2 ITL cu procesor Intel Core i5-1135G7 pana la 4.20 GHz, 15.6inch, Full HD, 8GB, 512GB SSD, Intel Iris Xe Graphics, No OS, Black",2982);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","Legion 5 Pro 16ACH6H cu procesor AMD Ryzen 5 5600H pana la 4.2 GHz, 16inch, WQXGA, IPS, 16GB, 512GB SSD, NVIDIA GeForce RTX 3060 6GB, No OS, Stingray, 3y on-site, Premium Care",5996.12);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","IdeaPad 3 15IHU6 cu procesor Intel Core i5-11320H pana la 4.50 GHz, 15.6inch, Full HD, IPS, 16GB, 512GB SSD, NVIDIA GeForce GTX 1650 4GB, No OS, Shadow Black",2998.77);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","V15 G2 ALC cu procesor AMD Ryzen 3 5300U pana la 3.80 GHz, 15.6inch, Full HD, 4GB, 256GB SSD, AMD Radeon Graphics, No OS, Black",1399.65);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","ThinkBook 15 G3 ACL cu procesor AMD Ryzen 7 5700U pana la 4.30 GHz, 15.6inch, Full HD, IPS, 16GB, 512GB SSD, AMD Radeon Graphics, Windows 10 Pro, Mineral Grey",3500.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","Legion 7 16ACHg6 cu procesor AMD Ryzen 9 5900HX pana la 4.60 GHz, 16inch, WQXGA, 32GB, 2TB SSD, NVIDIA GeForce RTX 3080 16GB, No OS, Storm Grey, 3y on-site, Premium Care",11456.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","Lenovo IdeaPad 3 15IHU6 cu procesor Intel Core i5-11320H pana la 4.50 GHz, 15.6inch, Full HD, IPS, 120Hz, 16GB, 512GB SSD, NVIDIA GeForce RTX 3050 Ti 4GB, No OS, Shadow Black",4099.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","IdeaPad 3 15IGL05 cu procesor Intel Celeron N4020, 15.6inch, Full HD, 4GB, 256GB SSD, Intel UHD Graphics 600, No OS, Platinum Grey",1023.75);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Lenovo","laptop","Yoga Slim 7 13ACN5 cu procesor AMD Ryzen 5 5600U pana la 4.20 GHz, 13.3inch, 2.5K, IPS, 16GB, 512GB SSD, AMD Radeon Graphics, Windows 11 Home, Light Silver",3145.7);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Acer","laptop","Nitro 5 AN515-45 cu procesor AMD Ryzen 5 5600H pana la 4.20 GHz, 15.6inch, Full HD, IPS, 144Hz, 8GB, 512GB SSD, NVIDIA GeForce RTX 3050 4GB, NO OS, Black",3199.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Acer","laptop","Predator Helios 300 PH315-54-94FE, Intel Core i9-11900H pana la 4.9 GHz, 15.6inch Full HD, 32GB, SSD 1TB, NVIDIA GeForce RTX 3070 8GB, Windows 11 Home, Negru",22550.50);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Acer","laptop","ultraportabil Aspire 3 A315-34 cu procesor Intel Celeron N4020 pana la 2.80 GHz, 15.6inch, Full HD, 4GB, 256GB SSD, Intel UHD Graphics 600, No OS, Black",1499.90);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("Acer","laptop","Aspire 3 A315-35, 15.6inch FHD, cu procesor Intel Celeron N5100, 8GB DDR4, 256GB SSD, Intel UHD Graphics, no OS, Blue",1549.99);

INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("LG","telefon","G4 Dual Sim, 32GB, 4G, Leather Brown",754.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("LG","telefon","K50, Dual SIM, 32GB, 3GB RAM, 4G, Black",849);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("LG","laptop","Gram 16Z90Q cu procesor Intel Core i7-1260P, 16inch WQXGA (2560*1600), 16GB DDR5, 512GB SSD, Intel Iris Xe Graphics, Windows 11 Home Plus, Obsidian Black",6789);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("LG","laptop","Gram 17Z90Q cu procesor Intel Core i7-1260P, 17.3inch WQXGA (2560*1600), 16GB DDR5, 1 TB SSD, Intel Iris Xe Graphics, Windows 11 Home Plus, Obsidian Black",7499);
#INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("LG","laptop","Gram 15Z90Q cu procesor Intel Core i7-1260P, 15.6inch FHD (1920*1080), 16GB DDR5, 512 GB SSD, Intel Iris Xe Graphics, Windows 11 Home Plus, Obsidian Black",5949.99);
INSERT INTO tblElectronice (codFurnizor,tipProdus,descriereProdus,pretProdus) VALUES ("LG","laptop","",5949.99);

INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 1,8,14599.99,2);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 1,9,3799.00,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 1,11,830.00,3);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 2,22,3975.32,2);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 2,25,5475.21,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 3,10,4600,2);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 3,44,500,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 3,72,3100,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 4,75,1499,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 4,18,2000,3);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 5,17,6892.12,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 6,34,2510.99,2);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 6,21,1900,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 7,12,1556.2,3);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 7,22,4321.99,3);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 8,28,1452.44,4);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 8,34,3174.45,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 8,20,2700,2);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 9,24,3300,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 10,5,10399.99,1);
INSERT INTO tblFactura ( codComanda, codProdus, pretVanzare, cantitate) VALUES ( 10,7,2150,1);

/*#############################################################*/



/*#############################################################*/
/*  PARTEA 4 - VIZUALIZAREA STUCTURII BD SI A INREGISTRARILOR  */
SHOW TABLES; 
DESCRIBE tblClient;
DESCRIBE tblCurier;
DESCRIBE tblComanda;
DESCRIBE tblFurnizor;
DESCRIBE tblElectronice;
DESCRIBE tblFactura;

SELECT * FROM tblClient;
SELECT * FROM tblCurier;
SELECT * FROM tblFurnizor;
SELECT * FROM tblComanda;
SELECT * FROM tblElectronice;
SELECT * FROM tblFactura;

UPDATE tblElectronice SET descriereProdus="DESCRIERE INDISPONIBILA" WHERE descriereProdus="";

SELECT * FROM tblClient;
SELECT * FROM tblCurier;
SELECT * FROM tblFurnizor;
SELECT * FROM tblComanda;
SELECT * FROM tblElectronice;
SELECT * FROM tblFactura;
/*#############################################################*/


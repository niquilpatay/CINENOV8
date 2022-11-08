create database cineNov6_Nuevo
use cineNov6_Nuevo
--TABLAS

--login
CREATE TABLE [dbo].[Login](
	[id_usuario] [int] IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](50) NULL,
	[contras] [varchar](50) NULL,
 CONSTRAINT [pk_usuario] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)
)

--tipos salas
CREATE TABLE [dbo].[Tipos_Salas](
	[id_tipo_sala] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](20) NULL,
 CONSTRAINT [pk_tipo_sala] PRIMARY KEY CLUSTERED 
(
	[id_tipo_sala] ASC
)
) ON [PRIMARY]

--tipo peliculas
CREATE TABLE [dbo].[Tipo_peliculas](
	[id_tipo] [int] IDENTITY(1,1) NOT NULL,
	[genero] [varchar](50) NULL,
 CONSTRAINT [pk_tipo_peliculas] PRIMARY KEY CLUSTERED 
(
	[id_tipo] ASC
)
)

--tipos pagos
CREATE TABLE [dbo].[Tipos_pagos](
	[id_tipo_pago] [int] IDENTITY(1,1) NOT NULL,
	[nombre_tipo_pago] [varchar](50) NULL,
 CONSTRAINT [pk_id_tipo_pago] PRIMARY KEY CLUSTERED 
(
	[id_tipo_pago] ASC
)
)

--salas
CREATE TABLE [dbo].[Salas](
	[id_sala] [int] IDENTITY(1,1) NOT NULL,
	[id_tipo_sala] [int] NULL,
 CONSTRAINT [pk_salas] PRIMARY KEY CLUSTERED 
(
	[id_sala] ASC
)
)

--butacas
CREATE TABLE [dbo].[Butacas](
	[id_butaca] [int] IDENTITY(1,1) NOT NULL,
	[id_sala] [int] NULL,
 CONSTRAINT [pk_asiento] PRIMARY KEY CLUSTERED 
(
	[id_butaca] ASC
)
)

--clientes
CREATE TABLE [dbo].[Clientes](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
    [dni_cliente] [varchar](8) NULL,
	[email] [varchar](100) NULL,
	[calle] [varchar](50) NULL,
	[altura] [int] NULL,
	[telefono] [bigint] NULL,
	[nom_cliente] [varchar](100) NULL,
	[ape_cliente] [varchar](100) NULL,
 CONSTRAINT [pk_cliente] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)
)

alter table clientes
add activo bit 

update clientes set activo = 1

--peliculas
CREATE TABLE [dbo].[Peliculas](
	[id_pelicula] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](500) NULL,
	[duracion] [int] NULL,
	[id_tipo] [int] NULL,
 CONSTRAINT [pk_peliculas] PRIMARY KEY CLUSTERED 
(
	[id_pelicula] ASC
)
)

--funciones
CREATE TABLE [dbo].[Funciones](
	[id_funcion] [int] IDENTITY(1,1) NOT NULL,
	[id_pelicula] [int] NULL,
	[fecha_hora] [datetime] NULL,
	[pre_unitario] [money] NULL,
	[id_sala] [int] NULL,
 CONSTRAINT [pk_funciones] PRIMARY KEY CLUSTERED 
(
	[id_funcion] ASC
)
)

alter table funciones
add activo bit 

update funciones set activo = 1

--tickets
CREATE TABLE [dbo].[Tickets](
	[id_ticket] [int] IDENTITY(1,1) NOT NULL,
	[id_tipo_pago] [int] NULL,
	[id_cliente] [int] NULL,
	[fecha_compra] [datetime] NULL,
 CONSTRAINT [pk_Tickets] PRIMARY KEY CLUSTERED 
(
	[id_ticket] ASC
)
)

--detalle tickets
CREATE TABLE [dbo].[Detalle_Tickets](
	[id_detalle_ticket] [int] IDENTITY(1,1) NOT NULL,
	[descuento] [decimal](18, 0) NULL,
	[id_ticket] [int] NULL,
	[costo] [money] NULL,
	[id_butaca] [int] NULL,
	[id_funcion] [int] NULL,
 CONSTRAINT [pk_Detalle_Tickets] PRIMARY KEY CLUSTERED 
(
	[id_detalle_ticket] ASC
)
)

-------------------------------------------------
--restricciones
ALTER TABLE [dbo].[Butacas]  WITH CHECK ADD  CONSTRAINT [fk_asiento_sala] FOREIGN KEY([id_sala])
REFERENCES [dbo].[Salas] ([id_sala])
GO
ALTER TABLE [dbo].[Butacas] CHECK CONSTRAINT [fk_asiento_sala]
GO
ALTER TABLE [dbo].[Detalle_Tickets]  WITH CHECK ADD  CONSTRAINT [fk_butaca_detalle] FOREIGN KEY([id_butaca])
REFERENCES [dbo].[Butacas] ([id_butaca])
GO
ALTER TABLE [dbo].[Detalle_Tickets] CHECK CONSTRAINT [fk_butaca_detalle]
GO
ALTER TABLE [dbo].[Detalle_Tickets]  WITH CHECK ADD  CONSTRAINT [fk_funcion_detalle] FOREIGN KEY([id_funcion])
REFERENCES [dbo].[Funciones] ([id_funcion])
GO
ALTER TABLE [dbo].[Detalle_Tickets] CHECK CONSTRAINT [fk_funcion_detalle]
GO
ALTER TABLE [dbo].[Detalle_Tickets]  WITH CHECK ADD  CONSTRAINT [fk_tickets] FOREIGN KEY([id_ticket])
REFERENCES [dbo].[Tickets] ([id_ticket])
GO
ALTER TABLE [dbo].[Detalle_Tickets] CHECK CONSTRAINT [fk_tickets]
GO
ALTER TABLE [dbo].[Funciones]  WITH CHECK ADD  CONSTRAINT [fk_pelicula] FOREIGN KEY([id_pelicula])
REFERENCES [dbo].[Peliculas] ([id_pelicula])
GO
ALTER TABLE [dbo].[Funciones] CHECK CONSTRAINT [fk_pelicula]
GO
ALTER TABLE [dbo].[Funciones]  WITH CHECK ADD  CONSTRAINT [fk_sala_funcion] FOREIGN KEY([id_sala])
REFERENCES [dbo].[Salas] ([id_sala])
GO
ALTER TABLE [dbo].[Funciones] CHECK CONSTRAINT [fk_sala_funcion]
GO
ALTER TABLE [dbo].[Peliculas]  WITH CHECK ADD  CONSTRAINT [fk_peliculas_tipo_peliculas] FOREIGN KEY([id_tipo])
REFERENCES [dbo].[Tipo_peliculas] ([id_tipo])
GO
ALTER TABLE [dbo].[Peliculas] CHECK CONSTRAINT [fk_peliculas_tipo_peliculas]
GO
ALTER TABLE [dbo].[Salas]  WITH CHECK ADD  CONSTRAINT [fk_tipo_sala] FOREIGN KEY([id_tipo_sala])
REFERENCES [dbo].[Tipos_Salas] ([id_tipo_sala])
GO
ALTER TABLE [dbo].[Salas] CHECK CONSTRAINT [fk_tipo_sala]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [fk_cliente] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[Clientes] ([id_cliente])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [fk_cliente]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [fk_tipo_pago] FOREIGN KEY([id_tipo_pago])
REFERENCES [dbo].[Tipos_pagos] ([id_tipo_pago])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [fk_tipo_pago]
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--INSERTS
--tipo peliculas
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Acción')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Aventuras')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Ciencia Ficción')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Comedia')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Documental')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Drama')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Fantasía')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Musical')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Suspense')
INSERT [dbo].[Tipo_peliculas] ([genero]) VALUES (N'Terror')

--tipos pagos
INSERT [dbo].[Tipos_pagos] ([nombre_tipo_pago]) VALUES (N'CRÉDITO')
INSERT [dbo].[Tipos_pagos] ([nombre_tipo_pago]) VALUES (N'DÉBITO')
INSERT [dbo].[Tipos_pagos] ([nombre_tipo_pago]) VALUES (N'EFECTIVO')

--tipos salas
INSERT [dbo].[Tipos_Salas] ([tipo]) VALUES (N'2D')
INSERT [dbo].[Tipos_Salas] ([tipo]) VALUES (N'3D')
INSERT [dbo].[Tipos_Salas] ([tipo]) VALUES (N'Premium Class')
INSERT [dbo].[Tipos_Salas] ([tipo]) VALUES (N'IMAX')
INSERT [dbo].[Tipos_Salas] ([tipo]) VALUES (N'Multiplex')

--clientes
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Timon','Mercado',28960045,'euismod@google.ca','8272 Ullamcorper Rd.',2842,3536309358),
  ('Jessamine','Gibson',39553922,'eu.elit@google.ca','8751 Et Ave',590,3525926877),
  ('Nash','Harvey',42575832,'ligula.donec@yahoo.ca','P.O. Box 576, 8737 Nisl. Rd.',2957,3518131960),
  ('Ali','Christensen',36492626,'tempor.erat.neque@icloud.ca','Ap #920-4045 Eget, St.',1375,3516816475),
  ('Walter','Carey',44945116,'risus@protonmail.org','Ap #191-4050 Ac Rd.',2515,3533053432),
  ('Dieter','Dillard',23674857,'consequat.lectus.sit@icloud.net','748-9200 Turpis Street',3908,3531851580),
  ('Kirsten','Kaufman',41537872,'magna.tellus@google.edu','1696 Neque. St.',264,3525119944),
  ('Ulric','Mooney',25182123,'aliquam.eros.turpis@outlook.ca','Ap #486-6421 Malesuada St.',1178,3536735684),
  ('Alvin','Nguyen',38153241,'ultrices@google.net','P.O. Box 979, 6726 Adipiscing St.',1881,3527088792),
  ('Melyssa','Beard',29067548,'mauris@aol.edu','P.O. Box 602, 5963 Aliquam St.',1396,3525140739);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Isabella','Durham',43169023,'eget.dictum@icloud.org','Ap #150-8415 Nulla St.',1790,3517270089),
  ('Dominique','Walton',29928412,'montes.nascetur.ridiculus@icloud.couk','274-2185 Adipiscing, Rd.',1407,3531950758),
  ('Derek','Yates',44475752,'eu.metus@outlook.edu','744-9540 Risus. Avenue',1246,3538731044),
  ('Melyssa','Becker',42369484,'gravida@protonmail.org','Ap #465-7531 Commodo Rd.',2526,3515968547),
  ('Ainsley','Cline',29248226,'senectus@outlook.edu','427-599 Scelerisque Avenue',2202,3531375846),
  ('Ali','Cunningham',30822608,'maecenas@aol.edu','P.O. Box 714, 2236 Adipiscing St.',2327,3532621297),
  ('Pearl','Pace',31620284,'lorem.lorem.luctus@google.org','1092 Est Road',3006,3538867410),
  ('Xandra','Gill',44151112,'et.arcu@aol.edu','P.O. Box 966, 2269 In Avenue',2082,3528262626),
  ('Adena','Singleton',31829568,'orci.sem@protonmail.com','518-8143 Adipiscing Rd.',738,3538993261),
  ('Simone','Barton',35492580,'aliquam.tincidunt.nunc@protonmail.com','Ap #569-4019 Aenean Ave',3981,3534861091);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Maxine','Vasquez',41338104,'eu.tellus@yahoo.ca','Ap #321-6431 Facilisis. Rd.',3242,3533490322),
  ('Kiona','Frank',27095691,'et.euismod@aol.ca','167-8062 Etiam Rd.',2190,3535938146),
  ('Quon','Mcneil',30545650,'vulputate.risus.a@aol.com','546-3973 Tortor Av.',572,3530633895),
  ('Quinlan','Woods',31942270,'ut.sagittis.lobortis@icloud.com','Ap #959-6054 Molestie Av.',2930,3535913833),
  ('Allistair','Snyder',37191594,'ipsum.porta@hotmail.com','Ap #357-1985 Tellus St.',1475,3533332553),
  ('Ryan','Mendez',29900677,'aliquet.vel@hotmail.ca','P.O. Box 209, 3895 Neque Rd.',1996,3524981436),
  ('Maya','Tran',38544356,'viverra.maecenas@icloud.org','822-4816 Velit Avenue',1088,3528361035),
  ('Honorato','Walton',24879515,'lorem@hotmail.edu','P.O. Box 282, 2740 Lorem, Road',1948,3539417389),
  ('Burke','Golden',25236543,'quis.accumsan.convallis@icloud.couk','8823 Nullam Road',3279,3519152771),
  ('Sophia','Weeks',41322952,'ante@aol.couk','Ap #783-108 Cursus, Avenue',2749,3527015152);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Quinlan','George',42041028,'tincidunt.nibh@yahoo.ca','P.O. Box 187, 1960 Tortor. Street',163,3522914908),
  ('Hilel','Hobbs',36100171,'tincidunt.nibh@protonmail.ca','9629 Nunc Road',762,3533302810),
  ('Barry','Blake',34374760,'feugiat@hotmail.net','399-2821 Orci. Road',2607,3534511696),
  ('Phyllis','Merrill',44046260,'enim.sit@icloud.com','Ap #321-1294 Mauris Avenue',2100,3528574019),
  ('Britanni','Small',30587434,'luctus.et.ultrices@outlook.com','775-3176 Lobortis Rd.',1311,3531210209),
  ('Shay','Newton',40847607,'quisque.purus@yahoo.ca','268-843 Neque. Rd.',2299,3518974445),
  ('Shelby','Wilcox',41358161,'mauris.magna@protonmail.net','Ap #622-944 Interdum. St.',1999,3519747208),
  ('Hilel','Ingram',35209487,'ante.lectus@google.edu','P.O. Box 227, 3755 Rhoncus. Rd.',3883,3533310674),
  ('Noelani','Patton',42886964,'lorem.ipsum@hotmail.net','P.O. Box 465, 5971 Vehicula. Avenue',2914,3523220288),
  ('Nell','Bean',30335245,'eu.arcu@aol.couk','8036 Dui, Rd.',517,3527370232);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Ray','Burks',25358239,'nec@icloud.edu','Ap #176-8327 Nulla Road',689,3526840135),
  ('Nelle','Walker',31180868,'eu.neque.pellentesque@icloud.org','Ap #376-5650 Adipiscing. St.',690,3538607317),
  ('Reed','Hyde',27653790,'vel@google.ca','177-627 Eget, Road',982,3531062916),
  ('Mallory','Potts',24406023,'eros@protonmail.edu','652-9075 Interdum. Road',1554,3516434625),
  ('Irma','Walton',31076573,'orci.donec.nibh@protonmail.net','Ap #648-4250 Est St.',190,3517209372),
  ('Olivia','Deleon',36220511,'gravida.sit.amet@icloud.couk','Ap #230-4833 Tristique Road',2900,3518970343),
  ('Lee','Noel',40030218,'velit@aol.org','Ap #505-4211 Nunc Ave',3564,3538565395),
  ('Jana','Bates',33960350,'in@protonmail.org','P.O. Box 231, 9866 Metus Avenue',2809,3522933028),
  ('Logan','Howell',32930309,'mauris.sagittis@aol.org','746-412 Orci, Rd.',3597,3529838612),
  ('Justin','Hicks',43299224,'duis.dignissim@icloud.couk','3774 Accumsan Rd.',1488,3530682345);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Daphne','Mendoza',25037758,'ridiculus@google.com','Ap #530-4947 Fusce Avenue',697,3536853002),
  ('Zoe','Merritt',44730771,'dui@google.org','P.O. Box 961, 2355 Turpis Rd.',2494,3535761041),
  ('Paki','Stephens',27797007,'cum.sociis@hotmail.net','P.O. Box 627, 2883 Dui. Street',271,3530131210),
  ('Ila','Carr',23422784,'placerat.orci@hotmail.ca','Ap #192-2497 Risus, St.',768,3518217793),
  ('Samuel','Roth',27179456,'montes.nascetur@icloud.ca','647-7933 Sed Ave',2426,3526313113),
  ('Neve','Beasley',34819213,'pede.nonummy.ut@yahoo.couk','Ap #657-1918 Velit Rd.',2509,3526468596),
  ('Randall','Waller',34577263,'ridiculus@icloud.ca','491-7568 Amet St.',1987,3527090768),
  ('Kyla','Pacheco',29290886,'et@yahoo.couk','319-9116 Dignissim Av.',3963,3522026878),
  ('Josiah','Henderson',42719429,'vel.pede@yahoo.couk','3079 Nec Rd.',966,3533896865),
  ('Otto','Fleming',36880562,'eu.enim.etiam@aol.ca','P.O. Box 494, 6455 Tempor, St.',2338,3532838890);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Ignatius','Mejia',30647689,'tellus.aenean@protonmail.ca','464-1056 Erat Road',3373,3525008969),
  ('Jerry','Lloyd',37936663,'sagittis.placerat@aol.net','P.O. Box 227, 1827 Fermentum St.',1663,3525131358),
  ('Bell','Justice',40073474,'orci.ut@protonmail.ca','Ap #671-1819 Gravida. St.',803,3529810280),
  ('Stacy','Shaffer',42267753,'fermentum.convallis.ligula@icloud.net','Ap #173-2157 Gravida. Road',696,3520440428),
  ('Dominic','Cochran',26386673,'velit@protonmail.net','P.O. Box 986, 4269 Ipsum St.',3741,3521709738),
  ('Barrett','Henderson',43757380,'velit.in.aliquet@aol.edu','Ap #583-668 Augue. Ave',101,3526744563),
  ('Mariam','Browning',26723611,'vel.arcu@google.org','120-7603 Lorem, Street',1665,3535419879),
  ('Kalia','Ortega',33377676,'lacus.quisque@hotmail.com','P.O. Box 579, 4150 Nullam Road',1818,3521853429),
  ('Lisandra','Conner',38032883,'vitae.mauris@yahoo.com','P.O. Box 816, 5765 Amet, Av.',2011,3538436346),
  ('Amery','Freeman',41223372,'eleifend.nunc@outlook.ca','5199 Mauris Avenue',1774,3516539900);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Anjolie','Lane',34948931,'in.mi@outlook.net','777-7408 Nisi Rd.',2664,3527473718),
  ('Grady','Gamble',32234619,'proin@google.couk','574-7700 Sem St.',1973,3526892820),
  ('Solomon','Morgan',23397902,'phasellus.in.felis@aol.couk','Ap #426-2779 Felis, St.',576,3532724748),
  ('Quinn','Bowers',42612980,'vestibulum.massa.rutrum@outlook.ca','919-4849 Non, St.',3182,3524388164),
  ('Kyra','Warren',44168016,'taciti.sociosqu@google.edu','Ap #627-455 Donec Ave',2313,3518481305),
  ('Keane','Huffman',35386125,'lectus.pede.et@hotmail.com','Ap #581-1894 Lacus. Street',547,3527979057),
  ('Elvis','Blake',25559495,'ut.dolor.dapibus@aol.edu','P.O. Box 436, 8436 Blandit St.',2748,3535099611),
  ('Nora','Beck',33484501,'enim@outlook.net','3333 Egestas Road',2096,3529420009),
  ('Gary','Medina',40423676,'convallis@protonmail.com','Ap #337-3914 Libero. Street',2861,3525092693),
  ('Bevis','Finley',44490533,'gravida.praesent@outlook.com','Ap #227-7911 Vitae Avenue',2906,3534201306);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Shay','Mckenzie',27383860,'parturient@google.com','2473 Mattis Rd.',3606,3525547014),
  ('Breanna','Horne',43039303,'ante@protonmail.com','Ap #386-900 Ipsum Av.',3741,3530305747),
  ('Marah','Coffey',24666719,'tincidunt.pede@aol.edu','248-8227 Cras St.',231,3536994196),
  ('Timon','Conner',44445409,'leo.cras@icloud.edu','P.O. Box 159, 5092 Gravida Ave',2896,3515058586),
  ('Victoria','Lowe',39840966,'magna@icloud.com','944-8851 Dui. Rd.',685,3536867004),
  ('Quemby','Porter',44037030,'tristique.aliquet.phasellus@google.org','P.O. Box 609, 4005 Sit Avenue',2282,3531057537),
  ('Ralph','Richardson',38947041,'cursus.diam@aol.org','Ap #499-8562 Nunc Ave',596,3528648566),
  ('Herrod','Miles',41397922,'luctus.ipsum@aol.net','Ap #936-6049 Sed, Road',3424,3520161781),
  ('Skyler','Buckley',39181677,'augue@icloud.couk','709-1658 Faucibus Avenue',3087,3515843309),
  ('Wynter','Russell',43336160,'risus.a@icloud.net','6720 Leo Rd.',2411,3528554981);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Katelyn','Scott',29487721,'lorem.ipsum.dolor@google.com','Ap #935-4363 Gravida St.',859,3525973981),
  ('Felicia','Suarez',44766582,'ipsum.cursus@hotmail.ca','P.O. Box 811, 6086 Ante, Road',3746,3532391835),
  ('Odette','Warner',28599942,'enim@hotmail.com','740 Vestibulum Rd.',2062,3517104046),
  ('Hanae','Hammond',42750984,'turpis.in@hotmail.org','P.O. Box 692, 5557 Pede, Ave',3228,3539603127),
  ('Gillian','Barrera',42757686,'egestas.lacinia@protonmail.ca','Ap #993-6220 Pede Avenue',1779,3522269304),
  ('Armand','Delacruz',26658441,'vitae.erat@outlook.edu','752-404 Orci. Avenue',2652,3518671126),
  ('Clementine','Beck',39051753,'arcu.morbi.sit@outlook.ca','8035 Ut St.',1973,3536354675),
  ('Laurel','Blair',37005245,'donec@aol.couk','112-2434 Cras Street',2716,3539017717),
  ('Hope','Melendez',26567616,'quisque.imperdiet@aol.net','Ap #268-6674 Fringilla St.',3532,3538129013),
  ('Yasir','Lucas',23829913,'pellentesque.tincidunt@protonmail.org','205-2084 Nec Street',3181,3524670813);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Jason','Haley',40028784,'dolor@icloud.com','3567 Etiam Street',374,3524165205),
  ('Warren','Singleton',39870589,'quam@google.edu','P.O. Box 163, 1132 Erat, Road',679,3516295590),
  ('Russell','Alston',33221586,'semper.et.lacinia@outlook.edu','Ap #774-700 Dapibus Rd.',1034,3522989463),
  ('Pearl','Case',30516613,'curabitur.dictum@icloud.couk','879-9044 Morbi St.',2348,3536912714),
  ('Deacon','Mendoza',34590485,'mollis.vitae.posuere@aol.net','9241 Velit Rd.',1776,3524117712),
  ('Rigel','Clayton',42387322,'velit.eget@icloud.ca','Ap #932-9851 In Rd.',2976,3538722221),
  ('Ignacia','Mccray',42998194,'hymenaeos@aol.edu','P.O. Box 841, 6779 Ad Road',231,3523751918),
  ('Laura','Johns',24944018,'ut.semper@outlook.com','P.O. Box 387, 8532 In Ave',1470,3519495249),
  ('Malik','Boyer',36688067,'duis@google.com','Ap #270-5364 Facilisis St.',473,3516881911),
  ('Damian','Spencer',33460227,'ligula.nullam.feugiat@protonmail.edu','P.O. Box 385, 3015 Imperdiet Rd.',293,3537777812);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Hannah','Evans',24670140,'ac.fermentum.vel@yahoo.net','Ap #181-2240 Nunc Ave',2324,3522410484),
  ('Damian','Whitney',27730171,'urna.ut.tincidunt@aol.edu','262-4334 Aliquet Ave',2310,3520037992),
  ('Montana','Weeks',29079556,'lorem.auctor@yahoo.ca','P.O. Box 585, 218 Congue. Street',2787,3529939103),
  ('Rachel','Stephenson',42603385,'non.lacinia@hotmail.net','797-6497 Dolor. Av.',2561,3529200642),
  ('Jonas','Davenport',35665675,'ultricies.ornare@protonmail.ca','Ap #890-4562 Lobortis Rd.',2005,3518843074),
  ('Buckminster','Padilla',32106942,'sed.eu.eros@aol.ca','834-418 Elit. Street',1129,3521590564),
  ('Miriam','Houston',26403821,'nulla@outlook.org','Ap #822-4610 Quis St.',2890,3537951437),
  ('Dominique','Fry',30547428,'commodo.auctor@hotmail.org','P.O. Box 420, 4978 Lectus, Rd.',2412,3534306692),
  ('Zachery','Lee',26842085,'sed.sapien@protonmail.ca','5109 Odio Rd.',1613,3516287640),
  ('Genevieve','Mack',25798419,'cursus.et@hotmail.couk','Ap #915-7218 Est Ave',588,3535397107);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Alec','Goodwin',33085284,'tellus@aol.edu','Ap #678-1421 Suspendisse Road',2936,3524827800),
  ('Alden','Haynes',41822038,'nascetur.ridiculus@hotmail.com','P.O. Box 108, 1987 Aliquet Avenue',1833,3534355977),
  ('Dennis','Ware',39715878,'posuere@hotmail.edu','655 Urna. Rd.',1080,3524700998),
  ('Georgia','Vance',24789886,'nascetur@yahoo.edu','P.O. Box 346, 3408 Ac, Rd.',2324,3521994190),
  ('Kennedy','Berg',28716956,'nulla.facilisi@google.org','Ap #238-3285 Euismod St.',3228,3537856725),
  ('Ingrid','Mckenzie',41691598,'neque.pellentesque.massa@aol.couk','635-1179 Aliquam Rd.',3492,3520794445),
  ('Britanni','Powell',33568762,'nibh.sit.amet@hotmail.couk','701-7794 Arcu Rd.',2971,3533679581),
  ('Melanie','Frank',27688732,'orci.donec.nibh@google.net','474-173 Nisi Road',2989,3523937716),
  ('Stuart','Rich',36252767,'massa.mauris.vestibulum@google.edu','384-3245 Nec, Avenue',3477,3531108312),
  ('Vaughan','Tate',23472067,'amet.metus.aliquam@protonmail.com','Ap #674-1912 In Avenue',1097,3521239299);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Kennan','Campos',25285929,'etiam.imperdiet.dictum@hotmail.ca','Ap #543-6105 Luctus St.',1827,3529743703),
  ('Demetrius','Duke',26629907,'a@aol.ca','3714 Massa. Rd.',2915,3530064784),
  ('Rafael','Stephenson',28433397,'auctor.velit@google.org','Ap #259-6722 Consectetuer Rd.',2839,3528227737),
  ('Lane','Hamilton',28029397,'eget@aol.couk','Ap #131-6569 Diam St.',3031,3534818133),
  ('Oleg','Norris',29056570,'suspendisse@aol.edu','234-2608 Eu St.',2452,3538951262),
  ('Noah','Levine',42244799,'ligula@yahoo.edu','1062 Aliquam Rd.',2373,3529536237),
  ('Kelsey','Marquez',33291767,'fringilla.euismod@protonmail.ca','1794 Euismod Road',1240,3533278814),
  ('Murphy','Barrett',32462964,'sagittis.felis.donec@icloud.edu','779 Dolor Rd.',2698,3515604080),
  ('Breanna','Stanton',29489731,'congue.turpis@protonmail.com','5347 A Street',3806,3518625341),
  ('Gail','Clements',39689853,'arcu.curabitur@icloud.com','353-9900 Ac St.',3183,3533370189);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Xenos','Mann',27588349,'placerat.eget.venenatis@icloud.net','Ap #112-136 Ullamcorper Rd.',1682,3530612681),
  ('Keith','Montgomery',25379255,'nullam.scelerisque@hotmail.com','178-8482 Scelerisque, Ave',2313,3518517287),
  ('Matthew','Gregory',36221485,'nunc.in.at@hotmail.ca','Ap #604-8731 Cursus Rd.',1193,3526481662),
  ('Omar','Benton',44701938,'at.auctor.ullamcorper@aol.edu','577-6586 Pellentesque, Ave',3149,3515193236),
  ('Scott','Rosales',26006260,'ut.sagittis@icloud.net','Ap #819-7708 Dolor. Rd.',880,3531620190),
  ('Zane','Mendez',33445901,'placerat.orci@google.edu','707-9300 Molestie Av.',2826,3530341798),
  ('Karen','Riddle',37110038,'nonummy@yahoo.couk','Ap #444-8453 Luctus Avenue',2026,3533849667),
  ('Gary','Elliott',44618260,'ligula@hotmail.ca','P.O. Box 254, 5389 Vestibulum St.',2271,3534537620),
  ('Hedda','Wolfe',39861050,'sit@google.org','Ap #592-5488 Sed Rd.',1677,3532676824),
  ('Carson','Curry',34047459,'tristique.ac@google.couk','941-2944 Nulla Rd.',2366,3525773215);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Mollie','Vargas',30313855,'ut@outlook.couk','Ap #848-2562 Donec Street',3838,3529889699),
  ('Austin','Melendez',43318985,'massa.suspendisse.eleifend@protonmail.com','387-6643 Suspendisse Avenue',2088,3518217156),
  ('Bernard','Ferguson',36804776,'lorem.ipsum.dolor@icloud.com','116-3629 A, Avenue',2617,3525235930),
  ('Gil','Miller',43023569,'etiam.bibendum@icloud.com','967-9690 Lorem Ave',3674,3538043333),
  ('Colt','Hurst',37488737,'mus.donec@google.ca','2438 Sed St.',712,3521186446),
  ('Charissa','Ortega',23899016,'donec.consectetuer@protonmail.ca','846-3194 Sed Street',3606,3517633610),
  ('Stone','Valentine',29515348,'nec.quam.curabitur@icloud.ca','Ap #893-8827 Cursus Ave',2312,3532589295),
  ('Ursa','Stuart',40301769,'nunc@google.net','3104 Vitae Rd.',1061,3536388393),
  ('Ariana','Goff',37599822,'tincidunt.neque@hotmail.com','389-6798 Ac St.',614,3516612304),
  ('Winter','Kent',39858591,'eleifend.nunc@icloud.couk','958-1635 Tempor Road',2263,3516642803);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Oprah','Dillard',26378294,'adipiscing.mauris@icloud.ca','P.O. Box 397, 3095 Lorem Rd.',1844,3531232844),
  ('Sawyer','Small',43808412,'nunc@outlook.edu','Ap #672-7898 Vitae Av.',3482,3530202384),
  ('Justine','Moss',39278067,'interdum.sed@outlook.ca','554-7849 Sem St.',870,3535793426),
  ('Isaiah','Bridges',36298751,'sit.amet@icloud.couk','8339 Lectus Street',1292,3529943597),
  ('Hiram','Nguyen',33228833,'donec.sollicitudin.adipiscing@hotmail.com','Ap #774-7971 Tellus Ave',1925,3522886306),
  ('Jacob','Hammond',36884216,'mus.proin@icloud.net','Ap #158-4641 Donec Avenue',3515,3534019047),
  ('Emerald','Cherry',36934761,'mauris.ipsum@google.com','403-3538 Commodo Avenue',675,3528064590),
  ('Demetrius','Ferrell',38273644,'arcu.et@icloud.net','753-2363 Semper St.',3375,3523291850),
  ('Rosalyn','Barnett',25037883,'et.commodo@icloud.net','547-1512 Ac Road',2496,3515333114),
  ('Quynn','Bartlett',23491226,'in@aol.ca','2180 Faucibus Road',3294,3517471005);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Lester','Poole',44075569,'in.mi.pede@protonmail.net','707-8229 Bibendum St.',1776,3539776098),
  ('Dennis','Ortega',43208232,'aliquam.eu@yahoo.net','Ap #306-7439 Sed, Ave',2482,3519153971),
  ('Nigel','Avery',34896478,'nullam.nisl@aol.ca','407-7264 Interdum Rd.',3590,3539910865),
  ('Daryl','Collier',39029690,'euismod.mauris@google.ca','125-5759 Enim. Rd.',3845,3534780741),
  ('Yoko','Walker',23857451,'lorem.lorem@google.edu','Ap #953-7172 Vivamus Street',2718,3518404926),
  ('Sierra','Lindsey',32960612,'nunc@yahoo.edu','P.O. Box 778, 4073 Enim, St.',3423,3537540382),
  ('Aspen','Ball',32745520,'suspendisse.aliquet.sem@hotmail.edu','888-4519 Nec Av.',2442,3517901399),
  ('Leslie','Wallace',38882800,'ipsum@protonmail.edu','Ap #297-5860 Sit Rd.',922,3530545708),
  ('Aimee','Cruz',32296308,'pellentesque.tincidunt.tempus@google.net','P.O. Box 361, 7870 Lobortis Avenue',3342,3517316852),
  ('Camilla','Harmon',35174954,'orci.phasellus@hotmail.org','Ap #814-8210 Faucibus St.',2242,3532902373);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Neve','Snyder',30935915,'proin.mi@yahoo.edu','1071 Enim, Ave',2236,3536017595),
  ('Orla','Melendez',34079097,'dapibus.gravida.aliquam@google.com','Ap #436-7750 Scelerisque, St.',3741,3537230122),
  ('Stewart','Clark',36461691,'ante.blandit@protonmail.com','Ap #914-9072 Magna. Road',3315,3524395793),
  ('Lacy','Elliott',40986829,'velit.justo@icloud.com','5516 Non Rd.',997,3538086154),
  ('Helen','Weiss',24607603,'et@aol.ca','Ap #781-4046 Quis Av.',1212,3524314647),
  ('Ali','Diaz',28554352,'nibh.enim@protonmail.couk','855-6927 Habitant Rd.',1459,3522600505),
  ('Jane','Chambers',36728504,'erat@aol.net','Ap #897-3027 Lorem Ave',3776,3530687518),
  ('Emerson','Lindsey',26631566,'leo.vivamus@hotmail.com','3078 Molestie Rd.',683,3517369583),
  ('Cairo','Huber',44318484,'ut@outlook.edu','Ap #181-319 Urna. Av.',1303,3515647797),
  ('Orson','Hyde',24618518,'mauris.molestie@icloud.net','Ap #257-9468 Sodales Rd.',594,3531357149);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Lareina','Quinn',44787906,'donec.tempor@google.ca','8454 Feugiat St.',294,3522203915),
  ('Nicole','Craig',41533047,'dui.in@google.com','P.O. Box 849, 5929 Vitae Street',276,3530189660),
  ('Jayme','Bernard',41303262,'etiam@hotmail.org','P.O. Box 802, 2313 Duis St.',3015,3530533748),
  ('Melodie','Serrano',25698529,'posuere.vulputate@aol.edu','Ap #198-3817 Sollicitudin Road',1741,3532136316),
  ('Kennan','Rice',37633612,'viverra.donec@protonmail.com','Ap #981-1207 Nunc. Street',2260,3527080458),
  ('Keegan','Peterson',32052403,'tincidunt.aliquam@hotmail.ca','632-7837 Vitae Rd.',3235,3522199636),
  ('Paul','Cruz',35138344,'mauris.erat@protonmail.org','Ap #719-7007 Iaculis Rd.',3508,3533581252),
  ('Kiona','Davis',37562191,'at.augue.id@outlook.ca','P.O. Box 441, 1591 Imperdiet Avenue',3341,3538944009),
  ('Kylan','Tran',32647996,'porttitor@hotmail.com','Ap #937-9105 Consectetuer St.',3871,3530402841),
  ('Freya','Buchanan',39202725,'a.neque@icloud.org','Ap #608-4935 Egestas Rd.',2825,3521607059);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Edan','Gamble',27999158,'arcu.vestibulum@outlook.com','989-6903 Mauris Rd.',3769,3517967935),
  ('Halla','Wall',33182289,'consequat@hotmail.edu','109-6126 Feugiat. Avenue',2089,3536029484),
  ('Christian','Crane',23996856,'turpis.aliquam@protonmail.com','165-1934 Non Road',2015,3530945496),
  ('Darrel','Carpenter',35879346,'mattis.integer@icloud.ca','P.O. Box 236, 2336 Ac St.',436,3517789377),
  ('Sara','Roman',36586700,'sollicitudin@protonmail.org','Ap #664-1327 Vivamus Rd.',2422,3538777317),
  ('Rudyard','Lee',25816541,'malesuada.fames.ac@icloud.couk','8346 Vivamus St.',3968,3525648973),
  ('Kareem','Langley',41422713,'risus.in@hotmail.edu','633-1833 Nostra, Rd.',3341,3521077052),
  ('Blythe','George',42364527,'placerat.eget@hotmail.org','6601 Neque St.',3785,3516070303),
  ('Emery','Sloan',34164916,'pharetra@yahoo.org','1427 Etiam Avenue',1046,3515733691),
  ('Donna','Herring',30167621,'pede@outlook.net','P.O. Box 633, 4672 Tempor Avenue',1102,3537573106);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Grace','Mullins',26488684,'et.euismod.et@google.ca','669-954 Enim Road',1886,3538231108),
  ('Brandon','Mcneil',41504612,'a.odio@icloud.edu','Ap #954-3157 Metus Av.',1197,3535353001),
  ('Brennan','Pope',25214347,'hendrerit.a.arcu@protonmail.couk','458-176 Consectetuer Road',2151,3536993694),
  ('Cheyenne','Manning',29060745,'tristique.senectus.et@protonmail.edu','Ap #386-5087 Sit Rd.',1579,3533230853),
  ('Hu','Fitzpatrick',38039809,'at.libero.morbi@yahoo.com','P.O. Box 728, 2973 Tristique Rd.',2138,3516965130),
  ('Ina','Perry',43909449,'id.sapien@icloud.org','Ap #289-6730 Eget Ave',2818,3519214607),
  ('Gannon','Wiggins',30450407,'risus.nunc@yahoo.edu','Ap #569-2728 Mollis St.',699,3522503263),
  ('Ahmed','Castaneda',41277732,'sed.sem@outlook.org','Ap #178-7699 Proin Rd.',1160,3530239661),
  ('Hamish','Murphy',30691617,'nullam.vitae@protonmail.net','Ap #445-9492 Aenean St.',1722,3517985457),
  ('Galena','Lindsay',43178120,'libero.et.tristique@yahoo.edu','Ap #843-6829 Sem. Rd.',1674,3516766695);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Kalia','Santiago',24404623,'erat@yahoo.org','976-5816 Velit Av.',2390,3533131542),
  ('Ryder','Rivera',30620967,'diam.nunc@yahoo.couk','P.O. Box 350, 7103 Varius Road',2407,3526607693),
  ('Leo','Frazier',41010689,'dolor.egestas@outlook.edu','7600 Hendrerit Rd.',804,3519474591),
  ('David','Delaney',31389497,'natoque.penatibus@outlook.net','Ap #113-5340 Ipsum Rd.',2137,3528675768),
  ('Russell','Stewart',34018362,'scelerisque.neque@outlook.ca','1327 Arcu St.',3753,3518890292),
  ('Ray','Faulkner',37400932,'ipsum.suspendisse@google.couk','9209 Proin Rd.',752,3532763981),
  ('Bruce','Justice',35600788,'justo.eu.arcu@hotmail.org','794-7351 Odio. Rd.',1053,3527389659),
  ('Selma','Livingston',30170400,'nec.urna@hotmail.org','693-9703 Arcu. Avenue',3950,3534162617),
  ('Patrick','Sanchez',25707278,'fermentum.arcu@outlook.ca','Ap #950-1516 Class Street',223,3519847074),
  ('Drake','Mcgee',30198827,'sagittis.placerat@hotmail.edu','137-8361 Per St.',3773,3530996244);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Xantha','Battle',33257224,'purus.duis.elementum@hotmail.com','Ap #390-2316 Eros Av.',189,3526616090),
  ('Haley','Rogers',35708563,'odio.a.purus@hotmail.net','945-9759 Dolor, Street',230,3517225657),
  ('Patience','Ray',31370447,'elit.erat@aol.edu','Ap #703-8573 Ornare Street',471,3525556823),
  ('Rudyard','Knight',28342812,'non.hendrerit@yahoo.edu','P.O. Box 482, 9009 Donec Ave',3371,3517515143),
  ('Luke','Haley',38842113,'nisl.maecenas@hotmail.net','183-7835 Mauris, Street',750,3518082261),
  ('Serena','Prince',23355826,'eu.eros.nam@outlook.ca','7628 Sed Rd.',2402,3530552505),
  ('Oren','Rowe',38009274,'scelerisque.scelerisque@aol.ca','P.O. Box 113, 4983 Vivamus Avenue',3127,3523358261),
  ('Jana','Mcneil',25732737,'adipiscing@outlook.couk','Ap #986-9597 Dui. St.',2763,3532092833),
  ('Lesley','English',25993150,'dictum.placerat@google.com','P.O. Box 403, 7578 Dictum Rd.',430,3519903647),
  ('Coby','Mcknight',43966153,'a.nunc.in@protonmail.org','Ap #152-208 Nisi. Av.',2836,3534298870);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Helen','Todd',32636993,'integer.tincidunt@aol.edu','175-5052 Consectetuer, Road',442,3515432576),
  ('Judith','Horne',41330360,'consequat.purus@aol.org','110-8146 Bibendum Avenue',2078,3528466012),
  ('Laurel','Decker',31476793,'congue.in@hotmail.ca','Ap #361-6322 Dictum Avenue',584,3518135429),
  ('Indigo','Floyd',28613369,'mi.felis@outlook.net','656-5137 Mollis St.',2311,3528655198),
  ('Ethan','Perez',26464225,'iaculis@outlook.edu','936-6995 Mus. Ave',2972,3536144086),
  ('Omar','Skinner',40791590,'aliquam.adipiscing.lobortis@yahoo.net','8408 Molestie Street',935,3527346823),
  ('Castor','Crosby',40319696,'imperdiet.nec@icloud.com','Ap #891-1584 Augue Ave',1702,3527080451),
  ('Ryder','Cummings',25720163,'mollis.nec@aol.edu','Ap #840-4520 Quisque Avenue',390,3538702421),
  ('Rhiannon','Williams',44702190,'ut.nec.urna@google.net','Ap #907-2111 Nulla Av.',1366,3515289731),
  ('Yoshi','Morgan',26486932,'neque.venenatis@outlook.couk','P.O. Box 967, 6348 Augue Av.',2351,3532875420);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Chancellor','Wheeler',41822167,'lobortis.quis@aol.edu','P.O. Box 831, 2900 Et, Rd.',1802,3528378284),
  ('Tanisha','Delacruz',38801536,'amet.metus@hotmail.net','6274 Tellus Road',879,3535910925),
  ('Louis','Watkins',25863626,'posuere@protonmail.couk','3143 Ullamcorper. St.',1874,3527838255),
  ('Darryl','Rodriquez',26537048,'lobortis.ultrices@protonmail.net','P.O. Box 404, 3312 Facilisis Street',2897,3528092595),
  ('Gail','Strong',37531984,'inceptos.hymenaeos.mauris@yahoo.edu','Ap #237-3102 Nulla St.',1565,3537607788),
  ('Oprah','Newman',25473361,'turpis@aol.edu','P.O. Box 410, 2926 Quam. Rd.',2008,3522329923),
  ('Carolyn','Lara',33349773,'posuere.cubilia@google.net','Ap #938-6163 Tempor St.',1839,3519946942),
  ('Kirby','Hines',40375862,'enim.gravida@yahoo.com','687-8951 Dolor. St.',2127,3532221346),
  ('Cheryl','Gaines',23889507,'velit.pellentesque@google.edu','P.O. Box 244, 1702 Vivamus Rd.',2772,3527126239),
  ('Carissa','Brady',42610635,'ipsum.dolor@icloud.org','898-4435 Tristique Avenue',2002,3521969734);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Bethany','Francis',24167589,'in.aliquet@outlook.couk','951-6222 Ac Rd.',183,3524510777),
  ('Graham','Chapman',24375138,'enim.commodo.hendrerit@aol.edu','5336 Velit. Avenue',421,3532037909),
  ('Jolene','Clay',34342188,'arcu@aol.org','708-7406 Augue, Street',2605,3539829169),
  ('Tyrone','Barnett',30621821,'neque.in@yahoo.com','Ap #601-8022 Non, Avenue',3736,3538599419),
  ('Mohammad','Wade',41200108,'et.rutrum.eu@protonmail.org','426-2263 Vitae, Street',2416,3530910219),
  ('Savannah','Schmidt',28813405,'montes.nascetur.ridiculus@outlook.edu','Ap #714-582 Enim Ave',2505,3526000411),
  ('Signe','Shaw',37464057,'lorem.ipsum@protonmail.couk','Ap #142-3557 Nunc Avenue',902,3520996449),
  ('Michael','Church',25506536,'nec.leo@aol.net','9697 Mauris Ave',376,3519069075),
  ('MacKensie','Shields',37859778,'aliquam.nisl@aol.org','P.O. Box 403, 592 Sociis Street',709,3517739127),
  ('Melodie','Morrison',26978155,'vestibulum@outlook.net','418-6459 Justo Av.',825,3516898000);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Alec','Dennis',29469825,'quis.lectus.nullam@aol.org','1298 Aliquet. Road',588,3523865831),
  ('Meredith','Patton',36644272,'gravida.non@aol.couk','247-4041 Ante Avenue',366,3529238083),
  ('Aladdin','Lester',41524392,'placerat@icloud.couk','P.O. Box 606, 5691 Eget, St.',2070,3531756099),
  ('Julie','Owen',29829242,'sagittis.semper.nam@protonmail.edu','P.O. Box 138, 7785 Libero Road',476,3520609564),
  ('Aspen','Tanner',29233418,'elit.pede@yahoo.org','199-9251 Dis St.',641,3523483532),
  ('Calista','Pope',24974253,'magna@protonmail.couk','P.O. Box 349, 1849 Cursus. Av.',613,3535735683),
  ('Zachary','Castro',30471180,'sit@aol.ca','Ap #828-7318 Felis. Av.',1982,3537568877),
  ('Kameko','Cunningham',42196856,'sed@icloud.com','Ap #278-3110 Volutpat Avenue',3580,3537161557),
  ('Justin','Huber',43958957,'ornare@yahoo.edu','Ap #192-5001 Pharetra Street',995,3530599758),
  ('Garrett','Albert',40893380,'aliquet.magna@icloud.ca','2190 Et Ave',3491,3534821356);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Cody','Patrick',39605064,'sed.diam@yahoo.ca','2626 Erat. Avenue',1004,3532748413),
  ('Vaughan','Klein',29583180,'ut@yahoo.couk','P.O. Box 395, 9016 Suspendisse Rd.',1286,3529133460),
  ('Kylynn','Blackburn',31566784,'id.enim@yahoo.couk','218-8773 Sem Road',1083,3522080791),
  ('Kylynn','Kelley',29666658,'suspendisse.sagittis.nullam@icloud.com','P.O. Box 894, 3004 Et Road',1879,3535994379),
  ('Castor','Lopez',38899733,'et.lacinia@google.com','P.O. Box 689, 6099 Purus Rd.',1250,3515404009),
  ('Raymond','Warren',26717753,'ante@aol.edu','P.O. Box 214, 9589 Pellentesque, Av.',187,3524446538),
  ('Marvin','Dotson',29203947,'donec.at@aol.org','689-8795 Dui Avenue',427,3538227705),
  ('Brenna','Everett',32897847,'cursus.non@hotmail.com','Ap #152-2633 Et, Rd.',1849,3534801386),
  ('Denton','Owens',43835297,'pede@google.ca','284-9895 Fusce Avenue',3258,3520883834),
  ('Armando','Spears',35381125,'donec.feugiat.metus@google.com','Ap #940-7850 Quis, Road',2548,3529226146);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Adrienne','Bullock',29646486,'vitae.velit.egestas@icloud.com','3322 Tempus Rd.',2675,3533424914),
  ('Kareem','Spears',32224532,'sed.orci@icloud.ca','Ap #749-2097 Metus Rd.',3072,3516932727),
  ('Arden','Ford',24500580,'nec.eleifend.non@aol.couk','275-9620 Vulputate Ave',3596,3523770041),
  ('Brock','Herman',30973989,'ultrices@google.edu','Ap #879-373 Neque. Road',1833,3515431449),
  ('Margaret','Frederick',39724350,'nascetur@icloud.edu','4727 Nulla Avenue',1685,3523214795),
  ('Harriet','Burton',32520354,'hendrerit.neque@outlook.net','768-7995 Consequat Ave',735,3524132537),
  ('Ahmed','Patel',30998747,'et@yahoo.ca','3427 Dolor Rd.',2034,3522337130),
  ('Quintessa','Ellis',29203326,'eu@aol.edu','Ap #754-1976 Dignissim Av.',2725,3517833462),
  ('Ezekiel','Franco',24168663,'arcu.sed@hotmail.edu','116-2646 Nullam Rd.',934,3520378671),
  ('Hyatt','Dean',41077849,'ante.dictum@outlook.net','Ap #197-9641 Non Street',3168,3535841648);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Jessica','Cote',42537225,'turpis.non@google.couk','133-3209 Vitae St.',2653,3524482104),
  ('Paula','Tanner',23873539,'cras.interdum.nunc@icloud.ca','P.O. Box 137, 4121 Enim St.',3222,3523023710),
  ('Xanthus','Mendez',30578222,'laoreet.lectus@outlook.edu','592-523 Sed, Street',2612,3515421274),
  ('Finn','Bush',37815472,'quam@yahoo.couk','691-1332 Blandit Ave',2208,3534338666),
  ('Christen','Meyers',44442586,'aliquam@aol.org','4955 Urna Ave',1882,3534615376),
  ('David','Evans',44091746,'dui.nec@aol.com','466-5717 Et, Road',247,3519873612),
  ('Pandora','Eaton',28065361,'lorem@aol.edu','973-4201 Massa. Rd.',872,3525148723),
  ('Candace','Gallagher',23049023,'curabitur@google.edu','Ap #464-8069 Imperdiet Rd.',1700,3515878520),
  ('Lani','Compton',37928136,'a@aol.org','380-7249 Auctor, Road',2755,3529579744),
  ('Omar','Francis',36261838,'vitae.diam@aol.net','Ap #525-5599 Imperdiet St.',3104,3535863590);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Yolanda','Lopez',41974007,'ornare@outlook.net','P.O. Box 939, 7363 Natoque St.',1867,3522968130),
  ('Hayes','Mccoy',33927368,'per.conubia.nostra@aol.net','9281 Sociis St.',3051,3520811952),
  ('Raja','Matthews',36239078,'blandit.at@yahoo.com','Ap #269-5301 Vivamus Rd.',1416,3516313292),
  ('Regan','Barlow',29922225,'blandit.at.nisi@google.net','475-6388 Class St.',1986,3519200896),
  ('Kiayada','Simpson',34217691,'aliquet.vel@google.edu','Ap #409-8816 Enim St.',3308,3533989564),
  ('Hilary','Ortiz',38076421,'aliquet.proin@google.com','Ap #103-3171 Aenean Av.',1588,3533210301),
  ('Brenden','Stuart',35097944,'cras.pellentesque@google.org','Ap #903-2801 Pellentesque Av.',2593,3517054164),
  ('Hilda','Hutchinson',39531908,'venenatis.a@google.couk','479-4408 Nunc Av.',120,3525256751),
  ('Jermaine','Macdonald',24139022,'ante.nunc@hotmail.ca','Ap #402-3532 Sollicitudin Rd.',412,3535569150),
  ('Vernon','Mcneil',42974398,'sodales.at@aol.org','Ap #673-4700 Ornare, Ave',2613,3534887600);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Jena','Fowler',35065312,'eget.laoreet.posuere@protonmail.com','645-7237 Sapien. Avenue',581,3517721526),
  ('Dale','Shepard',29107288,'urna.ut@hotmail.ca','Ap #167-4425 Ultricies Ave',163,3518726218),
  ('Cailin','Poole',39479031,'nunc.lectus@aol.net','489 Nunc Street',1519,3524857423),
  ('Deborah','Wood',25783955,'donec@aol.couk','894-8149 Amet Ave',1658,3515072122),
  ('Donovan','Rivas',32311966,'mi@outlook.com','942-188 Non, Rd.',1004,3519139738),
  ('Asher','Craft',40129480,'quis.turpis@outlook.ca','1756 Iaculis Avenue',1391,3529850708),
  ('Jasper','Hurst',41266025,'feugiat.nec@yahoo.com','614-3956 Non, Ave',2441,3534437677),
  ('Tobias','Flowers',30620197,'erat.semper.rutrum@hotmail.com','6567 Ornare St.',3411,3533430418),
  ('Dieter','Vincent',32867507,'mauris.sapien.cursus@outlook.ca','Ap #753-4567 Aliquet Avenue',1570,3534944506),
  ('Paloma','Bradshaw',39774124,'enim.gravida.sit@outlook.ca','Ap #130-8602 Tellus, Rd.',160,3519020175);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Cole','Waller',25949436,'integer.eu.lacus@icloud.org','Ap #631-8447 Aliquet Av.',2845,3523945467),
  ('Colby','Lindsay',29826759,'semper.tellus@google.couk','690-1351 Eget Rd.',2752,3533901124),
  ('Erica','Freeman',36193488,'mauris.eu.turpis@yahoo.couk','P.O. Box 715, 2984 Neque Av.',2406,3539737226),
  ('Ryder','Nichols',33320363,'facilisis.facilisis@google.net','5518 Integer Street',114,3527733539),
  ('Ali','Vaughan',44099564,'ad.litora.torquent@outlook.net','P.O. Box 603, 6958 Fusce Ave',3167,3537937019),
  ('Hayes','Pruitt',37111228,'donec.luctus.aliquet@yahoo.org','871-4574 In, Ave',2255,3515820363),
  ('Thane','Randall',35077678,'ultricies@yahoo.net','1642 Tincidunt Road',1781,3523366947),
  ('Darrel','Cameron',29161265,'dolor.elit.pellentesque@google.com','Ap #609-5989 Aliquet Road',3441,3530796799),
  ('Rose','Branch',34403632,'nascetur.ridiculus@hotmail.org','353-7000 Molestie Rd.',1127,3521048754),
  ('Elmo','Reyes',41578004,'dictum.sapien.aenean@yahoo.edu','792-8472 Vitae St.',624,3537938069);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Robin','Levine',43463138,'nunc.mauris.sapien@aol.com','105-4913 Elit St.',1853,3517465285),
  ('Leah','Spears',37650859,'erat.eget.ipsum@outlook.edu','P.O. Box 111, 6684 Dis Street',1443,3520684297),
  ('Lee','Reed',28695628,'sociis.natoque.penatibus@google.edu','Ap #290-6865 Mattis St.',3011,3529237804),
  ('Rae','Garner',44476077,'accumsan.interdum@outlook.com','Ap #556-5282 Sed St.',1138,3520454256),
  ('Quentin','Wilson',26178550,'non.ante.bibendum@aol.edu','Ap #154-1150 In Street',3035,3525897542),
  ('Thomas','Sparks',42277184,'molestie@icloud.org','Ap #291-5847 Interdum Ave',2269,3521613395),
  ('Basil','Sherman',39039385,'vel.sapien@google.edu','P.O. Box 765, 595 Mi. Rd.',543,3532835307),
  ('Zeph','Preston',26280418,'nec.ante.maecenas@hotmail.org','9406 Elementum Rd.',605,3516309040),
  ('Stephen','Kelley',44004152,'a.nunc@yahoo.ca','348-7416 At, Avenue',1868,3528150203),
  ('Cora','Robertson',28216008,'et.malesuada.fames@google.edu','P.O. Box 788, 8277 Tempus, Street',147,3516311547);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Cameron','Cabrera',43635994,'ut@yahoo.ca','307-2476 Urna Avenue',2276,3539431179),
  ('Paul','Kane',25058630,'lectus@protonmail.com','8553 Id, St.',678,3521082258),
  ('Daquan','Valentine',33045948,'facilisis.vitae.orci@protonmail.couk','P.O. Box 126, 8483 Sodales St.',1008,3535405860),
  ('Gary','Garrett',23347574,'pede@yahoo.couk','822-2886 Vitae, Rd.',3499,3529359626),
  ('Adrian','Flowers',35689321,'nulla.dignissim.maecenas@outlook.org','P.O. Box 737, 1200 Nec, Av.',1343,3515050017),
  ('Hilary','Berg',34551111,'in@hotmail.com','Ap #883-4954 Ante. Ave',1170,3538461288),
  ('Doris','Guzman',38062459,'sed.id@hotmail.com','Ap #997-2624 Sed Rd.',1537,3525273506),
  ('Calvin','Burt',27785938,'adipiscing.lacus@outlook.couk','6789 Blandit Av.',1449,3534739203),
  ('Julie','Turner',40099465,'eu@protonmail.ca','Ap #568-205 A Rd.',351,3523229564),
  ('Wynter','Prince',42910974,'non.luctus.sit@outlook.com','P.O. Box 770, 7006 Quis Ave',2641,3537599013);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Tanya','Phelps',24611214,'vel.nisl.quisque@aol.edu','Ap #598-3513 Ut Street',2160,3531431058),
  ('Stuart','Huff',35751377,'integer.sem@yahoo.edu','989-7324 Praesent Road',3811,3522661379),
  ('Ariel','Cote',29256404,'enim.nunc@aol.ca','Ap #577-5148 Aenean Road',1013,3521505039),
  ('Chanda','Dominguez',34058749,'dictum.mi.ac@google.org','210-3328 A, Avenue',3065,3516703680),
  ('Quinn','Riggs',43969508,'orci.ut@hotmail.com','841-7579 Arcu Rd.',3177,3517324704),
  ('Caldwell','Stafford',39437620,'donec.sollicitudin@hotmail.net','1911 Scelerisque Street',494,3534802425),
  ('Blythe','Peters',44814834,'donec@icloud.edu','Ap #628-8679 Sed St.',2996,3528750305),
  ('Dana','Jackson',43351803,'et.malesuada@icloud.ca','Ap #366-2942 Proin St.',3015,3533143578),
  ('Hop','Kinney',30885501,'vel.faucibus@hotmail.ca','Ap #832-1291 Rutrum Road',2183,3535259121),
  ('Bruno','Castro',31401018,'orci.sem@yahoo.org','Ap #804-2996 Luctus Road',1445,3522785140);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Mari','Paul',23047805,'viverra.maecenas@hotmail.org','Ap #792-4994 Ut Ave',3938,3528653988),
  ('Louis','Kinney',38223476,'dolor.sit@outlook.net','Ap #142-5832 Purus Road',368,3526889215),
  ('Philip','Walls',23018818,'in.at@icloud.couk','Ap #368-364 Nec Av.',3736,3527546406),
  ('Cora','Callahan',28968227,'tellus.justo.sit@protonmail.ca','486-1764 Mattis Road',2916,3529238355),
  ('James','Hill',42907130,'parturient.montes.nascetur@hotmail.edu','963-2123 Ridiculus Road',3888,3523003230),
  ('Logan','Pierce',33896079,'quis.tristique.ac@yahoo.couk','664-6715 Massa St.',120,3524848124),
  ('Ayanna','Grant',32095473,'at@outlook.ca','Ap #914-2903 Mi Road',134,3529023887),
  ('Skyler','Pennington',29948598,'sed.eget@google.net','711-6984 Scelerisque Avenue',1698,3530117995),
  ('Vladimir','Buckley',25324359,'mauris@google.couk','4729 Facilisis St.',3213,3529055521),
  ('Stacy','Little',23687517,'nunc.est.mollis@protonmail.couk','196-2161 Vivamus Rd.',1712,3521130967);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Paul','Kirkland',31090522,'mi.lorem@aol.couk','P.O. Box 592, 2767 Aliquam St.',1440,3515093043),
  ('Damon','Castro',33594763,'nonummy.fusce@hotmail.couk','3581 Vulputate Av.',1833,3530235667),
  ('Grace','Mckinney',29969531,'eu@hotmail.com','P.O. Box 198, 3589 Sem, Ave',3373,3529073401),
  ('Althea','Sweeney',29364998,'tellus.lorem@google.net','458-9260 Pede. Street',3543,3531730007),
  ('Alec','Jennings',35097283,'dolor.donec@outlook.com','353-1041 Gravida. Avenue',1188,3519203858),
  ('Ulric','Merrill',32041374,'fringilla@outlook.org','P.O. Box 178, 3425 Fermentum St.',3459,3539567401),
  ('Mona','Wright',43979521,'lacinia.vitae@google.couk','P.O. Box 838, 4898 Ipsum. Avenue',2958,3518453977),
  ('Victor','Madden',42639408,'dignissim.tempor.arcu@hotmail.com','P.O. Box 360, 8266 Eleifend, Ave',541,3518533378),
  ('Hayes','Ramsey',43915345,'porttitor.interdum@icloud.org','Ap #549-5353 Est, Road',2248,3528930704),
  ('Emerson','Gallegos',24680117,'pellentesque.eget.dictum@aol.net','179-4112 Neque. St.',976,3537144739);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Bethany','Head',35256947,'nec@outlook.edu','5271 Quam Av.',2902,3519310262),
  ('Malcolm','Brennan',42522411,'risus@google.couk','9500 Vitae, Avenue',3375,3531787262),
  ('Cassandra','Terrell',33765398,'quisque.purus.sapien@google.net','182-4561 Accumsan St.',2574,3528812492),
  ('Orson','Walsh',26662480,'cras@aol.org','757-7235 Convallis Road',1790,3530196728),
  ('Charlotte','Walton',36212829,'pede@outlook.couk','Ap #326-8555 Fusce Ave',1018,3528159117),
  ('Boris','Owen',40407852,'cum.sociis.natoque@outlook.net','Ap #354-7916 Urna. Street',812,3518742918),
  ('Maggy','Conway',42127705,'dolor.nulla.semper@protonmail.edu','P.O. Box 558, 8884 Phasellus Street',3023,3527782841),
  ('Carlos','Avery',37461685,'proin.dolor@hotmail.com','Ap #596-1779 Cras St.',769,3530611946),
  ('Ryder','Terrell',26161425,'praesent.interdum.ligula@aol.com','Ap #164-1898 Porta St.',3338,3516837283),
  ('Malcolm','Kaufman',29286143,'lorem.semper@yahoo.edu','Ap #194-6391 Facilisis St.',2945,3522381855);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Oleg','Conner',40539921,'nunc.ullamcorper@aol.net','595-1063 Lacinia Rd.',1934,3516028588),
  ('Xanthus','Carpenter',30917255,'magna.et@aol.org','P.O. Box 639, 6189 Proin St.',1014,3528018777),
  ('Faith','Bush',37296596,'morbi.metus@protonmail.com','279-7700 Ac Ave',3030,3528208800),
  ('Oprah','Hatfield',37586973,'ornare.lectus@icloud.edu','241-3883 Pretium Rd.',1214,3537432481),
  ('Denton','Porter',34562809,'leo.cras@hotmail.org','4498 Turpis St.',3051,3527597303),
  ('Rina','Camacho',28457030,'proin.nisl@icloud.ca','919-2142 Natoque St.',3483,3536209539),
  ('Maya','Shepard',25429188,'sollicitudin.orci.sem@google.edu','8101 Justo. Rd.',2276,3538860228),
  ('Ivor','Blake',39291967,'nisi.nibh.lacinia@outlook.org','P.O. Box 237, 1069 Sit Street',1511,3534427558),
  ('Gil','Roach',30237102,'dui@hotmail.com','286-8159 Eget, St.',577,3524008118),
  ('Susan','Boyd',38810546,'ornare.facilisis.eget@aol.net','714-1963 Ut, Av.',275,3530948161);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Ronan','Stark',31999506,'sem@aol.com','623-6194 Sit Ave',1472,3539061383),
  ('David','Stephens',42077599,'ante.dictum@hotmail.com','929-8508 Nam St.',3758,3538157297),
  ('Jordan','Russell',39073419,'adipiscing.enim@yahoo.ca','Ap #698-9984 Nunc Road',3008,3539668514),
  ('Elton','Koch',30837821,'pede.ultrices@yahoo.org','3368 Dui. Road',1419,3527614704),
  ('Moses','Rodgers',38135360,'erat@outlook.edu','8279 Dolor Avenue',3076,3525907349),
  ('Emmanuel','Case',30855849,'aenean.sed@outlook.com','209-2596 Magna. Rd.',2655,3538647874),
  ('Lee','Lee',38351986,'et.lacinia@google.ca','699-7818 Nonummy St.',2959,3535840027),
  ('Josephine','Erickson',43180727,'dolor@aol.org','Ap #997-1311 Luctus St.',2865,3522750639),
  ('Jaime','Castillo',39754110,'tristique@google.edu','Ap #861-7823 Est, Ave',473,3535115786),
  ('Amal','Hood',30165581,'etiam.vestibulum.massa@icloud.org','Ap #121-6462 Vitae St.',866,3526163744);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Kermit','Estrada',24615601,'aenean.gravida@icloud.edu','495-6889 Sem, St.',506,3532210411),
  ('Leigh','Macias',42199899,'eu.enim.etiam@google.org','Ap #701-8788 Risus. Rd.',360,3539143758),
  ('Deborah','Dickson',28224692,'cursus.a@yahoo.edu','P.O. Box 194, 1197 Cursus, Road',1805,3532793011),
  ('Aurelia','Henson',23482344,'lorem.auctor.quis@icloud.com','7232 Ligula. Av.',3946,3537701361),
  ('Maya','Mcclure',44477590,'non.arcu.vivamus@google.net','7386 Sem Rd.',1246,3517117201),
  ('Shad','Baird',39348707,'tellus.eu.augue@aol.org','3922 Tincidunt Rd.',3033,3517719523),
  ('Cara','Leon',24586174,'mauris.integer@hotmail.edu','8758 Aliquam, St.',3507,3539881035),
  ('Ginger','Salas',26485344,'egestas.lacinia.sed@protonmail.net','513 Sed Road',2324,3521218411),
  ('Gillian','Cardenas',38633623,'aliquet.nec@protonmail.edu','Ap #147-3833 Sit Road',2188,3518331498),
  ('Kieran','Robbins',33053738,'nec.metus@protonmail.ca','210-2992 Pharetra. Av.',1358,3522176153);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Reece','Holloway',26032266,'a.odio@yahoo.edu','436-2201 Ultrices. St.',1867,3516002474),
  ('Quintessa','English',27690558,'cum@google.edu','P.O. Box 977, 2465 Rutrum Avenue',2033,3527464199),
  ('Wing','Hines',41676465,'ac.eleifend@protonmail.net','9744 Ornare, Street',3086,3523424062),
  ('Gemma','Chaney',23472041,'consectetuer@google.org','888-7306 Odio. Ave',2433,3534698933),
  ('Baker','Morse',31996648,'libero.donec.consectetuer@google.org','436-6594 Sed Ave',1947,3532184620),
  ('Jacqueline','Alston',34074556,'donec.egestas@icloud.org','527-9493 Ac Road',1200,3515240942),
  ('Kiona','Kerr',27945402,'in@outlook.ca','Ap #633-2451 Eros St.',3226,3522076602),
  ('Odessa','Baird',34770385,'phasellus@aol.org','948-7626 Dolor Rd.',3248,3527232822),
  ('Miranda','Case',40820761,'molestie.orci@aol.org','P.O. Box 768, 510 Nunc Street',3588,3526132813),
  ('Alea','Morales',42674383,'amet.metus@aol.net','330-6020 Vitae, Rd.',2840,3515716967);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Kennedy','Mueller',23979644,'cum@aol.couk','Ap #352-6834 Luctus St.',687,3533183983),
  ('Autumn','Hooper',37841725,'pede.nec.ante@aol.org','3411 Consequat Road',989,3515603970),
  ('Gannon','Kim',28290942,'in.hendrerit.consectetuer@google.couk','4736 Pellentesque Rd.',1345,3539136651),
  ('Hall','Barrera',40157184,'metus.vivamus@icloud.com','Ap #438-8087 Nisi Rd.',1095,3533143594),
  ('Shaeleigh','Moran',33972564,'consectetuer.adipiscing.elit@google.com','Ap #445-5397 Cum Road',1607,3528935603),
  ('Alma','Rios',34526990,'justo@google.org','P.O. Box 201, 4041 Scelerisque Rd.',2616,3526682231),
  ('Emi','Chavez',33730936,'nunc.quis@google.net','248-141 Integer St.',2309,3539553078),
  ('Ann','Smith',34845210,'odio@google.com','2594 In Rd.',3459,3534319231),
  ('Judith','Dale',44017286,'sed.id@aol.org','Ap #827-7600 Id Street',3983,3531285057),
  ('Zelenia','Carson',31079945,'mollis.lectus@google.org','P.O. Box 167, 4545 Vulputate St.',2276,3519141894);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Zenia','Hampton',31360873,'luctus@icloud.org','Ap #989-7666 Est Rd.',3518,3524209006),
  ('Jayme','Mason',30742890,'a.feugiat@protonmail.com','Ap #490-8555 Sit Street',1415,3527047509),
  ('Acton','Kemp',25173526,'nec.quam@yahoo.com','9335 Aliquam Avenue',2272,3522342994),
  ('Norman','Wood',38409874,'sed@yahoo.com','Ap #988-3424 Fusce Rd.',1428,3523225332),
  ('Halee','Barr',32616787,'aliquet.vel@outlook.org','5294 Aliquam Rd.',3396,3527544438),
  ('Barclay','Donaldson',34608305,'felis.purus@protonmail.couk','P.O. Box 266, 6919 Orci Rd.',623,3520760934),
  ('Dante','Hubbard',44254097,'lacus.pede@hotmail.com','308-2760 Adipiscing Av.',2273,3519332329),
  ('Kuame','Carney',44942152,'non.egestas@yahoo.net','Ap #562-6318 Sit Rd.',2547,3527041014),
  ('Reuben','Mcintyre',40480049,'nullam.enim@outlook.net','Ap #969-811 Sem, St.',2245,3532485764),
  ('Shad','Aguilar',34368598,'varius.et@yahoo.org','228-6163 Et, Street',3253,3531008638);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Odysseus','Gay',31015694,'accumsan.convallis@google.com','Ap #201-5260 Scelerisque Avenue',2464,3523969469),
  ('Ronan','Pratt',35504935,'consequat@icloud.com','704-3362 Fusce Ave',1351,3534332578),
  ('Paloma','Payne',42122424,'vulputate.risus@google.net','P.O. Box 618, 2059 Ut, St.',2366,3538793737),
  ('Omar','Kim',36651335,'egestas.a@protonmail.com','Ap #368-1486 Dolor St.',3338,3527822961),
  ('Kyle','Davis',33869313,'egestas.aliquam@protonmail.edu','600 Sem Road',1493,3520762148),
  ('Denton','Lucas',44474655,'tristique.pellentesque@yahoo.ca','Ap #271-2397 Leo, Ave',3008,3518820480),
  ('Dorian','Davis',27067126,'ante@yahoo.com','517-9311 Diam. Rd.',3026,3525432239),
  ('Audra','Byrd',33246119,'eleifend.cras.sed@aol.edu','602-2928 Natoque Ave',164,3536671392),
  ('Nyssa','Moran',30346593,'ut.pharetra.sed@hotmail.ca','P.O. Box 734, 9389 Eleifend, Rd.',2010,3522679436),
  ('Odessa','Faulkner',41767385,'eget.massa.suspendisse@icloud.net','141-7070 Pharetra. Av.',2554,3529375875);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Gary','Briggs',34795055,'non.enim@google.edu','727-2990 Orci Rd.',3466,3539083407),
  ('Norman','Maxwell',43882377,'nunc.ac@protonmail.org','844-4128 Adipiscing St.',2349,3529060580),
  ('Cora','Harris',30963793,'eu.tempor@hotmail.com','Ap #271-4334 Ornare, Street',3015,3518081459),
  ('Griffin','Chaney',37344198,'augue.sed@protonmail.org','Ap #996-8241 A Ave',1257,3537212707),
  ('Oscar','Walters',38233757,'ultrices.duis@icloud.com','Ap #362-7942 Et, St.',494,3525266783),
  ('Janna','Atkinson',25519970,'semper@google.couk','241-1352 Lorem Rd.',1396,3517952779),
  ('Brett','Benjamin',26265909,'sagittis.placerat@google.ca','P.O. Box 741, 9726 Massa. Rd.',1915,3535139260),
  ('Lars','Christian',37862079,'cursus.luctus@icloud.ca','5402 Sed Rd.',3592,3539276618),
  ('Otto','Wright',38711749,'et@google.couk','612-2049 Ullamcorper Avenue',3891,3524354815),
  ('Josephine','Craig',32537706,'erat@aol.ca','Ap #442-5061 Nulla Rd.',2841,3521438859);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Clinton','Klein',33811056,'et.arcu.imperdiet@google.net','1210 Sociis St.',3111,3535157514),
  ('Barbara','Villarreal',23576331,'commodo.tincidunt.nibh@hotmail.couk','P.O. Box 827, 8413 Egestas Road',2855,3520244990),
  ('Duncan','Rodriquez',26544048,'consectetuer.adipiscing@outlook.edu','P.O. Box 891, 5073 Taciti Avenue',581,3518662956),
  ('Jacqueline','Price',36478402,'dapibus.rutrum@google.edu','Ap #491-5889 Vitae, Road',1262,3532831383),
  ('Chastity','Hull',30885848,'felis.orci@outlook.com','8050 Aliquet St.',975,3538214171),
  ('Devin','Stephens',37221860,'ac.feugiat.non@aol.couk','Ap #814-3769 Nulla Av.',3969,3523106631),
  ('Camille','Donovan',31283283,'faucibus.id@icloud.org','Ap #892-6821 Amet, Ave',241,3527076169),
  ('Jacob','Hamilton',31332468,'aliquam.iaculis.lacus@icloud.net','527-7254 Eros. Rd.',2870,3518063690),
  ('Elliott','Ellison',43441382,'phasellus.ornare@yahoo.ca','Ap #523-4949 Suspendisse St.',706,3516706579),
  ('Colton','Shaffer',39657435,'non.lobortis.quis@icloud.net','8676 Felis Road',838,3516465681);
INSERT INTO [clientes] (nom_cliente,ape_cliente,dni_cliente,email,calle,altura,telefono)
VALUES
  ('Desiree','Shelton',32064532,'facilisis.eget.ipsum@aol.edu','324-250 Quisque Rd.',139,3517723795),
  ('Alea','Leon',29524137,'in.consectetuer@protonmail.couk','Ap #765-8827 Vulputate, St.',2592,3531087893),
  ('Callum','Alvarado',31942411,'lobortis.quam.a@icloud.net','Ap #835-905 Auctor. Ave',149,3536574051),
  ('Louis','Lynch',25055660,'parturient.montes@google.org','Ap #327-2772 Odio. Road',1110,3536588651),
  ('Wing','Holmes',39360769,'nunc.ac@yahoo.edu','144-6508 Egestas Rd.',918,3536673644),
  ('Olivia','Brown',33313713,'neque.sed.dictum@outlook.org','Ap #676-9980 Eget, Rd.',3704,3525781118),
  ('Roanna','Willis',43589643,'sapien.cras@yahoo.ca','8058 Curabitur Rd.',1470,3518708302),
  ('Remedios','Norman',41302287,'facilisis.non.bibendum@protonmail.couk','545-8459 Feugiat St.',881,3516859358),
  ('Kuame','Haney',25664173,'dignissim.lacus@protonmail.org','203-4974 Nullam St.',1295,3535122097),
  ('Beck','Bender',30658020,'phasellus.libero.mauris@google.couk','165-6216 Nulla Road',1534,3516782280);


--salas
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (1)
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (1)
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (2)
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (2)
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (3)
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (3)
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (4)
INSERT [dbo].[Salas] ([id_tipo_sala]) VALUES (5)

--butacas
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (1)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (2)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (3)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (4)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (5)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (6)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (7)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)
INSERT [dbo].[Butacas] ([id_sala]) VALUES (8)

--peliculas
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Cadena Perpetua', 144, 1)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El padrino', 175, 2)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El caballero oscuro', 152, 3)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'12 hombres sin piedad', 96, 4)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'La lista de Schindler', 205, 5)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El señor de los anillos: El retorno del rey', 178, 6)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Pulp Fiction', 154, 7)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El señor de los anillos: La comunidad del anillo', 178, 8)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El bueno, el feo y el malo', 161, 9)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Forrest Gump', 144, 10)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El club de la lucha', 205, 1)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Origen', 207, 2)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El señor de los anillos: Las dos torres', 179, 3)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'El Imperio contraataca', 120, 4)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Matrix', 205, 5)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Uno de los nuestros', 146, 6)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Alguien voló sobre el nido del cuco', 133, 7)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Seven', 122, 8)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'Los siete samuráis', 163, 9)
INSERT [dbo].[Peliculas] ([titulo], [duracion], [id_tipo]) VALUES (N'¡Qué bello es vivir!', 130, 10)

--funciones
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (5, CAST(N'2016-08-18T00:00:00.000' AS DateTime), 1263.4000, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (10, CAST(N'2019-02-24T00:00:00.000' AS DateTime), 495.0800, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (2, CAST(N'2013-10-24T00:00:00.000' AS DateTime), 690.2900, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (10, CAST(N'2020-09-15T00:00:00.000' AS DateTime), 1639.1800, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2012-06-16T00:00:00.000' AS DateTime), 1175.0900, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (12, CAST(N'2014-07-15T00:00:00.000' AS DateTime), 1746.1200, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (9, CAST(N'2020-08-13T00:00:00.000' AS DateTime), 1293.2600, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (17, CAST(N'2015-09-15T00:00:00.000' AS DateTime), 1823.7600, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (13, CAST(N'2017-12-01T00:00:00.000' AS DateTime), 2341.8900, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2018-03-04T00:00:00.000' AS DateTime), 394.6700, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2011-04-01T00:00:00.000' AS DateTime), 1943.2500, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (7, CAST(N'2020-06-18T00:00:00.000' AS DateTime), 1206.0000, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (9, CAST(N'2012-04-16T00:00:00.000' AS DateTime), 1700.9900, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (12, CAST(N'2010-05-20T00:00:00.000' AS DateTime), 510.5100, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2022-08-27T00:00:00.000' AS DateTime), 1163.2600, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (14, CAST(N'2021-07-01T00:00:00.000' AS DateTime), 748.4300, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (4, CAST(N'2013-07-26T00:00:00.000' AS DateTime), 2317.0500, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (10, CAST(N'2013-12-09T00:00:00.000' AS DateTime), 1193.1800, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (13, CAST(N'2012-12-27T00:00:00.000' AS DateTime), 1843.6700, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (6, CAST(N'2011-05-06T00:00:00.000' AS DateTime), 1976.6700, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (4, CAST(N'2010-04-12T00:00:00.000' AS DateTime), 1745.0500, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (12, CAST(N'2018-10-08T00:00:00.000' AS DateTime), 2256.9800, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2016-07-07T00:00:00.000' AS DateTime), 729.2300, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (12, CAST(N'2018-08-19T00:00:00.000' AS DateTime), 1794.8100, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (6, CAST(N'2020-12-17T00:00:00.000' AS DateTime), 1759.6200, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (9, CAST(N'2022-04-17T00:00:00.000' AS DateTime), 1770.9100, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2010-05-21T00:00:00.000' AS DateTime), 686.6800, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (8, CAST(N'2018-06-01T00:00:00.000' AS DateTime), 487.8900, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (13, CAST(N'2017-02-11T00:00:00.000' AS DateTime), 1446.0400, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (14, CAST(N'2013-04-02T00:00:00.000' AS DateTime), 2430.7600, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2010-06-10T00:00:00.000' AS DateTime), 1599.4500, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (13, CAST(N'2014-08-07T00:00:00.000' AS DateTime), 1948.5400, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (12, CAST(N'2018-04-02T00:00:00.000' AS DateTime), 1149.3600, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (8, CAST(N'2012-08-29T00:00:00.000' AS DateTime), 1137.8500, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2022-08-08T00:00:00.000' AS DateTime), 1339.3800, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (2, CAST(N'2013-11-02T00:00:00.000' AS DateTime), 2390.0600, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (15, CAST(N'2010-01-10T00:00:00.000' AS DateTime), 1105.2700, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (17, CAST(N'2016-03-20T00:00:00.000' AS DateTime), 2355.3300, 4)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2012-06-25T00:00:00.000' AS DateTime), 2355.2400, 4)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (2, CAST(N'2014-10-11T00:00:00.000' AS DateTime), 1829.7200, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2016-09-19T00:00:00.000' AS DateTime), 1790.0400, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (2, CAST(N'2012-05-05T00:00:00.000' AS DateTime), 744.4700, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (2, CAST(N'2020-03-05T00:00:00.000' AS DateTime), 453.1100, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (19, CAST(N'2012-10-10T00:00:00.000' AS DateTime), 1272.9400, 4)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2011-06-05T00:00:00.000' AS DateTime), 2375.6400, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (14, CAST(N'2016-12-23T00:00:00.000' AS DateTime), 516.6500, 4)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2017-11-05T00:00:00.000' AS DateTime), 2313.5300, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (19, CAST(N'2014-12-17T00:00:00.000' AS DateTime), 2124.4200, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2017-06-07T00:00:00.000' AS DateTime), 1937.1100, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2010-11-08T00:00:00.000' AS DateTime), 1329.0600, 4)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (19, CAST(N'2018-12-16T00:00:00.000' AS DateTime), 880.3500, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2021-12-30T00:00:00.000' AS DateTime), 1925.5600, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (20, CAST(N'2011-07-26T00:00:00.000' AS DateTime), 1587.6700, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (12, CAST(N'2013-02-09T00:00:00.000' AS DateTime), 1977.5800, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (15, CAST(N'2014-04-18T00:00:00.000' AS DateTime), 382.6900, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2013-03-30T00:00:00.000' AS DateTime), 500.8300, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2018-04-28T00:00:00.000' AS DateTime), 444.9900, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2019-11-19T00:00:00.000' AS DateTime), 575.7000, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2011-06-30T00:00:00.000' AS DateTime), 2327.2000, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (16, CAST(N'2019-06-17T00:00:00.000' AS DateTime), 752.2400, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2011-09-11T00:00:00.000' AS DateTime), 1164.4600, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (7, CAST(N'2019-06-18T00:00:00.000' AS DateTime), 1734.7600, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (7, CAST(N'2013-06-07T00:00:00.000' AS DateTime), 2438.7400, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (8, CAST(N'2016-12-20T00:00:00.000' AS DateTime), 2007.9300, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (4, CAST(N'2017-11-18T00:00:00.000' AS DateTime), 1612.1700, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2021-10-02T00:00:00.000' AS DateTime), 1650.5100, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (2, CAST(N'2013-04-25T00:00:00.000' AS DateTime), 940.3400, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2014-09-15T00:00:00.000' AS DateTime), 1685.1600, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (14, CAST(N'2018-05-27T00:00:00.000' AS DateTime), 1620.9700, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (7, CAST(N'2019-05-07T00:00:00.000' AS DateTime), 735.8700, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (15, CAST(N'2017-08-14T00:00:00.000' AS DateTime), 1270.8100, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (9, CAST(N'2016-07-05T00:00:00.000' AS DateTime), 1238.8100, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (6, CAST(N'2013-09-16T00:00:00.000' AS DateTime), 1922.0600, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (15, CAST(N'2016-04-22T00:00:00.000' AS DateTime), 2212.4700, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (4, CAST(N'2011-11-18T00:00:00.000' AS DateTime), 1262.3800, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (2, CAST(N'2013-12-28T00:00:00.000' AS DateTime), 1689.5300, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (1, CAST(N'2022-02-13T00:00:00.000' AS DateTime), 1946.2700, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (5, CAST(N'2013-05-18T00:00:00.000' AS DateTime), 2415.0100, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (8, CAST(N'2014-04-28T00:00:00.000' AS DateTime), 412.9500, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (7, CAST(N'2021-06-23T00:00:00.000' AS DateTime), 2077.9900, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (3, CAST(N'2013-12-24T00:00:00.000' AS DateTime), 1764.0800, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (6, CAST(N'2014-03-18T00:00:00.000' AS DateTime), 1895.0900, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (14, CAST(N'2021-07-13T00:00:00.000' AS DateTime), 2251.5400, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (10, CAST(N'2012-11-06T00:00:00.000' AS DateTime), 1941.2800, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (9, CAST(N'2021-01-01T00:00:00.000' AS DateTime), 2472.8400, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2015-09-05T00:00:00.000' AS DateTime), 457.0400, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (4, CAST(N'2016-05-27T00:00:00.000' AS DateTime), 402.1000, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (17, CAST(N'2020-04-11T00:00:00.000' AS DateTime), 2425.4900, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (9, CAST(N'2014-07-30T00:00:00.000' AS DateTime), 1872.1900, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (10, CAST(N'2016-02-13T00:00:00.000' AS DateTime), 1167.8400, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (15, CAST(N'2015-10-10T00:00:00.000' AS DateTime), 448.8200, 1)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (5, CAST(N'2018-09-20T00:00:00.000' AS DateTime), 2473.4500, 5)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (9, CAST(N'2012-12-22T00:00:00.000' AS DateTime), 1743.9900, 4)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (18, CAST(N'2012-10-15T00:00:00.000' AS DateTime), 1410.4200, 3)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (11, CAST(N'2022-04-11T00:00:00.000' AS DateTime), 1541.4800, 8)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (15, CAST(N'2011-04-09T00:00:00.000' AS DateTime), 2410.6800, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (17, CAST(N'2011-05-10T00:00:00.000' AS DateTime), 364.9300, 6)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (16, CAST(N'2017-08-12T00:00:00.000' AS DateTime), 1674.6000, 2)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (17, CAST(N'2012-08-14T00:00:00.000' AS DateTime), 1539.9200, 7)
INSERT [dbo].[Funciones] ([id_pelicula], [fecha_hora], [pre_unitario], [id_sala]) VALUES (4, CAST(N'2017-12-05T00:00:00.000' AS DateTime), 937.9800, 6)
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (5,'2023/24/07',2131,4),
  (4,'2022/16/07',1656,6),
  (1,'2023/17/03',1403,1),
  (7,'2022/11/09',1462,3),
  (7,'2022/20/05',2728,5),
  (9,'2023/02/03',1283,6),
  (10,'2021/11/12',1728,3),
  (8,'2022/23/05',2055,3),
  (2,'2022/07/03',1718,6),
  (5,'2022/18/03',1270,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (18,'2022/09/11',1606,7),
  (8,'2023/27/06',1353,8),
  (18,'2022/13/10',2550,5),
  (11,'2022/22/10',2487,7),
  (16,'2022/15/08',2284,2),
  (7,'2022/02/05',1848,4),
  (15,'2023/03/09',2412,7),
  (14,'2023/24/10',1232,3),
  (8,'2022/29/05',1647,6),
  (10,'2022/11/09',1825,5);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (7,'2022/23/01',2386,7),
  (9,'2022/28/05',2222,6),
  (4,'2022/28/12',2292,4),
  (18,'2022/23/11',1299,6),
  (19,'2022/15/04',1764,5),
  (18,'2022/09/05',1969,6),
  (12,'2023/15/07',1359,6),
  (8,'2023/11/01',2059,6),
  (6,'2023/22/07',2610,2),
  (8,'2023/08/08',1627,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (3,'2022/17/10',2193,6),
  (17,'2023/11/04',2790,7),
  (16,'2022/07/04',1433,2),
  (10,'2022/31/10',1665,2),
  (19,'2022/09/07',2755,6),
  (1,'2023/30/07',1982,4),
  (19,'2021/25/11',1894,8),
  (5,'2021/26/12',2638,7),
  (6,'2022/22/01',2380,5),
  (19,'2022/10/08',2138,3);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (16,'2023/10/01',1728,7),
  (3,'2022/06/11',2030,6),
  (9,'2023/09/08',2128,5),
  (16,'2023/04/03',2361,5),
  (11,'2023/31/07',1230,2),
  (10,'2022/10/06',2301,2),
  (9,'2023/05/07',2315,1),
  (14,'2023/15/10',2181,2),
  (19,'2023/08/01',1706,6),
  (11,'2022/02/07',2598,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (13,'2022/13/05',2066,5),
  (7,'2022/16/02',2021,5),
  (6,'2022/07/09',1504,4),
  (17,'2023/23/03',2023,6),
  (4,'2023/23/03',1748,2),
  (17,'2023/07/01',1219,4),
  (8,'2022/26/06',1527,3),
  (7,'2023/21/07',2043,5),
  (12,'2021/03/12',2746,7),
  (16,'2023/14/07',1533,4);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (17,'2023/25/08',1981,2),
  (8,'2022/26/07',1522,7),
  (3,'2022/25/11',2155,5),
  (14,'2022/29/04',1718,8),
  (11,'2023/04/11',2469,7),
  (6,'2023/04/08',1913,6),
  (16,'2022/29/06',2562,7),
  (5,'2022/08/07',2045,8),
  (6,'2022/23/10',1500,5),
  (4,'2022/01/07',2060,4);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (10,'2022/25/02',2617,5),
  (9,'2022/28/04',2659,6),
  (7,'2023/19/10',2587,3),
  (5,'2023/08/02',1616,8),
  (2,'2022/22/12',1305,4),
  (20,'2023/08/03',2563,4),
  (9,'2022/22/05',2171,5),
  (13,'2022/18/02',2084,5),
  (12,'2023/24/07',2256,3),
  (3,'2022/04/05',2339,1);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (7,'2022/13/10',1776,2),
  (14,'2022/05/03',1232,3),
  (3,'2023/11/03',2530,6),
  (18,'2022/04/12',1755,4),
  (4,'2022/07/02',2499,4),
  (4,'2021/21/11',2496,7),
  (19,'2023/18/05',2398,4),
  (19,'2022/22/07',1554,8),
  (5,'2022/24/02',1961,3),
  (13,'2021/12/11',2158,1);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (16,'2022/12/01',1721,5),
  (13,'2022/14/10',2335,6),
  (20,'2022/28/04',2727,2),
  (20,'2023/26/08',1233,7),
  (16,'2023/21/02',1855,6),
  (15,'2023/05/07',1537,2),
  (8,'2023/24/09',2166,5),
  (4,'2022/02/08',1917,5),
  (12,'2022/25/12',2340,7),
  (2,'2022/02/10',1448,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (9,'2023/15/05',1413,7),
  (11,'2022/23/02',1328,6),
  (19,'2023/13/05',1950,7),
  (8,'2022/26/04',1347,6),
  (15,'2021/11/11',2047,4),
  (6,'2023/27/03',1910,8),
  (2,'2022/09/10',1810,2),
  (15,'2022/31/03',1589,7),
  (18,'2023/18/05',2584,7),
  (20,'2022/02/01',2760,5);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (3,'2021/03/12',2626,4),
  (2,'2022/04/09',1541,3),
  (5,'2021/21/11',1831,3),
  (10,'2021/13/12',1362,7),
  (15,'2023/28/06',2119,4),
  (10,'2022/15/04',1458,1),
  (2,'2021/12/11',1918,8),
  (11,'2022/25/10',2666,1),
  (8,'2022/15/01',2130,3),
  (2,'2022/29/10',2439,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (20,'2022/23/04',1383,7),
  (11,'2023/30/04',1609,5),
  (11,'2022/21/05',2041,1),
  (11,'2023/05/05',2544,2),
  (6,'2023/03/07',1632,4),
  (4,'2022/30/10',2541,3),
  (13,'2022/24/04',1975,4),
  (20,'2022/27/01',1814,8),
  (5,'2022/25/05',2497,5),
  (17,'2023/18/06',1872,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (7,'2023/20/05',1679,2),
  (10,'2021/07/12',1682,5),
  (13,'2023/25/01',2221,7),
  (10,'2022/09/08',1782,2),
  (17,'2023/18/05',2734,3),
  (1,'2021/17/11',2342,2),
  (20,'2023/31/10',1511,5),
  (7,'2022/08/09',2555,5),
  (6,'2022/15/12',1865,1),
  (6,'2021/02/12',2475,5);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (4,'2023/22/04',1279,7),
  (7,'2021/07/12',2664,6),
  (20,'2023/14/01',1458,7),
  (18,'2023/10/09',2730,3),
  (2,'2023/01/07',1806,3),
  (6,'2023/15/02',2402,5),
  (14,'2022/03/01',1942,6),
  (17,'2023/09/08',2042,1),
  (14,'2022/17/11',1257,6),
  (11,'2022/05/08',2738,4);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (12,'2022/01/12',2161,7),
  (16,'2023/12/04',1702,2),
  (6,'2023/30/10',1891,7),
  (13,'2021/09/11',1332,6),
  (16,'2023/23/07',1897,3),
  (10,'2022/08/05',2086,6),
  (5,'2023/11/06',2365,6),
  (15,'2023/21/03',1803,2),
  (19,'2023/22/02',2656,7),
  (4,'2022/04/10',1844,1);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (1,'2022/20/12',2311,8),
  (4,'2021/26/12',2489,3),
  (2,'2023/11/03',1220,6),
  (18,'2023/04/07',2115,7),
  (12,'2022/28/12',2677,7),
  (4,'2022/05/04',2091,2),
  (16,'2023/11/09',1700,3),
  (19,'2023/16/08',2501,2),
  (2,'2022/09/02',1756,2),
  (9,'2023/22/06',2102,3);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (15,'2022/29/10',1909,7),
  (17,'2023/27/07',2621,5),
  (16,'2023/14/02',2480,4),
  (7,'2022/05/10',2646,7),
  (6,'2023/30/03',1786,2),
  (20,'2023/06/06',1300,4),
  (9,'2023/06/10',1826,1),
  (6,'2022/14/08',2644,3),
  (6,'2023/05/04',1633,5),
  (12,'2021/18/12',2035,4);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (3,'2023/27/07',2696,6),
  (11,'2022/04/03',2653,6),
  (2,'2022/24/11',1785,8),
  (2,'2023/03/11',2654,2),
  (6,'2022/03/05',2357,6),
  (7,'2022/15/07',2522,7),
  (4,'2022/08/08',2216,2),
  (18,'2023/22/10',1484,6),
  (6,'2022/04/02',1921,4),
  (10,'2022/23/06',2481,3);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (6,'2022/08/12',2029,3),
  (19,'2022/19/10',1404,6),
  (14,'2023/24/08',1669,7),
  (1,'2023/14/04',1763,2),
  (18,'2022/01/11',1913,1),
  (1,'2023/08/01',2732,5),
  (13,'2022/09/10',1377,8),
  (8,'2021/22/11',2162,6),
  (18,'2022/16/04',1339,4),
  (9,'2023/24/06',2156,5);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (15,'2023/03/09',1485,7),
  (8,'2023/26/09',1592,4),
  (15,'2023/28/01',1466,2),
  (1,'2022/01/01',1469,2),
  (9,'2022/30/07',2042,2),
  (1,'2022/10/01',1462,3),
  (13,'2022/06/05',1630,7),
  (17,'2023/03/02',1628,7),
  (13,'2022/27/01',1361,6),
  (9,'2021/26/11',2182,4);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (6,'2022/02/07',1466,1),
  (19,'2023/11/06',2406,6),
  (15,'2023/22/06',2062,4),
  (14,'2022/03/04',2215,6),
  (20,'2023/22/01',2417,2),
  (13,'2021/04/12',2493,6),
  (2,'2023/15/05',1241,6),
  (14,'2023/05/04',1541,7),
  (5,'2023/19/05',1263,6),
  (14,'2022/16/05',2373,1);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (16,'2023/03/06',2118,3),
  (14,'2022/23/03',2597,6),
  (18,'2022/10/12',1232,4),
  (8,'2022/14/10',2377,2),
  (12,'2022/13/01',2294,6),
  (14,'2022/24/06',1396,5),
  (3,'2023/01/08',1838,2),
  (20,'2023/02/09',1768,7),
  (2,'2023/26/01',1280,3),
  (14,'2022/18/12',1979,1);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (13,'2022/19/03',2573,3),
  (1,'2023/07/08',2722,7),
  (6,'2023/26/04',1773,7),
  (7,'2022/28/02',1977,5),
  (4,'2022/10/02',2162,7),
  (17,'2023/09/10',1952,6),
  (16,'2022/19/01',2566,2),
  (4,'2023/20/01',1819,3),
  (2,'2023/22/01',1225,2),
  (16,'2023/17/08',1546,5);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (4,'2022/05/08',2087,4),
  (7,'2022/08/06',2388,3),
  (14,'2021/23/12',2586,3),
  (6,'2022/15/07',1627,4),
  (6,'2022/08/04',2756,2),
  (7,'2022/08/08',1211,3),
  (17,'2022/29/06',1978,3),
  (18,'2022/01/08',2374,3),
  (8,'2022/04/11',1511,3),
  (20,'2022/27/06',2129,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (11,'2022/02/03',1231,2),
  (3,'2022/01/10',1216,7),
  (15,'2022/13/03',1223,7),
  (7,'2023/18/07',1374,6),
  (2,'2023/14/09',1599,7),
  (3,'2022/12/08',2750,4),
  (2,'2023/05/10',2359,4),
  (11,'2022/07/06',1323,8),
  (2,'2022/15/08',1950,7),
  (13,'2023/02/04',2264,8);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (6,'2022/24/04',2149,3),
  (12,'2023/27/07',2141,6),
  (13,'2022/13/06',2246,4),
  (16,'2023/01/02',2730,6),
  (10,'2022/14/09',1792,3),
  (17,'2023/16/01',1521,4),
  (13,'2023/07/03',2045,5),
  (12,'2022/29/03',1352,2),
  (3,'2023/13/04',2013,8),
  (7,'2023/19/08',1379,1);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (8,'2022/03/06',2780,5),
  (4,'2023/20/10',2352,6),
  (1,'2023/24/07',1492,4),
  (13,'2023/07/09',2222,3),
  (18,'2022/06/12',2298,2),
  (4,'2022/10/08',1383,5),
  (6,'2021/13/12',1630,7),
  (18,'2023/08/09',1447,3),
  (15,'2022/24/03',1274,5),
  (16,'2022/20/01',1540,4);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (9,'2023/08/02',1201,3),
  (11,'2022/11/01',2237,7),
  (7,'2023/23/03',2163,6),
  (6,'2022/01/06',2173,4),
  (5,'2022/16/11',2617,4),
  (14,'2023/17/09',2092,7),
  (3,'2022/04/03',1790,2),
  (12,'2022/11/05',2600,4),
  (3,'2023/18/02',1886,2),
  (8,'2023/07/09',2091,5);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (4,'2022/04/09',1688,8),
  (16,'2022/17/12',1491,4),
  (11,'2022/03/06',1540,1),
  (5,'2022/21/05',1275,4),
  (8,'2023/02/06',2473,1),
  (18,'2022/08/08',1978,7),
  (17,'2023/26/09',1378,1),
  (2,'2023/01/05',2143,6),
  (15,'2023/10/03',1233,1),
  (15,'2023/27/07',1546,1);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (3,'2023/01/05',2634,1),
  (14,'2023/24/05',1944,5),
  (7,'2022/02/03',1549,4),
  (3,'2022/20/05',1518,3),
  (6,'2022/28/04',1704,5),
  (5,'2022/27/09',2319,7),
  (7,'2022/27/02',2341,7),
  (8,'2023/10/09',1865,8),
  (10,'2022/09/09',1908,5),
  (7,'2023/19/05',1648,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (4,'2022/04/11',1503,5),
  (12,'2023/10/08',2474,4),
  (5,'2023/03/07',2033,4),
  (15,'2023/29/10',2205,1),
  (17,'2022/15/05',1495,3),
  (7,'2021/20/12',1460,3),
  (10,'2022/30/11',2349,5),
  (5,'2023/03/11',2131,5),
  (8,'2022/07/04',1611,7),
  (1,'2022/01/07',1728,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (4,'2022/25/08',1396,5),
  (7,'2023/16/09',2660,6),
  (19,'2023/18/08',1988,8),
  (18,'2022/30/11',1751,4),
  (13,'2022/06/04',1927,2),
  (6,'2022/24/05',1522,3),
  (15,'2023/28/04',1997,2),
  (7,'2023/28/04',1252,5),
  (12,'2022/24/06',2756,2),
  (5,'2021/06/12',1568,3);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (2,'2023/01/02',2643,2),
  (6,'2022/25/09',1846,6),
  (9,'2022/31/05',1203,3),
  (14,'2023/01/09',2766,8),
  (15,'2022/16/12',1712,4),
  (8,'2022/25/05',1367,3),
  (18,'2021/30/11',2243,7),
  (16,'2022/05/10',1744,5),
  (11,'2021/28/12',1312,4),
  (5,'2022/20/12',2397,6);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (14,'2022/26/06',2429,7),
  (2,'2023/20/01',2521,2),
  (20,'2023/21/05',1422,4),
  (17,'2022/05/06',1317,4),
  (19,'2022/20/11',1430,3),
  (3,'2022/27/03',1539,4),
  (6,'2023/12/02',1417,3),
  (10,'2023/06/07',1511,5),
  (2,'2023/19/02',2320,7),
  (6,'2021/02/12',1659,6);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (11,'2023/30/09',1301,1),
  (18,'2022/07/11',1534,4),
  (16,'2022/16/12',2303,5),
  (6,'2022/12/06',2481,3),
  (14,'2022/11/05',2005,5),
  (17,'2022/24/10',1347,1),
  (9,'2022/18/10',2027,4),
  (2,'2023/22/02',1302,2),
  (11,'2023/04/06',1416,5),
  (10,'2023/21/02',2564,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (6,'2022/02/12',1563,5),
  (5,'2023/24/09',1631,2),
  (9,'2022/15/06',1724,1),
  (18,'2023/22/10',2487,5),
  (9,'2022/08/03',1252,8),
  (9,'2022/25/01',1372,8),
  (9,'2022/07/04',1240,3),
  (11,'2022/02/06',1332,6),
  (8,'2022/30/06',1344,3),
  (7,'2023/24/04',2746,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (7,'2021/17/12',1530,1),
  (13,'2023/16/07',2793,5),
  (15,'2022/07/09',2154,7),
  (2,'2022/10/04',2643,5),
  (9,'2023/13/09',2029,7),
  (17,'2022/15/01',1923,7),
  (16,'2023/25/03',2512,1),
  (4,'2023/04/11',1256,6),
  (17,'2022/12/10',2551,6),
  (6,'2023/13/08',2737,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (19,'2022/24/03',1257,5),
  (16,'2023/09/03',1237,3),
  (16,'2022/10/09',1450,2),
  (3,'2021/22/12',2628,7),
  (7,'2022/19/02',2750,1),
  (6,'2022/31/07',1748,6),
  (9,'2022/19/10',1697,1),
  (9,'2022/10/02',2696,3),
  (15,'2022/21/12',2249,2),
  (16,'2023/03/09',2566,2);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (19,'2023/06/02',1796,1),
  (1,'2022/05/08',2482,7),
  (9,'2022/09/07',2493,3),
  (14,'2023/14/09',1559,2),
  (13,'2021/20/11',1668,2),
  (2,'2023/09/01',1855,6),
  (7,'2023/01/04',1657,6),
  (14,'2022/16/11',1420,7),
  (19,'2022/20/10',1955,7),
  (17,'2022/03/03',2081,8);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (3,'2022/20/08',1782,2),
  (11,'2023/15/05',1252,4),
  (16,'2021/08/12',2095,1),
  (13,'2023/12/04',2001,8),
  (10,'2022/20/02',1438,2),
  (9,'2021/15/12',2230,2),
  (18,'2022/19/04',1771,5),
  (4,'2023/14/07',2204,5),
  (11,'2022/04/07',2434,7),
  (10,'2023/01/02',2723,6);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (8,'2022/02/03',2558,7),
  (12,'2022/10/05',1921,1),
  (14,'2023/11/04',1953,6),
  (20,'2023/11/07',2061,4),
  (16,'2023/07/01',2707,5),
  (3,'2023/04/10',1651,3),
  (2,'2022/06/12',2697,6),
  (19,'2021/29/12',2569,2),
  (18,'2023/14/01',1693,7),
  (13,'2022/15/09',2139,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (7,'2023/27/05',2728,3),
  (12,'2023/15/09',1822,2),
  (15,'2023/22/10',1985,7),
  (15,'2023/12/09',2621,3),
  (3,'2022/01/04',2303,5),
  (13,'2022/08/12',2528,8),
  (9,'2023/23/05',1844,1),
  (3,'2022/14/06',1857,3),
  (7,'2021/19/12',2336,2),
  (5,'2022/06/02',1667,3);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (20,'2022/11/06',2169,7),
  (19,'2023/16/08',1206,4),
  (15,'2021/24/11',2047,7),
  (4,'2022/03/07',2298,5),
  (18,'2023/22/06',2538,2),
  (18,'2023/23/03',1337,7),
  (6,'2022/18/10',1708,5),
  (17,'2022/10/09',2637,7),
  (15,'2023/26/06',2672,6),
  (14,'2023/20/02',2424,8);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (16,'2022/28/07',1459,6),
  (19,'2022/26/10',1462,5),
  (14,'2022/15/03',1631,2),
  (16,'2023/05/03',2184,8),
  (19,'2023/26/02',1245,8),
  (13,'2022/11/11',1540,4),
  (13,'2022/29/08',1786,1),
  (7,'2022/04/02',2318,5),
  (16,'2022/25/05',2555,6),
  (2,'2023/20/08',2289,6);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (17,'2022/22/02',1767,4),
  (5,'2021/28/12',2049,4),
  (2,'2023/28/03',2411,2),
  (2,'2022/13/09',2358,8),
  (13,'2022/18/10',1471,6),
  (13,'2022/31/01',1943,7),
  (10,'2022/04/06',1733,3),
  (14,'2023/24/07',2766,7),
  (12,'2021/14/11',2578,6),
  (17,'2023/20/09',2486,4);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (6,'2023/20/02',1530,1),
  (18,'2023/21/05',1480,4),
  (11,'2022/21/01',2266,2),
  (17,'2022/28/09',2518,4),
  (19,'2023/08/07',1749,2),
  (6,'2021/10/11',2662,4),
  (20,'2022/20/05',1713,5),
  (1,'2022/13/05',1796,5),
  (13,'2023/24/06',1512,4),
  (12,'2023/22/08',1632,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (4,'2023/16/02',2283,6),
  (3,'2023/07/02',2100,4),
  (13,'2022/10/12',1945,8),
  (6,'2023/04/05',1217,5),
  (19,'2022/13/02',1239,4),
  (17,'2022/09/02',2780,2),
  (11,'2023/27/10',2576,2),
  (10,'2023/12/03',2054,3),
  (15,'2022/10/05',1941,3),
  (7,'2023/12/05',2710,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (10,'2023/10/02',1578,3),
  (6,'2023/16/08',1797,4),
  (18,'2022/02/07',1924,5),
  (4,'2022/26/10',2570,7),
  (15,'2022/26/05',2046,3),
  (16,'2022/17/10',1498,5),
  (2,'2022/16/01',1945,7),
  (18,'2022/06/02',2366,6),
  (12,'2023/10/06',2604,2),
  (2,'2023/08/01',2779,7);
INSERT INTO [funciones] (id_pelicula,fecha_hora,pre_unitario,id_sala)
VALUES
  (13,'2023/28/04',2038,4),
  (12,'2022/23/10',1828,1),
  (8,'2021/20/12',1710,7),
  (18,'2023/02/08',1395,5),
  (18,'2022/13/10',1697,5),
  (6,'2021/15/12',1236,2),
  (15,'2023/22/10',1872,1),
  (12,'2022/06/05',1729,6),
  (1,'2023/15/04',1682,5),
  (5,'2022/22/09',2729,3);

 select * from Funciones


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--procedimientos

--consultar peliculas
  create proc [dbo].[SP_CONSULTAR_PELICULAS]
  as
  begin
  select id_pelicula, titulo
  from peliculas
  end
   ----------------------------------
--grabar cliente
  create proc [dbo].[SP_GRABAR_CLIENTE] --usado en metodo GrabarCliente()
  @nombre varchar(100),
  @apellido varchar(100),
  @calle varchar(50),
  @altura int,
  @telefono bigint,
  @dni bigint,
  @email varchar(100)
  as
  begin
  insert into clientes (dni_cliente,email,calle,altura,telefono,nom_cliente,ape_cliente)
  values (@dni,@email,@calle,@altura,@telefono,@nombre,@apellido)
  end
   ----------------------------------
--grabar funcion
  create proc [dbo].[SP_GRABAR_FUNCION]	--usado en método GrabarFuncion()
  @idPelicula int,
  @fecha datetime,
  @precio money,
  @idSala int
  as
  begin
  insert into Funciones (id_pelicula,fecha_hora,pre_unitario,id_sala)
  values (@idPelicula,@fecha,@precio,@idSala)
  end
 ----------------------------------
create proc SP_CONSULTAR_FUNCIONES_FILTRO
@fecha date
as
begin
 select f.id_funcion,p.titulo+' - '+cast(format(fecha_hora,'dd/MM/yyyy') as varchar)+' - Sala '+cast(id_sala as varchar)
from funciones f, peliculas p 
where f.id_pelicula=p.id_pelicula and f.fecha_hora>=@fecha
end
 ----------------------------------
create proc SP_CONSULTAR_FUNCIONES2 --usado en metodo consultarFunciones()
as
begin 
select f.id_funcion,p.titulo+' - '+cast(format(fecha_hora,'dd/MM/yyyy') as varchar)+' - Sala '+cast(id_sala as varchar),pre_unitario
from funciones f, peliculas p 
where f.id_pelicula=p.id_pelicula and f.fecha_hora>=getdate()
end
----------------------------------
create proc consultarClientes --usado en método consultarClientes()
as
begin
	select id_cliente,dni_cliente,email,calle,altura,telefono,nom_cliente,ape_cliente,ape_cliente+', '+nom_cliente+' - '+dni_cliente 
	from Clientes
end
----------------------------------
create PROCEDURE [dbo].[SP_GRABAR_TICKET] --usado en método ConfirmarTicket()
	@id_tipo_pago int,
	@id_cliente int,
	@fecha_compra datetime,
	@id_ticket int output
AS
BEGIN
	INSERT INTO Tickets (id_tipo_pago,id_cliente,fecha_compra)
    VALUES (@id_tipo_pago,@id_cliente,@fecha_compra);
	set @id_ticket = SCOPE_IDENTITY()
END
----------------------------------
create PROCEDURE [dbo].[SP_GRABAR_TICKET3]
	@id_tipo_pago int,
	@id_cliente int,
	@fecha_compra datetime,
	@id_ticket int output
AS
BEGIN
	INSERT INTO Tickets (id_tipo_pago,id_cliente,fecha_compra)
    VALUES (@id_tipo_pago,@id_cliente,@fecha_compra);
	set @id_ticket = select dbo.proximoTicket(1)
END
-------------------------------
create proc spConsultarTiposPagos --usado en método consultarTiposPagos()
as
begin
select id_tipo_pago,nombre_tipo_pago from Tipos_pagos
end
-------------------------------
create PROCEDURE [dbo].[SP_INSERTAR_DETALLES] --usado en método ConfirmarTickets()
	@descuento money,
	@id_ticket int,
	@costo money,
	@id_butaca int,
	@id_funcion int
AS
BEGIN
	INSERT INTO Detalle_Tickets(descuento,id_ticket,costo,id_butaca,id_funcion)
    VALUES (@descuento,@id_ticket,@costo,@id_butaca,@id_funcion);
END
-------------------------------
create procedure proxTicket
@prox int output
as
begin
set @prox = (select max(id_ticket)+1 from Tickets);
end
-------------------------------
create function proximoTicket
(@param int)
returns int
as
begin
declare @prox1 int
set @prox1 = (select max(id_ticket)+1 from Tickets);
return @prox1
end;
-------------------------------
create proc [dbo].[SP_BAJA_FUNCION]	
@idFuncion int
as
begin
update Funciones set activo=0 where id_funcion=@idFuncion
end
-------------------------------
create proc [dbo].[SP_BAJA_CLIENTES]
@idCliente int
as
begin
update clientes set activo=0 where id_cliente=@idCliente
end
-------------------------------
create proc [dbo].[SP_USUARIOS_LOGIN]
as
begin
select usuario,contras from Login
end
-------------------------------
create proc [dbo].[SP_CONSULTAR_FUNCIONES3]
as
begin
select id_funcion, p.titulo,format(fecha_hora,'dd/MM/yyy') fecha, id_sala,pre_unitario
from funciones f join peliculas p on f.id_pelicula=p.id_pelicula
where activo=1
order by fecha desc
end
-------------------------------
create proc SP_BUSCAR_CLIENTES
@nombre varchar (50)
as
select nom_cliente,ape_cliente
from Clientes
where nom_cliente like ('%' +@nombre+ '%')

exec SP_BUSCAR_CLIENTES 'Jess'
-------------------------------	
CREATE proc [dbo].[SP_CONSULTAR_CLIENTES_ACTIVOS]
AS
begin
select id_cliente,dni_cliente, nom_cliente, ape_cliente, email
from clientes
where activo=1
order by id_cliente desc
end
-------------------------------	
create proc consultarUsuarios
as
begin
select *
from Login
end
-------------------------------	
alter proc insertarUsuarios
@usuario varchar(50),@contra varchar(50)
as
begin
insert into Login (usuario,contras) values (@usuario,@contra)
end

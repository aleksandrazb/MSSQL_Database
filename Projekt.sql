--USE master;
--DROP DATABASE Eventy_w_grze_MMORPG;
--GO

--CREATE DATABASE Eventy_w_grze_MMORPG;
--GO

--USE Eventy_w_grze_MMORPG;
--GO

--------USUÑ TABELE---------

IF OBJECT_ID('Eventy', 'U') IS NOT NULL 
    DROP TABLE Eventy;

IF OBJECT_ID('Pozycje', 'U') IS NOT NULL 
    DROP TABLE Pozycje;

IF OBJECT_ID('Mapy', 'U') IS NOT NULL 
    DROP TABLE Mapy;

IF OBJECT_ID('Poziomy_trudnosci', 'U') IS NOT NULL 
    DROP TABLE Poziomy_trudnosci;

IF OBJECT_ID('Przeciwnicy', 'U') IS NOT NULL 
    DROP TABLE Przeciwnicy;

IF OBJECT_ID('Przeciwnicy_w_eventach', 'U') IS NOT NULL 
    DROP TABLE Przeciwnicy_w_eventach;



--------- CREATE - UTWÓRZ TABELE I POWI¥ZANIA ----------

CREATE TABLE Pozycje
(
    id_pozycji      INT IDENTITY(1, 1) PRIMARY KEY,
    os_X			FLOAT NOT NULL CONSTRAINT ck_min_poz_X CHECK (os_X >= 0),
	os_Y			FLOAT NOT NULL CONSTRAINT ck_min_poz_Y CHECK (os_Y >= 0)
);

CREATE TABLE Przeciwnicy
(
    id_przeciwnika      INT IDENTITY(1, 1) PRIMARY KEY,
    nazwa_przeciwnika	VARCHAR(30) UNIQUE NOT NULL,
	typ_broni			VARCHAR(30) NOT NULL,
	poziom				INT DEFAULT 5 CONSTRAINT ck_poziom_przeciwnika CHECK (poziom >= 1)
);

CREATE TABLE Poziomy_trudnosci
(
	id_stopnia_trudnosci					INT IDENTITY(1, 1) PRIMARY KEY,
    stopien_trudnosci						INT NOT NULL UNIQUE CONSTRAINT ck_stopien_trudnosci CHECK (stopien_trudnosci >= 0),
    minimalny_level							INT NOT NULL CONSTRAINT ck_min_lvl CHECK (minimalny_level >= 0),
    minimalna_liczba_osob_w_druzynie		INT NOT NULL DEFAULT 1 CONSTRAINT ck_min_liczba_osob CHECK (minimalna_liczba_osob_w_druzynie >= 1),
);

CREATE TABLE Eventy
(
    id_eventu				INT IDENTITY(1, 1) PRIMARY KEY,
    nazwa					VARCHAR(30) NOT NULL UNIQUE,
    rozpoczecie				TIME NOT NULL,
	zakonczenie				TIME NOT NULL,
	cyklicznosc_w_dniach	INT NOT NULL DEFAULT 1 CONSTRAINT ck_min_cyklicznos CHECK (cyklicznosc_w_dniach >=1),
	stopien_trudnosci		INT NOT NULL REFERENCES Poziomy_trudnosci(id_stopnia_trudnosci),
	pozycja					INT NOT NULL REFERENCES Pozycje(id_pozycji),
	status_eventu			VARCHAR(10) NOT NULL DEFAULT 'AKTYWNY' CONSTRAINT ck_akt_nieakt CHECK (status_eventu IN ('AKTYWNY', 'NIEAKTYWNY')),

	CONSTRAINT ck_zakonczenie_eventu CHECK (zakonczenie > rozpoczecie)
);

CREATE TABLE Mapy
(
    nazwa			VARCHAR(30) PRIMARY KEY,
    zakres_osi_X_od	FLOAT NOT NULL,
    zakres_osi_X_do	FLOAT NOT NULL,
    zakres_osi_Y_od	FLOAT NOT NULL,
	zakres_osi_Y_do	FLOAT NOT NULL,

	CONSTRAINT ck_mapa_os_X_od CHECK (zakres_osi_X_od >= 0),
	CONSTRAINT ck_mapa_os_X_do CHECK (zakres_osi_X_do > zakres_osi_X_od),
	CONSTRAINT ck_mapa_os_Y_od CHECK (zakres_osi_Y_od >= 0),
	CONSTRAINT ck_mapa_os_Y_do CHECK (zakres_osi_Y_do > zakres_osi_Y_od)
);


CREATE TABLE Przeciwnicy_w_eventach 
(
	id_eventu				INT NOT NULL,
	id_przeciwnika			INT NOT NULL,
	liczebnosc_przeciwnika	INT NOT NULL DEFAULT 1,
);
ALTER TABLE Przeciwnicy_w_eventach ADD CONSTRAINT Przeciwnicy_w_eventach_pk PRIMARY KEY (id_eventu, id_przeciwnika);


GO



---------- INSERT - WSTAW DANE ----------


INSERT INTO Przeciwnicy(nazwa_przeciwnika, typ_broni, poziom) VALUES
('Z³odziej','sztylety', 5),
('Menel','piêœci', 5),
('Turysta z Olyer','miecz plazmowy', 7),
('Potê¿ny Rafido','miecz oburêczny', 10),
('Uciekinier z Sahady','piêœci', 8),
('Wojownik Mesa','miecz jednorêczny', 17),
('Zabójca z Tiorno','zatrute strza³ki', 20),
('Zabójca z Rednaelo','³uk', 20),
('Zabójca z Jordo','shurikeny', 20),
('Wyszkolony z³odziej z Sahady','sztylety', 25),
('Zmutowany bies','zêby/pazury',25),
('Chupacabra','zêby/pazury', 25),
('¯o³nierz pó³nocy','miecz jednorêczny', 30),
('Strzelec pó³nocy', '³uk', 30),
('Berserker pó³nocy','zatrute strza³ki', 30),
('Cz³owiek z sekty','sztylety', 33),
('Szef sekty','wszystkie', 35),
('Przybysz','miecz plazmowy', 40),
('Despado','miecz jednorêczny', 40),
('Obroñca Zuby','miecz oburêczny', 43),
('Oskar¿yciel','wszystkie', 45),
('Potêpieniec','piêœci', 50),
('Zjawa z zaœwiatów','trucizna', 50),
('Duch z zaœwiatów','trucizna', 50),
('Demon z zaœwiatów','wszystkie', 50),
('Szef z³odziei','wszystkie', 54);


INSERT INTO Pozycje (os_X, os_Y) VALUES
(14.53254325, 5.43435000),
(34.64684256, 25.74689001),
(16.00567346, 34.74678764),
(4.76000456, 67.74650839),
(14.53254325, 413.72021212),
(210.46583600, 35.70008264),
(136.41466201, 113.13363474),
(250.33367325, 60.06521266),
(71.51646226, 474.41657224),
(33.12646445, 470.62315640),
(162.35354453, 21.65025041),
(277.49005747, 50.48435214),
(82.52980813, 105.16056493),
(320.45567710, 59.11421162),
(503.36405538, 418.75724256),
(391.42427228, 262.57950252),
(142.46404151, 259.37466681),
(102.80127214, 374.86731454),
(335.19669167, 477.25657026),
(328.28716901, 272.90053450),
(234.15118029, 426.62564031),
(427.69084743, 86.39745432),
(557.99326462, 5.83648573),
(466.01343613, 38.49746164),
(473.48359570, 252.37948687),
(488.93519691, 12.45205307),
(567.10078101, 165.71912597),
(375.63684257, 413.75369536);


INSERT INTO Poziomy_trudnosci VALUES
(0, 0, 1),
(1, 5, 1),
(2, 5, 2),
(3, 6, 1),
(4, 6, 2),
(5, 7, 1),
(6, 7, 2),
(7, 8, 1),
(8, 8, 2),
(9, 9, 1),
(10, 9, 2),
(11, 10, 1),
(12, 10, 3),
(13, 15, 1),
(14, 15, 2),
(15, 17, 4),
(16, 20, 1),
(17, 23, 1),
(18, 23, 3),
(19, 24, 5),
(20, 25, 3),
(21, 30, 2),
(22, 34, 1),
(23, 36, 2),
(24, 38, 3),
(25, 40, 1),
(26, 44, 2),
(27, 46, 1),
(28, 50, 1),
(29, 50, 5),
(30, 55, 6);


INSERT INTO Eventy (nazwa, rozpoczecie, zakonczenie, cyklicznosc_w_dniach, stopien_trudnosci, pozycja) VALUES
('Z powrotem w domu','17:00:00','19:00:00',3,1,1),
('Wielki Fred','13:00:00','14:00:00',3,5,16),
('Ratunku!!!','14:00:00','15:00:00',7,4,2),
('Wielka impreza na podwórku','11:00:00','23:00:00',2,7,17),
('Tiorniañczyk w opa³ach','07:00:00','10:00:00',5,21,15),
('Pogoñ za Jackalope','17:00:00','23:00:00',3,6,4),
('Czarny mag','20:00:00','23:00:00',10,28,20),
('Nie tak mia³o byæ','10:00:00','15:00:00',1,11,8),
('Skok w wodê','17:00:00','20:00:00',4,16,9),
('Kontratak Olyer z pó³nocy','21:00:00','23:59:59',14,30,23),
('Kurza stopa','10:00:00','12:00:00',1,3,2),
('Ogry z nieba','22:00:00','23:00:00',24,27,25),
('Nieporozumienie','09:00:00','15:00:00',6,9,13),
('Z³odziej bananów','01:00:00','05:00:00',2,26,27);


INSERT INTO Mapy VALUES
('Midoria', 0, 208, 0, 100),
('Sahada', 208, 305, 0, 100),
('Tiorno', 208, 305, 100, 275),
('Parella', 0, 208, 100, 275),
('Mesa', 305, 600, 0, 275),
('Zuba', 0, 208, 327, 500),
('Olyer', 208, 305, 275, 327),
('Rafido', 208, 305, 275, 500),
('Rednaelo', 305, 600, 275, 327),
('Ikol', 305, 600, 327, 500),
('Jordo', 0, 208, 275, 327);


INSERT INTO Przeciwnicy_w_eventach VALUES
(1,1,1),
(2,1,4),
(2,4,1),
(3,3,1),
(4,5,5),
(5,7,3),
(5,8,3),
(5,9,3),
(6,4,3),
(7,22,1),
(7,23,5),
(7,24,5),
(7,25,2),
(8,4,1),
(8,5,1),
(9,6,10),
(10,26,1),
(10,22,20),
(10,25,1),
(11,5,1),
(12,21,2),
(12,19,10),
(13,5,10),
(13,3,15),
(14,11,15),
(14,10,15),
(14,21,2);


GO




----------TRIGGERY----------


--------------------NA TABELÊ PRZECIWNICY-----------------------


---------t_usuwanie_przeciwnikow---------
CREATE OR ALTER TRIGGER t_usuwanie_przeciwnikow
ON Przeciwnicy
INSTEAD OF DELETE, UPDATE
AS
	RAISERROR('Przeciwników nie mo¿na usuwaæ ani modyfikowaæ',1,2)
GO

--przyk³adowe wywo³anie
--DELETE FROM Przeciwnicy WHERE nazwa_przeciwnika LIKE 'Chupacabra';
--SELECT * FROM Przeciwnicy;




--------------NA TABELÊ POZYCJE-------------------------------------

--------t_rozne_pozycje--------
CREATE OR ALTER TRIGGER t_rozne_pozycje 
ON Pozycje
AFTER INSERT, UPDATE 
AS

DECLARE @X FLOAT, @Y FLOAT, @Xi FLOAT, @Yi FLOAT
SELECT @X=os_X FROM Pozycje 
SELECT @Y=os_Y FROM Pozycje
SELECT @Xi=os_X FROM inserted
SELECT @Yi=os_Y FROM inserted

IF (@Xi=@X AND @Yi=@Y)
BEGIN
	ROLLBACK
	RAISERROR('Ta pozycja ju¿ istnieje',1,2)
END
GO

--przyk³adowe wywo³anie
--INSERT INTO Pozycje(os_X, os_Y) VALUES (14.53254325, 5.43435000);
--GO
--SELECT * FROM Pozycje;




---------t_pozycja_na_mapie---------
CREATE OR ALTER TRIGGER t_pozycja_na_mapie
ON Pozycje
INSTEAD OF INSERT, UPDATE
AS

DECLARE @X FLOAT, @Y FLOAT, @Xi FLOAT, @Yi FLOAT
SELECT @X=MAX(os_X) FROM Pozycje 
SELECT @Y=MAX(os_Y) FROM Pozycje
SELECT @Xi=os_X FROM inserted
SELECT @Yi=os_Y FROM inserted

IF (@Xi>@X) OR (@Yi>@Y)
BEGIN
	RAISERROR('Ta pozycja znajduje siê poza map¹',1,2)
END
ELSE
BEGIN
	INSERT INTO Pozycje(os_X, os_Y) VALUES (@Xi, @Yi);
END
GO

--przyk³adowe wywo³anie
--INSERT INTO Pozycje(os_X, os_Y) VALUES (800, 700);
--GO
--SELECT * FROM Pozycje;




---------------------NA TABELÊ POZIOMY_TRUDNOSCI--------------------------------


----------t_kolejnosc_0----------
CREATE OR ALTER TRIGGER t_kolejnosc_0
ON Poziomy_trudnosci
INSTEAD OF INSERT
AS

DECLARE @stopien_0 INT, @min_lvl_0 INT, @min_l_os_0 INT
SELECT @stopien_0=stopien_trudnosci FROM inserted;
SELECT @min_lvl_0=minimalny_level FROM inserted;
SELECT @min_l_os_0=minimalna_liczba_osob_w_druzynie FROM inserted;

IF ((@stopien_0 <= (SELECT MAX(stopien_trudnosci) FROM Poziomy_trudnosci))
	AND (@stopien_0 IN (SELECT stopien_trudnosci FROM Poziomy_trudnosci)))
BEGIN
	RAISERROR('Zmieniono kolejnoœæ',1,2)

	UPDATE Poziomy_trudnosci
	SET stopien_trudnosci=stopien_trudnosci+1
	WHERE stopien_trudnosci>=@stopien_0;
	SELECT * FROM Poziomy_trudnosci;
	INSERT INTO Poziomy_trudnosci VALUES
	(@stopien_0, @min_lvl_0, @min_l_os_0);

END
ELSE
BEGIN
	IF (@stopien_0-1=(SELECT MAX(stopien_trudnosci) FROM Poziomy_trudnosci))
	BEGIN
		RAISERROR('Nie zmieniono kolejnoœci',1,2)
		INSERT INTO Poziomy_trudnosci VALUES
		(@stopien_0, @min_lvl_0, @min_l_os_0);
	END
	ELSE
	BEGIN
		RAISERROR('Error - nieliniowoœæ stopni trudnoœci',1,2)
	END
END

GO

--przyk³adowe wywo³anie
--INSERT INTO Poziomy_trudnosci VALUES (40,40,1);
--SELECT * FROM Poziomy_trudnosci;



-----------t_kolejnosc-----------
CREATE OR ALTER TRIGGER t_kolejnosc
ON Poziomy_trudnosci
AFTER UPDATE, INSERT
AS

DECLARE @stopien_in INT, @min_lvl_in INT, @min_l_os_in INT
SELECT @stopien_in=stopien_trudnosci FROM inserted;
SELECT @min_lvl_in=minimalny_level FROM inserted;
SELECT @min_l_os_in=minimalna_liczba_osob_w_druzynie FROM inserted;


IF (@min_lvl_in < (SELECT MAX(minimalny_level) FROM Poziomy_trudnosci WHERE stopien_trudnosci<@stopien_in))
BEGIN
	ROLLBACK
	RAISERROR('Error - minimalny level mniejszy od poprzedniego',1,2)
END
ELSE
BEGIN
	IF (@min_lvl_in > (SELECT MIN(minimalny_level) FROM Poziomy_trudnosci WHERE stopien_trudnosci>@stopien_in))
	BEGIN
		ROLLBACK
		RAISERROR('Error - minimalny level wiêkszy od poprzedniego',1,2)
	END
	ELSE
	BEGIN
		IF (@min_l_os_in IN (SELECT minimalna_liczba_osob_w_druzynie FROM Poziomy_trudnosci WHERE minimalny_level=@min_lvl_in AND stopien_trudnosci!=@stopien_in))
		BEGIN
			ROLLBACK
			RAISERROR('Error - ju¿ istnieje stopieñ trudnoœci z tym levelem i tak¹ sam¹ minimaln¹ liczb¹ osób',1,2)
		END
		ELSE
		BEGIN
			IF (@min_l_os_in < (SELECT MAX(minimalna_liczba_osob_w_druzynie) FROM Poziomy_trudnosci WHERE stopien_trudnosci<@stopien_in AND minimalny_level=@min_lvl_in))
			BEGIN
				ROLLBACK
				RAISERROR('Error - minimalna liczba osób jest mniejsza od poprzedniej liczby osób przy tym samym levelu',1,2)
			END
			ELSE
			BEGIN
				IF (@min_l_os_in > (SELECT MIN(minimalna_liczba_osob_w_druzynie) FROM Poziomy_trudnosci WHERE stopien_trudnosci>@stopien_in AND minimalny_level=@min_lvl_in))
				BEGIN
					ROLLBACK
					RAISERROR('Error - minimalna liczba osób jest wiêksza od nastêpnej liczby osób przy tym samym levelu',1,2)
				END
			END
		END
	END
END
GO

--przyk³adowe wywo³anie
--INSERT INTO Poziomy_trudnosci VALUES (8,40,1);
--SELECT * FROM Poziomy_trudnosci;



---------t_kolejnosc_delete---------
CREATE OR ALTER TRIGGER t_kolejnosc_delete
ON Poziomy_trudnosci
AFTER DELETE
AS

DECLARE @stopien_d INT, @min_lvl_d INT, @min_l_os_d INT
SELECT @stopien_d=stopien_trudnosci FROM deleted;
SELECT @min_lvl_d=minimalny_level FROM deleted;
SELECT @min_l_os_d=minimalna_liczba_osob_w_druzynie FROM deleted;

IF (@stopien_d<(SELECT MAX(stopien_trudnosci) FROM Poziomy_trudnosci))
BEGIN
	RAISERROR('Zmieniono kolejnoœæ',1,2)
	UPDATE Poziomy_trudnosci
	SET stopien_trudnosci=stopien_trudnosci-1
	WHERE stopien_trudnosci>@stopien_d;
END
ELSE
BEGIN
	RAISERROR('Nie zmieniono kolejnoœci',1,2)
END
GO

--przyk³adowe wywo³anie
--INSERT INTO Poziomy_trudnosci VALUES (5,6,5);
--DELETE FROM Poziomy_trudnosci WHERE stopien_trudnosci LIKE 5;
--SELECT * FROM Poziomy_trudnosci;



------------t_uzywany_stopien_trudnosci------------
CREATE OR ALTER TRIGGER t_uzywany_stopien_trudnosci
ON Poziomy_trudnosci
INSTEAD OF DELETE
AS
IF ((SELECT id_stopnia_trudnosci FROM deleted) IN (SELECT stopien_trudnosci FROM Eventy))
BEGIN
	RAISERROR('Nie mo¿na usun¹æ tego stopnia trudnoœci, poniewa¿ jest on u¿ywany w tabeli Eventy',1,2)
END
ELSE
BEGIN
	DELETE FROM Poziomy_trudnosci WHERE stopien_trudnosci LIKE (SELECT stopien_trudnosci FROM deleted);
END
GO

--przyk³adowe wywo³anie
--DELETE FROM Poziomy_trudnosci WHERE stopien_trudnosci LIKE 29;
--SELECT * FROM Poziomy_trudnosci;




----------NA TABELÊ EVENTY-----------


--------t_usuwanie_eventu--------
CREATE OR ALTER TRIGGER t_usuwanie_eventu
ON Eventy
INSTEAD OF DELETE
AS
UPDATE Eventy 
SET status_eventu='NIEAKTYWNY'
WHERE id_eventu=(SELECT id_eventu FROM deleted)
GO

--przyk³adowe wywo³anie
--DELETE FROM Eventy WHERE id_eventu=3;
--SELECT * FROM Eventy;





----------NA TABELÊ MAPY-------------


------t_modyfikacja_mapy------
CREATE OR ALTER TRIGGER t_modyfikacja_mapy
ON Mapy
INSTEAD OF INSERT, UPDATE, DELETE
AS
RAISERROR('Nie mo¿na dodaæ, usun¹æ, zmodyfikowaæ map. Mo¿na tylko dodawaæ, usuwaæ, modyfikowaæ eventy, dostêpne pozycje dla eventów i poziomy trudnoœci eventów',1,2)
GO

--przyk³adowe wywo³anie
--DELETE FROM Mapy WHERE nazwa='Mesa';
--SELECT * FROM Mapy;





--------------------------------------------------------------------------------------------------

SELECT * FROM Eventy;
SELECT * FROM Poziomy_trudnosci;
SELECT * FROM Pozycje;
SELECT * FROM Mapy;
SELECT * FROM Przeciwnicy;
SELECT * FROM Przeciwnicy_w_eventach;

--------------------------------------------------------------------------------------------------







--------------------PRZYK£ADOWE SELECTY----------------------------------


--------------------------------------------------------------------------------------------------

--SELECT nazwa FROM Eventy WHERE cyklicznosc_w_dniach = 3;

--------------------------------------------------------------------------------------------------

--SELECT E.nazwa AS 'nazwa eventu', M.nazwa AS 'nazwa mapy'
--FROM (Eventy E JOIN Pozycje P ON E.pozycja=P.id_pozycji)
--			JOIN Mapy M
--				ON P.os_X BETWEEN M.zakres_osi_X_od AND M.zakres_osi_X_do
--					AND P.os_Y BETWEEN M.zakres_osi_Y_od AND M.zakres_osi_Y_do;

--------------------------------------------------------------------------------------------------

--SELECT nazwa, minimalny_level FROM Eventy E JOIN Poziomy_trudnosci P ON E.stopien_trudnosci = P.stopien_trudnosci
--WHERE minimalna_liczba_osob_w_druzynie >= 2
--ORDER BY minimalny_level;

--------------------------------------------------------------------------------------------------






-------------------FUNKCJE-------------------------


--SAKLARNA--
GO
CREATE OR ALTER FUNCTION ufn_Powierzchnia
(
	@x_p INT,
	@x_k INT,
	@y_p INT,
	@y_k INT
)
RETURNS INT
AS
BEGIN
    RETURN (@x_k-@x_p)*(@y_k-@y_p);
END;
GO

--przyk³adowe wywo³anie
--SELECT nazwa, dbo.ufn_Powierzchnia(zakres_osi_X_od, zakres_osi_X_do, zakres_osi_Y_od, zakres_osi_Y_do) AS powierzchnia FROM Mapy WHERE dbo.ufn_Powierzchnia(zakres_osi_X_od, zakres_osi_X_do, zakres_osi_Y_od, zakres_osi_Y_do)>20000 ORDER BY powierzchnia; 





--TABLICOWA--
GO
CREATE OR ALTER FUNCTION ufn_eventy_na_mapie
(
    @nazwa_mapy VARCHAR(30)
)
    RETURNS TABLE
AS
    RETURN SELECT nazwa
           FROM   Eventy JOIN Pozycje ON pozycja=id_pozycji
           WHERE  (os_X BETWEEN (SELECT zakres_osi_X_od FROM Mapy WHERE nazwa=@nazwa_mapy) AND (SELECT zakres_osi_X_do FROM Mapy WHERE nazwa=@nazwa_mapy))
					AND (os_Y BETWEEN (SELECT zakres_osi_Y_od FROM Mapy WHERE nazwa=@nazwa_mapy) AND (SELECT zakres_osi_Y_do FROM Mapy WHERE nazwa=@nazwa_mapy));
GO

--przyk³adowe wywo³anie
--SELECT *  FROM dbo.ufn_eventy_na_mapie('Midoria');




-------------WIDOK------------------

GO
CREATE OR ALTER VIEW Eventy_widok(nazwa_eventu, nazwa_mapy, polozenie_na_osi_X, polozenie_na_osi_Y, czas_rozpoczecia_eventu, status_eventu)
AS
(
    SELECT  E.nazwa, 
            M.nazwa,
			P.os_X,
			P.os_Y,
			E.rozpoczecie,
			E.status_eventu
    FROM    (Eventy E JOIN Pozycje P ON pozycja=id_pozycji) CROSS JOIN Mapy M
	WHERE	(os_X BETWEEN zakres_osi_X_od AND zakres_osi_X_do)
			AND (os_Y BETWEEN zakres_osi_Y_od AND zakres_osi_Y_do)
);
GO

--przyk³adowe wywo³anie
--SELECT * FROM Eventy_widok;





------------------PROCEDURY---------------------

--RAPORTUJ¥CA--

CREATE OR ALTER PROCEDURE usp_ilosc_aktywnych_eventow_na_mapie
    @nazwa_mapy  VARCHAR(30),
    @ilosc_eventow_na_mapie  INT  OUTPUT
AS
    BEGIN TRY

		IF (@nazwa_mapy IN (SELECT nazwa FROM Mapy))
		BEGIN
			SELECT @ilosc_eventow_na_mapie=COUNT(*)  FROM dbo.ufn_eventy_na_mapie(@nazwa_mapy) WHERE nazwa IN (SELECT nazwa FROM Eventy WHERE status_eventu='AKTYWNY');
		END
		ELSE
		BEGIN
			RAISERROR('Nie ma mapy o tej nazwie', 1, 2);
		END

	END TRY
		
	BEGIN CATCH
		
		 SELECT ERROR_NUMBER()  AS 'NUMER BLEDU',
               ERROR_MESSAGE() AS 'KOMUNIKAT';

	END CATCH
GO

--przyk³ad wywo³ania
--DECLARE @liczba_eventow INT;
--EXEC usp_ilosc_aktywnych_eventow_na_mapie  'Midoria', @liczba_eventow OUTPUT;
--PRINT @liczba_eventow;
--GO



--WSTAWIAJ¥CA DANE--

CREATE OR ALTER PROCEDURE usp_wstaw_nowy_event
	@nazwa_eventu	VARCHAR(30),
	@rozpoczecie_eventu	TIME,
	@zakonczenie_eventu	TIME,
	@cyklicznosc_eventu	INT,
	@stopien_trudnosci_eventu	INT,
	@pozycja_eventu	INT
AS
	IF (@nazwa_eventu NOT IN (SELECT nazwa FROM Eventy))
		INSERT INTO Eventy (nazwa, rozpoczecie, zakonczenie, cyklicznosc_w_dniach, stopien_trudnosci, pozycja) VALUES
		(@nazwa_eventu,@rozpoczecie_eventu,@zakonczenie_eventu,@cyklicznosc_eventu,@stopien_trudnosci_eventu,@pozycja_eventu);
	ELSE
		RAISERROR('Event o podanej nazwie ju¿ istnieje. Zmieniono status tego eventu na aktywny', 1, 2);
		UPDATE Eventy SET status_eventu='AKTYWNY' WHERE nazwa=@nazwa_eventu;

GO

--przyk³ad wywo³ania
--EXEC usp_wstaw_nowy_event 'Trubadurzy na dachu','22:00:00','23:59:59',7,10,15;
--SELECT * FROM Eventy;
--GO




--USUWAJ¥CA DANE--

CREATE OR ALTER PROCEDURE usp_usun_event
	@nazwa_eventu	VARCHAR(30)
AS
	IF (@nazwa_eventu IN (SELECT nazwa FROM Eventy))
		DELETE FROM Eventy WHERE nazwa=@nazwa_eventu;
	ELSE
		RAISERROR('Event o podanej nazwie nie istnieje', 1, 2);

GO

--przyk³ad wywo³ania
--EXEC usp_usun_event 'Trubadurzy na dachu';
--SELECT * FROM Eventy;
--GO



--MODYFIKUJ¥CA DANE--

CREATE OR ALTER PROCEDURE usp_zmodyfikuj_poziom_trudnosci
	@stopien_trudnosci	INT,
	@min_lvl_mod		INT,
	@min_l_os_w_dr_mod	INT
AS
	IF @stopien_trudnosci IN (SELECT stopien_trudnosci FROM Poziomy_trudnosci)
	BEGIN
		UPDATE Poziomy_trudnosci SET minimalny_level=@min_lvl_mod, minimalna_liczba_osob_w_druzynie=@min_l_os_w_dr_mod WHERE stopien_trudnosci=@stopien_trudnosci;
	END
	ELSE
	BEGIN
		RAISERROR('Taki stopieñ trudnoœci nie istnieje', 1, 2);
	END
GO

--przyk³ad wywo³ania
--EXEC usp_zmodyfikuj_poziom_trudnosci 4, 6, 3;
--SELECT * FROM Poziomy_trudnosci;
--GO




--OPERUJ¥CA NA TABELI--

CREATE OR ALTER PROCEDURE usp_dodaj_przecinikow_do_eventu
	@id_eventu				INT,
	@id_przeciwnika			INT,
	@liczebnosc_przeciwnika	INT
AS
	IF (@id_eventu NOT IN (SELECT P1.id_eventu FROM Przeciwnicy_w_eventach P1 JOIN Przeciwnicy_w_eventach P2 ON P1.id_eventu=P2.id_eventu WHERE @id_przeciwnika=P1.id_przeciwnika))
	BEGIN
		INSERT INTO Przeciwnicy_w_eventach VALUES (@id_eventu,@id_przeciwnika,@liczebnosc_przeciwnika);
	END
	ELSE
	BEGIN
		RAISERROR('Ju¿ jest ten przeciwnik w tym evencie. Ustawiono wprowadzon¹ liczbê przeciwników', 1, 2);
		UPDATE Przeciwnicy_w_eventach SET liczebnosc_przeciwnika=@liczebnosc_przeciwnika WHERE id_eventu=@id_eventu AND id_przeciwnika=@id_przeciwnika;
	END
GO

--przyk³ad wywo³ania
--EXEC usp_dodaj_przecinikow_do_eventu 1, 1, 3;
--SELECT * FROM Przeciwnicy_w_eventach;



CREATE OR ALTER PROCEDURE usp_usun_przeciwnikow_z_eventu
	@id_eventu				INT,
	@id_przeciwnika			INT
AS
	IF (@id_eventu IN (SELECT P1.id_eventu FROM Przeciwnicy_w_eventach P1 JOIN Przeciwnicy_w_eventach P2 ON P1.id_eventu=P2.id_eventu WHERE @id_przeciwnika=P1.id_przeciwnika))
	BEGIN
		DELETE FROM Przeciwnicy_w_eventach WHERE @id_eventu=id_eventu AND @id_przeciwnika=id_przeciwnika;
	END
	ELSE
	BEGIN
		RAISERROR('Nie ma tych przeciwników w tym evencie', 1, 2);
	END
GO

--przyk³ad wywo³ania
--EXEC usp_usun_przeciwnikow_z_eventu 11, 2;
--SELECT * FROM Przeciwnicy_w_eventach;
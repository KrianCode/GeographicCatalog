--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: _dbo_kn_atedrnamebel; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_atedrnamebel (
    "KOD_ATE" numeric(6,1) DEFAULT NULL::numeric,
    "DRTNAMEBEL" character varying(18) DEFAULT NULL::character varying,
    "SINFOBEL" character varying(5) DEFAULT NULL::character varying,
    "ID" numeric(4,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_atedrnamebel OWNER TO rebasedata;

--
-- Name: _dbo_kn_atedrnamerus; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_atedrnamerus (
    "KOD_ATE" numeric(6,1) DEFAULT NULL::numeric,
    "DRTNAMERUS" character varying(19) DEFAULT NULL::character varying,
    "SINFORUS" character varying(10) DEFAULT NULL::character varying,
    "ID" numeric(4,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_atedrnamerus OWNER TO rebasedata;

--
-- Name: _dbo_kn_atevalue; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_atevalue (
    "ID_ATEVALUE" numeric(2,1) DEFAULT NULL::numeric,
    "NAMEVALUE" character varying(22) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_atevalue OWNER TO rebasedata;

--
-- Name: _dbo_kn_category; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_category (
    "ID_CATEGOR" numeric(2,1) DEFAULT NULL::numeric,
    "NKOD_CUT" character varying(5) DEFAULT NULL::character varying,
    "NKOD" character varying(22) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_category OWNER TO rebasedata;

--
-- Name: _dbo_kn_dbair; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_dbair (
    "ID_AIR" numeric(2,1) DEFAULT NULL::numeric,
    "DATEREG" character varying(19) DEFAULT NULL::character varying,
    "NAMERUS" character varying(27) DEFAULT NULL::character varying,
    "NAMEBEL" character varying(26) DEFAULT NULL::character varying,
    "NAMELAT" character varying(27) DEFAULT NULL::character varying,
    "CATEGORY" character varying(8) DEFAULT NULL::character varying,
    "OBL" numeric(2,1) DEFAULT NULL::numeric,
    "RA" numeric(4,1) DEFAULT NULL::numeric,
    "GEOPR" character varying(61) DEFAULT NULL::character varying,
    "NOMENKLAT" character varying(8) DEFAULT NULL::character varying,
    "X_WGS" numeric(6,4) DEFAULT NULL::numeric,
    "Y_WGS" numeric(6,4) DEFAULT NULL::numeric,
    "UDARRUS" character varying(7) DEFAULT NULL::character varying,
    "UDARBEL" character varying(7) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_dbair OWNER TO rebasedata;

--
-- Name: _dbo_kn_dbate; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_dbate (
    "ID_ATE" numeric(4,1) DEFAULT NULL::numeric,
    "KOD_ATE" numeric(4,1) DEFAULT NULL::numeric,
    "DATERЕG" character varying(19) DEFAULT NULL::character varying,
    "SOATO" character varying(13) DEFAULT NULL::character varying,
    "ATENAME" character varying(17) DEFAULT NULL::character varying,
    "NAMERUS" character varying(17) DEFAULT NULL::character varying,
    "UDARRUS" character varying(4) DEFAULT NULL::character varying,
    "NAMEBEL" character varying(17) DEFAULT NULL::character varying,
    "UDARBEL" character varying(5) DEFAULT NULL::character varying,
    "NAMELAT" character varying(22) DEFAULT NULL::character varying,
    "ID_RODATE" numeric(4,1) DEFAULT NULL::numeric,
    "EXISTENCE" character varying(13) DEFAULT NULL::character varying,
    "ID_OBL" numeric(2,1) DEFAULT NULL::numeric,
    "ID_RA" numeric(4,1) DEFAULT NULL::numeric,
    "SOVET" character varying(17) DEFAULT NULL::character varying,
    "ADMINCENTE" character varying(17) DEFAULT NULL::character varying,
    "ATEVALUE" numeric(2,1) DEFAULT NULL::numeric,
    "SINFORUS" character varying(14) DEFAULT NULL::character varying,
    "SINFOBEL" character varying(8) DEFAULT NULL::character varying,
    "NOMENKLAT" character varying(8) DEFAULT NULL::character varying,
    "X_WGS" numeric(8,6) DEFAULT NULL::numeric,
    "Y_WGS" numeric(9,7) DEFAULT NULL::numeric,
    "ID" numeric(4,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_dbate OWNER TO rebasedata;

--
-- Name: _dbo_kn_dbfgo; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_dbfgo (
    "ID_FGO" numeric(4,1) DEFAULT NULL::numeric,
    "DATEREG" character varying(19) DEFAULT NULL::character varying,
    "NAMEBEL" character varying(18) DEFAULT NULL::character varying,
    "UDARBEL" character varying(5) DEFAULT NULL::character varying,
    "SINFOBEL" character varying(8) DEFAULT NULL::character varying,
    "NAMERUS" character varying(18) DEFAULT NULL::character varying,
    "UDARRUS" character varying(5) DEFAULT NULL::character varying,
    "SINFORUS" character varying(7) DEFAULT NULL::character varying,
    "NAMELAT" character varying(19) DEFAULT NULL::character varying,
    "RODFGO" numeric(3,1) DEFAULT NULL::numeric,
    "EXISTENCE" character varying(13) DEFAULT NULL::character varying,
    "OBL" numeric(2,1) DEFAULT NULL::numeric,
    "RA" numeric(4,1) DEFAULT NULL::numeric,
    "GEOPR" character varying(95) DEFAULT NULL::character varying,
    "X_WGS" numeric(6,4) DEFAULT NULL::numeric,
    "Y_WGS" numeric(6,4) DEFAULT NULL::numeric,
    "NOMENKLAT" character varying(8) DEFAULT NULL::character varying,
    "BASRIVER" character varying(7) DEFAULT NULL::character varying,
    "PRITOK" character varying(1) DEFAULT NULL::character varying,
    "FALL" character varying(44) DEFAULT NULL::character varying,
    "DISTANCE" numeric(4,1) DEFAULT NULL::numeric,
    "AREA" numeric(4,2) DEFAULT NULL::numeric,
    "SUDOHOD" character varying(1) DEFAULT NULL::character varying,
    "DEPTH" numeric(2,1) DEFAULT NULL::numeric,
    "SPECNOTES" character varying(98) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_dbfgo OWNER TO rebasedata;

--
-- Name: _dbo_kn_dbfgo_nomenklat; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_dbfgo_nomenklat (
    id numeric(5,1) DEFAULT NULL::numeric,
    id_fgo numeric(5,1) DEFAULT NULL::numeric,
    nomenklat character varying(8) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_dbfgo_nomenklat OWNER TO rebasedata;

--
-- Name: _dbo_kn_dbfgo_obl_ra; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_dbfgo_obl_ra (
    id numeric(6,1) DEFAULT NULL::numeric,
    fgo_id numeric(3,1) DEFAULT NULL::numeric,
    obl numeric(2,1) DEFAULT NULL::numeric,
    ra numeric(4,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_dbfgo_obl_ra OWNER TO rebasedata;

--
-- Name: _dbo_kn_dbrw; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_dbrw (
    "ID_RW" numeric(4,1) DEFAULT NULL::numeric,
    "DATEREG" character varying(19) DEFAULT NULL::character varying,
    "ECP" numeric(7,1) DEFAULT NULL::numeric,
    "NAMERUS" character varying(22) DEFAULT NULL::character varying,
    "NAMEBEL" character varying(22) DEFAULT NULL::character varying,
    "NAMELAT" character varying(23) DEFAULT NULL::character varying,
    "NAMENORM" character varying(20) DEFAULT NULL::character varying,
    "CATEGORY" numeric(2,1) DEFAULT NULL::numeric,
    "NODS" numeric(2,1) DEFAULT NULL::numeric,
    "OBL" numeric(2,1) DEFAULT NULL::numeric,
    "RA" numeric(4,1) DEFAULT NULL::numeric,
    "GEOPR" character varying(60) DEFAULT NULL::character varying,
    "X_WGS" numeric(8,6) DEFAULT NULL::numeric,
    "Y_WGS" numeric(9,7) DEFAULT NULL::numeric,
    "NOMENKLAT" character varying(8) DEFAULT NULL::character varying,
    "UDARRUS" character varying(5) DEFAULT NULL::character varying,
    "UDARBEL" character varying(6) DEFAULT NULL::character varying,
    "EXISTENCE" character varying(10) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_dbrw OWNER TO rebasedata;

--
-- Name: _dbo_kn_fgodrtnamebel; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_fgodrtnamebel (
    "ID_FGO" numeric(4,1) DEFAULT NULL::numeric,
    "DRTNAMEBEL" character varying(22) DEFAULT NULL::character varying,
    "SINFOBEL" character varying(5) DEFAULT NULL::character varying,
    "ID" numeric(5,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_fgodrtnamebel OWNER TO rebasedata;

--
-- Name: _dbo_kn_fgodrtnamerus; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_fgodrtnamerus (
    "ID_FGO" numeric(5,1) DEFAULT NULL::numeric,
    "DRTNAMERUS" character varying(19) DEFAULT NULL::character varying,
    "SINFORUS" character varying(10) DEFAULT NULL::character varying,
    "ID" numeric(4,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_fgodrtnamerus OWNER TO rebasedata;

--
-- Name: _dbo_kn_hchangeair; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_hchangeair (
    "ID_AIR" numeric(2,1) DEFAULT NULL::numeric,
    "REDATE" character varying(19) DEFAULT NULL::character varying,
    "CHANGES" character varying(57) DEFAULT NULL::character varying,
    "NAMEDOC" character varying(27) DEFAULT NULL::character varying,
    "DATEDOC" character varying(19) DEFAULT NULL::character varying,
    "INAMEBEL" character varying(1) DEFAULT NULL::character varying,
    "INAMERUS" character varying(1) DEFAULT NULL::character varying,
    "HYPERLINK" character varying(1) DEFAULT NULL::character varying,
    "ID" numeric(2,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_hchangeair OWNER TO rebasedata;

--
-- Name: _dbo_kn_hchangeate; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_hchangeate (
    "KOD_ATE" numeric(4,1) DEFAULT NULL::numeric,
    "REDATE" character varying(19) DEFAULT NULL::character varying,
    "CHANGES" character varying(64) DEFAULT NULL::character varying,
    "NAMEDOC" character varying(99) DEFAULT NULL::character varying,
    "DATEDOC" character varying(19) DEFAULT NULL::character varying,
    "INAMEBEL" character varying(8) DEFAULT NULL::character varying,
    "INAMERUS" character varying(9) DEFAULT NULL::character varying,
    "HYPERLINK" character varying(1) DEFAULT NULL::character varying,
    "ID" numeric(6,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_hchangeate OWNER TO rebasedata;

--
-- Name: _dbo_kn_hchangefgo; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_hchangefgo (
    "ID_FGO" numeric(5,1) DEFAULT NULL::numeric,
    "REDATE" character varying(19) DEFAULT NULL::character varying,
    "CHANGES" character varying(135) DEFAULT NULL::character varying,
    "NAMEDOC" character varying(35) DEFAULT NULL::character varying,
    "DATEDOC" character varying(19) DEFAULT NULL::character varying,
    "INAMEBEL" character varying(7) DEFAULT NULL::character varying,
    "INAMERUS" character varying(18) DEFAULT NULL::character varying,
    "HYPERLINK" character varying(46) DEFAULT NULL::character varying,
    "ID" numeric(3,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_hchangefgo OWNER TO rebasedata;

--
-- Name: _dbo_kn_hchangerw; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_hchangerw (
    "ID_RW" numeric(4,1) DEFAULT NULL::numeric,
    "REDATE" character varying(19) DEFAULT NULL::character varying,
    "CHANGES" character varying(82) DEFAULT NULL::character varying,
    "NAMEDOC" character varying(63) DEFAULT NULL::character varying,
    "DATEDOC" character varying(19) DEFAULT NULL::character varying,
    "INAMEBEL" character varying(20) DEFAULT NULL::character varying,
    "INAMERUS" character varying(22) DEFAULT NULL::character varying,
    "HYPERLINK" character varying(69) DEFAULT NULL::character varying,
    "ID" numeric(3,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_hchangerw OWNER TO rebasedata;

--
-- Name: _dbo_kn_hpopular; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_hpopular (
    "KOD_ATE" numeric(3,1) DEFAULT NULL::numeric,
    "POPULAR" numeric(8,1) DEFAULT NULL::numeric,
    "DATACENSUS" character varying(19) DEFAULT NULL::character varying,
    "ID" numeric(6,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_hpopular OWNER TO rebasedata;

--
-- Name: _dbo_kn_nod; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_nod (
    "OBJECTID" numeric(3,1) DEFAULT NULL::numeric,
    "ID_NOD" numeric(2,1) DEFAULT NULL::numeric,
    "NOD_CUT" character varying(5) DEFAULT NULL::character varying,
    "NOD" character varying(13) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_nod OWNER TO rebasedata;

--
-- Name: _dbo_kn_obl; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_obl (
    "ID_OBL" numeric(2,1) DEFAULT NULL::numeric,
    "KOD_OBL" numeric(2,1) DEFAULT NULL::numeric,
    "OBL" character varying(11) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_obl OWNER TO rebasedata;

--
-- Name: _dbo_kn_ra; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_ra (
    "ID_RA" numeric(4,1) DEFAULT NULL::numeric,
    "KOD_RA" numeric(3,1) DEFAULT NULL::numeric,
    "RA" character varying(16) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying,
    "ID_OBL" numeric(2,1) DEFAULT NULL::numeric
);


ALTER TABLE public._dbo_kn_ra OWNER TO rebasedata;

--
-- Name: _dbo_kn_rodate; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_rodate (
    "ID_RODATE" numeric(4,1) DEFAULT NULL::numeric,
    "RATECUT" character varying(15) DEFAULT NULL::character varying,
    "RATENAME" character varying(43) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_rodate OWNER TO rebasedata;

--
-- Name: _dbo_kn_rodfgo; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_rodfgo (
    "RFGONAME" character varying(13) DEFAULT NULL::character varying,
    "ID_RODFGO" numeric(3,1) DEFAULT NULL::numeric,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_rodfgo OWNER TO rebasedata;

--
-- Name: _dbo_kn_sinfo; Type: TABLE; Schema: public; Owner: rebasedata
--

CREATE TABLE public._dbo_kn_sinfo (
    "ID_SINFO" numeric(3,1) DEFAULT NULL::numeric,
    "SINFOCUT" character varying(25) DEFAULT NULL::character varying,
    "SINFONAME" character varying(103) DEFAULT NULL::character varying,
    "SSMA_TimeStamp" character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE public._dbo_kn_sinfo OWNER TO rebasedata;

--
-- Data for Name: _dbo_kn_atedrnamebel; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_atedrnamebel ("KOD_ATE", "DRTNAMEBEL", "SINFOBEL", "ID", "SSMA_TimeStamp") FROM stdin;
15475.0	Наваселле	3	1.0	00000000000007D1
16402.0	Белявічы	2	2.0	00000000000007D2
10386.0	Нова-Высокае	3	3.0	00000000000007D3
15341.0	Залуцкаўшчызна	2	4.0	00000000000007D4
3015.0	Кернялёва	2,7	5.0	00000000000007D5
15422.0	Лешчынова	2,7	6.0	00000000000007D6
7067.0	Нежэлішкі	3	7.0	00000000000007D7
23342.0	д Зялёнка	3	8.0	00000000000007D8
15305.0	Паплоцк	2,7	9.0	00000000000007D9
11307.0	Радомля	19	10.0	00000000000007DA
7068.0	Павкштэлі	3	11.0	00000000000007DB
24704.0	Сідаркава	8	12.0	00000000000007DC
24059.0	в Спартак	3	13.0	00000000000007DD
6180.0	Забалацце	2,7	14.0	00000000000007DE
7296.0	Цалінова	2,7	15.0	00000000000007DF
10343.0	Ястраблі	19	16.0	00000000000007E0
9149.0	Углы	3	17.0	00000000000007E1
25423.0	Урэчча-2	2,3	18.0	00000000000007E2
8897.0	Брылек	2	19.0	00000000000007E3
24354.0	Мартынаўка	2	20.0	00000000000007E4
12305.0	Рудніцкая-Сычаўка	3	21.0	00000000000007E5
10126.0	Малінаўка	19	22.0	00000000000007E6
15848.0	Памарэч	3	23.0	00000000000007E7
23237.0	п Доркі	3	24.0	00000000000007E8
25450.0	Камянкоўскі	2	25.0	00000000000007E9
25905.0	Малае Зарэчча	2,3	26.0	00000000000007EA
23996.0	Паля	3	27.0	00000000000007EB
13439.0	Чэшчаўляны	3	28.0	00000000000007EC
3248.0	Пяткунішкі	3	29.0	00000000000007ED
3269.0	Шакелі Баравыя	2,7,8	30.0	00000000000007EE
3273.0	Шэмялькі	3	31.0	00000000000007EF
5644.0	Ціханова	3	32.0	00000000000007F0
7091.0	Стукаўшчына	7	33.0	00000000000007F1
7574.0	Межагосць	3	34.0	00000000000007F2
23521.0	Нікольскі	3	35.0	00000000000007F3
10370.0	Захаркі	3	36.0	00000000000007F4
10016.0	Некрасава	2,3	37.0	00000000000007F5
10430.0	Новаленін	2,3	38.0	00000000000007F6
10214.0	Дзмітраўка	2,3	39.0	00000000000007F7
8856.0	Пушэлаты	3	40.0	00000000000007F8
4124.0	Ніў'е	3	41.0	00000000000007F9
4390.0	Васьковічы	2	42.0	00000000000007FA
8726.0	Есяноўка	2	43.0	00000000000007FB
7977.0	Кішураўшчына	3,7	44.0	00000000000007FC
4118.0	Забалацце	2	45.0	00000000000007FD
6171.0	Валатаўкі	2	46.0	00000000000007FE
7242.0	Ецішкі	2	47.0	00000000000007FF
7047.0	Гроцкоўшчызна	2,3	48.0	0000000000000801
7253.0	Красны Ручэй	2	49.0	0000000000000802
7253.0	Чырвоны Ручэй	3	50.0	0000000000000803
9576.0	Будалюшаўскі	19	51.0	0000000000000804
25435.0	Чырвоны Кастрычнік	2,3	52.0	0000000000000805
25432.0	Забалоцце	3	53.0	0000000000000806
2716.0	Стралішча	3	54.0	0000000000000807
10389.0	Стара-Высокае	3	55.0	0000000000000808
6.0	Баўцічы	3	56.0	0000000000000809
20.0	Амневічы	2,3	57.0	000000000000080A
40.0	Задвея	3	58.0	000000000000080B
43.0	Нагорная	5	59.0	000000000000080C
25.0	Вялікалукскі	3	60.0	000000000000080D
628.0	Брашэвічскі	2	61.0	000000000000080E
4061.0	Шаркі-2	3	62.0	000000000000080F
1927.0	Загарадскі	2	63.0	0000000000000810
2205.0	Навазасімавічскі	3	64.0	0000000000000811
2205.0	Новазасімавіцкі	2	65.0	0000000000000812
2496.0	Драздоўскі	2,3	66.0	0000000000000813
2659.0	Жахаўшчына	2	67.0	0000000000000814
2500.0	Іллягова	2,3	68.0	0000000000000815
2507.0	Пяцігорск	7,8	69.0	0000000000000816
2667.0	Старае Вадапоева	2	70.0	0000000000000817
2514.0	Піліпенкі	2	71.0	0000000000000818
2514.0	Піліпінкі	3,7	72.0	0000000000000819
2530.0	Клешчына	2	73.0	000000000000081A
2642.0	Вялікія Галыні	3,7	74.0	000000000000081B
2551.0	Загруддзе	2	75.0	000000000000081C
2553.0	Чырвоныя Буднікі	2,7	76.0	000000000000081D
2559.0	Маскаленкі	2	77.0	000000000000081E
2577.0	Хмельнік	2,3	78.0	000000000000081F
2578.0	Храпавішчана	2,3	79.0	0000000000000820
2586.0	Васкрысенцы	2,3	80.0	0000000000000821
2590.0	Забалоцце	3,2	81.0	0000000000000822
2601.0	Шкалеўка	2	82.0	0000000000000823
2633.0	Наваселкі	2,3	83.0	0000000000000824
2636.0	Пясошная	3	84.0	0000000000000825
2636.0	Пясочня	7	85.0	0000000000000826
2637.0	Пліса	8	86.0	0000000000000827
2690.0	Бальшые Паўлавічы	3	87.0	0000000000000828
2692.0	Вяжы	3	88.0	0000000000000829
2700.0	Замошча	3	89.0	000000000000082A
2705.0	Ліхошын	3	90.0	000000000000082B
2712.0	Святагорава	2,3	91.0	000000000000082C
2718.0	Чарнагосця	3	92.0	000000000000082D
2719.0	Шчакатоўшчына	2,7	93.0	000000000000082E
2675.0	Ермалоўшчына	2	94.0	000000000000082F
2676.0	Жданава	2	95.0	0000000000000830
2476.0	Понізье	3	96.0	0000000000000831
2480.0	Шаурына	3	97.0	0000000000000832
2926.0	Петкунішкі	2,3	98.0	0000000000000833
2972.0	Баркоўшчына	2,7	99.0	0000000000000834
2975.0	Вацкелюны	2,3	100.0	0000000000000835
\.


--
-- Data for Name: _dbo_kn_atedrnamerus; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_atedrnamerus ("KOD_ATE", "DRTNAMERUS", "SINFORUS", "ID", "SSMA_TimeStamp") FROM stdin;
15475.0	Новоселье	3	1.0	0000000000000836
9631.0	Микольск	19	2.0	0000000000000837
9974.0	Апанасовка	19	5.0	0000000000000838
9994.0	Аполоновка	19	10.0	0000000000000839
10015.0	Нагорная	19	11.0	000000000000083A
10077.0	Рудня Прибытковская	19	12.0	000000000000083B
10161.0	Стяг Працы	19	15.0	000000000000083C
10164.0	Чирвоный Маяк	19	16.0	000000000000083D
10166.0	Перамога	19	17.0	000000000000083E
10174.0	Чирвоный Маяк	19	18.0	000000000000083F
10128.0	Микольск	19	19.0	0000000000000840
7371.0	Бержелаты	3	23.0	0000000000000841
10234.0	Селище 1	19	24.0	0000000000000842
10235.0	Селище 2	19	25.0	0000000000000843
10386.0	Ново-Высокое	3	26.0	0000000000000844
24024.0	Глинчино	3	27.0	0000000000000845
25102.0	Детковичи	2,3	28.0	0000000000000846
15341.0	Залуцковщизна	2,3,6	29.0	0000000000000847
10408.0	Бурязь	19	30.0	0000000000000848
10423.0	Великие Стеблевичи	19	31.0	0000000000000849
10450.0	Иёвичи	19	32.0	000000000000084A
3015.0	Кернелёво	2,3,7	33.0	000000000000084B
20487.0	Крыжий Луг	1	34.0	000000000000084C
5439.0	Старый Лепель	1	35.0	000000000000084D
2874.0	Лесничёвка	3,2,7	36.0	000000000000084E
15512.0	Миделишки	9	37.0	000000000000084F
15512.0	Мидалишки	5	38.0	0000000000000850
20527.0	Нарочанский	1	39.0	0000000000000851
23342.0	д Зеленка	3	40.0	0000000000000852
15296.0	Нотна	4,8	41.0	0000000000000853
15246.0	Олесина	5,6,9,8	42.0	0000000000000854
15357.0	Осинкшики	9	43.0	0000000000000855
22875.0	Понизов	3	44.0	0000000000000856
15305.0	Поплацк	3	45.0	0000000000000857
24059.0	д Спартак	3	46.0	0000000000000858
7293.0	Тимулевщина	9	47.0	0000000000000859
3161.0	Маркулева	5	48.0	000000000000085A
3161.0	Маркулево	1,4,6	49.0	000000000000085B
6180.0	Забалотье	3	50.0	000000000000085C
26522.0	Колодежки	17	51.0	000000000000085D
10197.0	Чирвоный Алёс	19	52.0	000000000000085E
10219.0	Жгуна-Буда	19	53.0	000000000000085F
10249.0	Чирвоный Камень	19	54.0	0000000000000860
10267.0	Першемайский	19	55.0	0000000000000861
10262.0	Чирвоная Гора	19	56.0	0000000000000862
10275.0	Новое Житьё	19	57.0	0000000000000863
10273.0	Чирвоный Курган	19	58.0	0000000000000864
10293.0	Миколаевка	19	59.0	0000000000000865
15370.0	Страпелишки	9	60.0	0000000000000866
15370.0	Стрепелишки	5,6	61.0	0000000000000867
10263.0	Чирвоный Костричник	19	64.0	0000000000000868
2882.0	Рогалёво	1,4,5,6	65.0	0000000000000869
7577.0	Озёрная	2,3,7	66.0	000000000000086A
558.0	Мощёнка	3,7	67.0	000000000000086B
510.0	Задворцы-Старые	4	68.0	000000000000086C
25423.0	Уречье 2	20	69.0	000000000000086D
8897.0	Брилёк	3,5,7,9	70.0	000000000000086E
12270.0	Сябровичи	19	71.0	000000000000086F
12305.0	Рудницкая-Сычевка	3	72.0	0000000000000870
4663.0	Киселевки	1,4,5,6	73.0	0000000000000871
12143.0	Руденка	1	74.0	0000000000000872
12180.0	Красный Пахарь	1	75.0	0000000000000873
12206.0	Оревичи	1	76.0	0000000000000874
12194.0	Гряда	19	77.0	0000000000000875
10126.0	Малиновка	19	78.0	0000000000000876
15793.0	Гудаловка	2	79.0	0000000000000877
15793.0	Гудуловка	6	80.0	0000000000000878
23227.0	Подольцево	3,2,20	81.0	0000000000000879
13430.0	Малыщина	5,6,9	82.0	000000000000087A
1846.0	Заречка	3,2	83.0	000000000000087B
23237.0	п Дорки	3	84.0	000000000000087C
2657.0	Свеченский	4,адм.сп	85.0	000000000000087D
15102.0	Ятровский	16	86.0	000000000000087E
10118.0	Телешовский	19	87.0	000000000000087F
13125.0	Димитровка	4,6	88.0	0000000000000880
13439.0	Чещавляны	8,16	89.0	0000000000000881
3269.0	Шакели Боровые	2	90.0	0000000000000882
4656.0	Балбеки	3,7	91.0	0000000000000883
5644.0	Тихоново	2,3,7	92.0	0000000000000884
7091.0	Стуковщина	1,7	93.0	0000000000000885
7091.0	Стукавщизна	2,6	94.0	0000000000000886
8845.0	Коморовщина	2,3	95.0	0000000000000887
8963.0	Молонка Козловская	3,2	96.0	0000000000000888
23521.0	Никольский	3	97.0	0000000000000889
9965.0	Рассуха	1	98.0	000000000000088A
10370.0	Захарки	3	99.0	000000000000088B
10370.0	Захарки 2	19	100.0	000000000000088C
12118.0	Омельковщина	1	101.0	000000000000088D
10214.0	Димитровка	19	103.0	000000000000088E
10248.0	Чирвоный Партизан	19	104.0	000000000000088F
2709.0	Осиновка	4,5,7,9,22	105.0	0000000000000890
4612.0	Слабода	3,5,6	106.0	0000000000000891
4111.0	Выгарки	22	107.0	0000000000000892
4343.0	Филипово	22	108.0	0000000000000893
5160.0	Горново 2	3,2,7,22	109.0	0000000000000894
8726.0	Есеновка	2,3	110.0	0000000000000895
6151.0	Колочево	2,3	111.0	0000000000000896
6151.0	Колачёво	7,22	112.0	0000000000000897
10430.0	Новоленин	1,19	102.0	0000000000000898
9986.0	Повднёвая	19	9.0	0000000000000899
\.


--
-- Data for Name: _dbo_kn_atevalue; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_atevalue ("ID_ATEVALUE", "NAMEVALUE", "SSMA_TimeStamp") FROM stdin;
1.0	Областной центр	000000000000089A
2.0	Районный центр	000000000000089B
3.0	Центр сельского совета	000000000000089C
4.0	Столица	000000000000089D
\.


--
-- Data for Name: _dbo_kn_category; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_category ("ID_CATEGOR", "NKOD_CUT", "NKOD", "SSMA_TimeStamp") FROM stdin;
5.0	конс.	станция на консервации	000000000000089E
3.0	оп	остановочный пункт	000000000000089F
6.0	парк	парк	00000000000008A0
2.0	пп	путевой пост	00000000000008A1
4.0	рзд	разъезд	00000000000008A2
1.0	ст	станция	00000000000008A3
7.0	обп	обгонный пункт	00000000000008A4
\.


--
-- Data for Name: _dbo_kn_dbair; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_dbair ("ID_AIR", "DATEREG", "NAMERUS", "NAMEBEL", "NAMELAT", "CATEGORY", "OBL", "RA", "GEOPR", "NOMENKLAT", "X_WGS", "Y_WGS", "UDARRUS", "UDARBEL", "SSMA_TimeStamp") FROM stdin;
8.0	2011-03-22 00:00:00	Орша	Орша	Orša	аэродром	2.0	236.0	12 км юго-западнее г. Орша	N-36-49	54.4399	30.2948	1,	1,	00000000000008A5
7.0	2011-03-22 00:00:00	Национальный аэропорт Минск	Нацыянальны аэрапорт Мінск	Nacyjanaĺny aeraport Mіnsk	аэропорт	5.0	0.0	35 км восточнее г. Минск (анклав внутри Смолевичского района)	N-35-81	53.8813	28.0337	7,19,24	7,18,23	00000000000008A6
3.0	2011-03-22 00:00:00	Гомель	Гомель	Homieĺ	аэропорт	3.0	310.0	4 км севернее г. Гомель	N-36-123	52.5263	31.0205	2,	2,	00000000000008A7
2.0	2011-03-22 00:00:00	Витебск	Віцебск	Vіciebsk	аэропорт	2.0	212.0	10 км юго-восточнее г. Витебск	N-36-25	55.1257	30.3523	2,	2,	00000000000008A8
6.0	2011-03-22 00:00:00	Могилёв	Магілёў	Mahіlioŭ	аэропорт	7.0	744.0	13 км северо-западнее г. Могилёв	N-36-73	53.9566	30.0932	6,	6,	00000000000008A9
4.0	2011-03-22 00:00:00	Гродно	Гродна	Hrodna	аэропорт	4.0	420.0	18 км юго-восточнее г. Гродно	N-35-85	53.6026	24.0537	3,	3,	00000000000008AA
1.0	2011-03-22 00:00:00	Брест	Брэст	Brest	аэропорт	1.0	112.0	17 км восточнее г. Брест	N-34-144	52.1081	23.8982	3,	3,	00000000000008AB
5.0	2011-03-22 00:00:00	Минск-1	Мінск-1	Mіnsk-1	аэропорт	5.0	0.0	4,5 км от центра г. Минск	N-35-80	54.8651	27.5398	2,	2,	00000000000008AC
\.


--
-- Data for Name: _dbo_kn_dbate; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_dbate ("ID_ATE", "KOD_ATE", "DATERЕG", "SOATO", "ATENAME", "NAMERUS", "UDARRUS", "NAMEBEL", "UDARBEL", "NAMELAT", "ID_RODATE", "EXISTENCE", "ID_OBL", "ID_RA", "SOVET", "ADMINCENTE", "ATEVALUE", "SINFORUS", "SINFOBEL", "NOMENKLAT", "X_WGS", "Y_WGS", "ID", "SSMA_TimeStamp") FROM stdin;
0.0	11.0	2004-03-01 00:00:00	1.204812026E9	Душковцы	Душковцы		Душкаўцы	8,	Duškaŭcy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-88	53.362328	25.9428050	11.0	00000000000008AD
0.0	12.0	2004-03-01 00:00:00	1.204812032E9	Зелёная	Зелёная	4	Зялёная	4	Zialionaja	231.0	существует	1.0	104.0	Городищенский с/с		0.0	2,3,23	2,3,23	N-35-88	53.360313	25.9716730	12.0	00000000000008AE
0.0	3.0	2004-03-01 00:00:00	1.204812906E9	Городище	Городище	6,	Гарадзішча	7,	Haradzіšča	121.0	существует	1.0	104.0	Городищенский с/с		3.0	1,2,3,23	2,3,23	N-35-101	53.327554	26.0084270	3.0	00000000000008AF
0.0	21.0	2004-03-01 00:00:00	1.204812077E9	Поручин	Поручин		Паручын	6,	Paručyn	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-89	53.365400	26.0012810	21.0	00000000000008B0
0.0	17.0	2004-03-01 00:00:00	1.204812053E9	Мостытычи	Мостытычи		Мастытычы	5,	Mastytyčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-88	53.348154	25.9645820	17.0	00000000000008B1
0.0	18.0	2004-03-01 00:00:00	1.204812058E9	Насейки	Насейки		Насейкі	4,	Nasiejkі	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-88	53.362516	25.9574300	18.0	00000000000008B2
0.0	15.0	2004-03-01 00:00:00	1.20481204E9	Конюшовщина	Конюшовщина		Канюшоўшчына	6,	Kaniušoŭščyna	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-88	53.353675	25.9796970	15.0	00000000000008B3
0.0	19.0	2004-03-01 00:00:00	1.204812063E9	Новосёлки	Новосёлки		Навасёлкі		Navasiolkі	231.0	существует	1.0	104.0	Городищенский с/с		0.0	2,3,23	2,3,23	N-35-101	53.271965	25.9994020	19.0	00000000000008B4
0.0	29.0	2004-03-01 00:00:00	1.204804026E9	Копани	Копани		Капані	6,	Kapanі	231.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.085289	26.0661350	29.0	00000000000008B5
0.0	20.0	2004-03-01 00:00:00	1.204812071E9	Омневичи	Омневичи		Амнявічы	6,	Amniavіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	23	N-35-88	53.354668	25.8982560	20.0	00000000000008B6
0.0	24.0	2004-03-01 00:00:00	1.204812105E9	Ясенец	Ясенец		Ясянец	5,	Jasianiec	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-89	53.352487	26.0644950	24.0	00000000000008B7
0.0	70.0	2004-03-01 00:00:00	1.204815011E9	Важгинты	Важгинты		Важгінты	5,	Važhіnty	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.154556	25.7567030	70.0	00000000000008B8
0.0	23.0	2004-03-01 00:00:00	1.204812094E9	Станкевичи	Станкевичи		Станкевічы	6,	Stankievіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-100	53.297248	25.9763600	23.0	00000000000008B9
0.0	27.0	2004-03-01 00:00:00	1.204804016E9	Грабовец	Грабовец		Грабавец	7,	Hrabaviec	231.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.090561	26.0595960	27.0	00000000000008BA
0.0	13.0	2004-03-01 00:00:00	1.204812037E9	Кисели	Кисели		Кісялі	6,	Kіsialі	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-100	53.329471	25.9804640	13.0	00000000000008BB
0.0	5.0	2004-03-01 00:00:00	1.204812003E9	Арабовщина	Арабовщина		Арабаўшчына	3,	Arabaŭščyna	235.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.261937	26.0442660	5.0	00000000000008BC
0.0	7.0	2004-03-01 00:00:00	1.204812008E9	Бриксичи	Бриксичи		Брыксічы	3,	Bryksіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,4,23	2,3,23	N-35-89	53.335094	26.0193560	7.0	00000000000008BD
0.0	14.0	2004-03-01 00:00:00	1.204812039E9	Колдычево	Колдычево		Калдычэва	7,	Kaldyčeva	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.282336	26.0541580	14.0	00000000000008BE
0.0	26.0	2004-03-01 00:00:00	1.204804011E9	Великие Луки	Великие Луки		Вялікія Лукі	4,10,	Vialіkіja Lukі	231.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.006186	26.0505250	26.0	00000000000008BF
0.0	28.0	2004-03-01 00:00:00	1.204804021E9	Кабушкина	Кабушкина		Кабушкіна	2,	Kabuškіna	232.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,5	2,3,7,23	N-35-101	53.042416	26.0745610	28.0	00000000000008C0
0.0	31.0	2004-03-01 00:00:00	1.204804041E9	Малые Луки	Малые Луки		Малыя Лукі	4,8,	Malyja Lukі	231.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.019756	26.0516240	31.0	00000000000008C1
0.0	2.0	2004-03-01 00:00:00	1.204E9	Барановичский	Барановичский	4,	Баранавіцкі	4,	Baranavіckі	102.0	существует	1.0	104.0		г Барановичи	0.0	4,23	23	N-35-101	53.130943	26.0112160	2.0	00000000000008C2
0.0	32.0	2004-03-01 00:00:00	1.204804046E9	Новые Луки	Новые Луки	2,8,	Новыя Лукі	2,8,	Novyja Lukі	231.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.026601	26.0674390	32.0	00000000000008C3
0.0	30.0	2004-03-01 00:00:00	1.204804031E9	Крыжики	Крыжики	3,	Крыжыкі	3,	Kryžykі	231.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.068243	26.0658210	30.0	00000000000008C4
0.0	25.0	2004-03-01 00:00:00	1.204804E9	Великолукский	Великолукский	8,	Велікалуцкі	8,	Vielіkaluckі	103.0	существует	1.0	104.0		аг Русино	0.0	1,2,3,23	23	N-35-101	53.088397	26.0855150	25.0	00000000000008C5
0.0	35.0	2004-03-01 00:00:00	1.204807E9	Вольновский	Вольновский	2,	Вольнаўскі	2,	Voĺnaŭskі	103.0	существует	1.0	104.0		аг Вольно	0.0	1,2,3,23	3,23	N-35-101	53.298455	26.2288720	35.0	00000000000008C6
0.0	34.0	2004-03-01 00:00:00	1.204804056E9	Яново	Яново		Янова	3,	Janova	231.0	существует	1.0	104.0	Великолукский с/с		0.0	1,2,3,7,23	2,3,7,23	N-35-101	53.114028	26.0756430	34.0	00000000000008C7
0.0	22.0	2004-03-01 00:00:00	1.204812079E9	Пруды	Пруды		Пруды	5,	Prudy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-89	53.352487	26.0644950	22.0	00000000000008C8
0.0	9.0	2004-03-01 00:00:00	1.204812017E9	Гарановичи	Гарановичи		Гаранавічы	4,	Haranavіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-88	53.352177	25.9136570	9.0	00000000000008C9
0.0	95.0	2004-03-01 00:00:00	1.204812075E9	Переволока	Переволока		Пярэвалака	4,	Piarevalaka	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	23	N-35-101	53.318656	26.0647960	95.0	00000000000008CA
0.0	62.0	2004-03-01 00:00:00	1.204812061E9	Новинки	Новинки		Навінкі	4,	Navіnkі	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.290918	25.8826450	62.0	00000000000008CB
0.0	61.0	2004-03-01 00:00:00	1.204812059E9	Нестеры	Нестеры		Несцяры	7,	Niesciary	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,4,5,7,23	2,3,7,23	N-35-100	53.317530	25.9567300	61.0	00000000000008CC
0.0	60.0	2004-03-01 00:00:00	1.204812056E9	Нагорная	Нагорная		Нагорная	4,	Nahornaja	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,4,5,6,23	2,23	N-35-100	53.318982	25.9469020	60.0	00000000000008CD
0.0	59.0	2004-03-01 00:00:00	1.204812048E9	Лозы	Лозы		Лозы	2,	Lozy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-88	53.337859	25.9362890	59.0	00000000000008CE
0.0	57.0	2004-03-01 00:00:00	1.204812042E9	Красевичи	Красевичи		Красявічы	7,	Krasiavіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.271084	25.9592950	57.0	00000000000008CF
0.0	56.0	2004-03-01 00:00:00	1.204812038E9	Ковши	Ковши		Каўшы	5,	Kaŭšy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.241950	25.9255020	56.0	00000000000008D0
0.0	55.0	2004-03-01 00:00:00	1.20481203E9	Железница	Железница		Жалезніца	4,	Žalieznіca	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.265823	25.8915090	55.0	00000000000008D1
0.0	33.0	2004-03-01 00:00:00	1.204804051E9	Русино	Русино		Русіно	6,	Rusіno	235.0	существует	1.0	104.0	Великолукский с/с		3.0	1,2,3,23	2,3,23	N-35-101	53.088397	26.0855150	33.0	00000000000008D2
0.0	39.0	2004-03-01 00:00:00	1.204807021E9	Голынка	Голынка		Галынка	4,	Halynka	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.247735	26.3033380	39.0	00000000000008D3
67.0	67.0	2004-03-01 00:00:00	1.204815E9	Жемчужненский	Жемчужненский	5,	Жамчужненскі	5,	Žamčužnienskі	103.0	существует	1.0	104.0		аг Жемчужный	0.0	23	2,3,23	N-35-100	53.130600	25.7411000	67.0	00000000000008D4
0.0	54.0	2004-03-01 00:00:00	1.204812028E9	Жабинцы	Жабинцы		Жабінцы	2,	Žabіncy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.291201	25.9157420	54.0	00000000000008D5
0.0	40.0	2004-03-01 00:00:00	1.204807026E9	Задвея	Задвея		Задзвея	6,	Zadzvieja	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,7,23	2,7,23	N-35-101	53.309588	26.2754560	40.0	00000000000008D6
0.0	41.0	2004-03-01 00:00:00	1.204807031E9	Залесье	Залесье		Залессе	4,	Zaliessie	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.284155	26.1733250	41.0	00000000000008D7
0.0	42.0	2004-03-01 00:00:00	1.204807036E9	Лихосельцы	Лихосельцы		Ліхасельцы	6,	Lіchasieĺcy	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.248619	26.3194150	42.0	00000000000008D8
0.0	43.0	2004-03-01 00:00:00	1.204807041E9	Нагорное	Нагорное	4,	Нагорнае	4,	Nahornaje	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,23	2,3,7,23	N-35-101	53.253495	26.2724370	43.0	00000000000008D9
0.0	44.0	2004-03-01 00:00:00	1.204807046E9	Нижнее Чернихово	Нижнее Чернихово		Ніжняе Чэрніхава	2,9,	Nіžniaje Černіchava	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,4,5,6,7,23	7,23	N-35-101	53.246169	26.2873820	44.0	00000000000008DA
0.0	45.0	2004-03-01 00:00:00	1.204807051E9	Озерец	Озерец		Азярэц	5,	Aziarec	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,23	2,3,23	N-35-101	53.297893	26.1428150	45.0	00000000000008DB
0.0	46.0	2004-03-01 00:00:00	1.204807056E9	Рабковичи	Рабковичи		Рабковічы	5,	Rabkovіčy	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,5,7,23	3,23	N-35-101	53.311941	26.2578340	46.0	00000000000008DC
0.0	47.0	2004-03-01 00:00:00	1.204807061E9	Россошь	Россошь		Росаш	2,	Rosaš	234.0	существует	1.0	104.0	Вольновский с/с		0.0	1	2,23	N-35-101	53.323768	26.1918940	47.0	00000000000008DD
0.0	49.0	2004-03-01 00:00:00	1.204807071E9	Тишковцы	Тишковцы		Цішкоўцы	5,	Cіškoŭcy	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,23	23	N-35-101	53.221906	26.3031193	49.0	00000000000008DE
0.0	50.0	2004-03-01 00:00:00	1.204807076E9	Чернихово	Чернихово		Чэрніхава	2,	Černіchava	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,23	2,3,23	N-35-101	53.244613	26.2489500	50.0	00000000000008DF
0.0	52.0	2004-03-01 00:00:00	1.204812006E9	Богуши	Богуши		Багушы	6,	Bahušy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.303165	25.9471030	52.0	00000000000008E0
0.0	48.0	2004-03-01 00:00:00	1.204807066E9	Савичи	Савичи		Савічы	2,	Savіčy	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,23	2,3,23	N-35-101	53.281666	26.2839740	48.0	00000000000008E1
0.0	69.0	2004-03-01 00:00:00	1.204815006E9	Бор	Бор		Бор	2,	Bor	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.194403	25.7411750	69.0	00000000000008E2
0.0	68.0	2004-03-01 00:00:00	1.204815001E9	Альбинки	Альбинки		Альбінкі	5,	Aĺbіnkі	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.126271	25.7352030	68.0	00000000000008E3
0.0	66.0	2004-03-01 00:00:00	1.204812093E9	Соколовичи	Соколовичи		Сакаловічы	6,	Sakalovіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.256476	25.9241110	66.0	00000000000008E4
0.0	96.0	2004-03-01 00:00:00	1.204812083E9	Рудаши	Рудаши		Рудашы	6,	Rudašy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.368092	26.1613160	96.0	00000000000008E5
0.0	65.0	2004-03-01 00:00:00	1.204812089E9	Слабожаны	Слабожаны	7,	Слабажаны	7,	Slabažany	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3	2,3,7,23	N-35-100	53.325619	25.9072200	65.0	00000000000008E6
0.0	97.0	2004-03-01 00:00:00	1.204812088E9	Скробово	Скробово		Скробава	4,	Skrobava	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-101	53.329129	26.1011820	97.0	00000000000008E7
0.0	38.0	2004-03-01 00:00:00	1.204807016E9	Вольно	Вольно		Вольна	2,	Voĺna	235.0	существует	1.0	104.0	Вольновский с/с		3.0	1,2,3,23	2,3,23	N-35-101	53.298455	26.2288720	38.0	00000000000008E8
0.0	91.0	2004-03-01 00:00:00	1.204812045E9	Кутовщина	Кутовщина		Кутаўшчына	2,	Kutaŭščyna	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.351732	26.0807950	91.0	00000000000008E9
0.0	83.0	2004-03-01 00:00:00	1.204815081E9	Тепливоды	Тепливоды		Цяплівады	5,	Ciaplіvady	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	23	N-35-100	53.148850	25.8113560	83.0	00000000000008EA
0.0	98.0	2004-03-01 00:00:00	1.204812092E9	Советский	Советский		Савецкі	4,	Savieckі	232.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.340772	26.1065520	98.0	00000000000008EB
0.0	73.0	2004-03-01 00:00:00	1.204815026E9	Детковичи	Детковичи		Дзеткавічы	3,	Dzietkavіčy	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.115886	25.6976500	73.0	00000000000008EC
0.0	72.0	2004-03-01 00:00:00	1.204815021E9	Деколы	Деколы		Дзекалы	7,	Dziekaly	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,2,3,7,23	3,7,23	N-35-100	53.123180	25.6893240	72.0	00000000000008ED
0.0	76.0	2004-03-01 00:00:00	1.204815041E9	Зверовщина	Зверовщина		Звераўшчына	3,	Zvieraŭščyna	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.206859	25.7107460	76.0	00000000000008EE
0.0	71.0	2004-03-01 00:00:00	1.204815016E9	Гордейчики	Гордейчики		Гардзейчыкі	6,	Hardziejčykі	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.115293	25.7476380	71.0	00000000000008EF
0.0	79.0	2004-03-01 00:00:00	1.204815061E9	Свираны	Свираны		Свіраны	5,	Svіrany	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.188358	25.7173470	79.0	00000000000008F0
0.0	82.0	2004-03-01 00:00:00	1.204815076E9	Спочинок	Спочинок		Спачынак	5,	Spačynak	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	23	N-35-100	53.118825	25.8222820	82.0	00000000000008F1
0.0	80.0	2004-03-01 00:00:00	1.204815066E9	Севрюки	Севрюки		Сеўрукі	7,	Sieŭrukі	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1	2,3,23	N-35-100	53.136569	25.8065510	80.0	00000000000008F2
0.0	78.0	2004-03-01 00:00:00	1.204815056E9	Переносины	Переносины		Пераносіны	6,	Pieranosіny	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.173020	25.7284740	78.0	00000000000008F3
0.0	77.0	2004-03-01 00:00:00	1.204815051E9	Небыты	Небыты		Небыты	2,	Niebyty	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.134487	25.7741660	77.0	00000000000008F4
0.0	84.0	2004-03-01 00:00:00	1.204815086E9	Тиунцы	Тиунцы		Цівунцы	4,	Cіvuncy	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,2,3,7,23	3,23	N-35-100	53.104015	25.7584680	84.0	00000000000008F5
0.0	81.0	2004-03-01 00:00:00	1.204815071E9	Сосновая	Сосновая		Сасновая	5,	Sasnovaja	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.097445	25.7485730	81.0	00000000000008F6
0.0	101.0	2004-03-01 00:00:00	1.204830003E9	Адаховщина	Адаховщина		Адахаўшчына	3,	Adachaŭščyna	231.0	существует	1.0	104.0	Крошинский с/с		0.0	1,23	2,3,23	N-35-101	53.153642	26.1538800	101.0	00000000000008F7
0.0	74.0	2004-03-01 00:00:00	1.204815031E9	Дубище	Дубище		Дубішча	2,	Dubіšča	231.0	существует	1.0	104.0	Жемчужненский с/с		0.0	1,23	2,3,23	N-35-100	53.155317	25.7847960	74.0	00000000000008F8
0.0	58.0	2004-03-01 00:00:00	1.204812043E9	Крепочи	Крепочи		Крапачы	3,	Krapačy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1	2,3,23	N-35-100	53.286368	25.9578920	58.0	00000000000008F9
0.0	92.0	2004-03-01 00:00:00	1.204812051E9	Митропольщина	Митропольщина		Мітрапольшчына	7,	Mіtrapoĺščyna	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.364043	26.1512930	92.0	00000000000008FA
0.0	99.0	2004-03-01 00:00:00	1.204812099E9	Трацевичи	Трацевичи		Трацэвічы	5,	Tracevіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	3,23	N-35-89	53.354987	26.1303200	99.0	00000000000008FB
85.0	85.0	2004-03-01 00:00:00	1.20482E9	Карчевский	Карчёвский		Карчоўскі	5,	Karčoŭskі	103.0	не существует	1.0	104.0		аг Карчёво	0.0	1,23	2,3,23	N-35-89	53.363900	26.1208000	85.0	00000000000008FC
100.0	100.0	2004-03-01 00:00:00	1.204826E9	Колпеницкий	Колпеницкий	5,	Каўпеніцкі	5,	Kaŭpienіckі	103.0	не существует	1.0	104.0		д Малая Колпеница	0.0	1,23	23	N-35-101	53.163600	26.0375000	100.0	00000000000008FD
0.0	36.0	2004-01-03 00:00:00	1.204807006E9	Бартники	Бартники		Бартнікі	2,	Bartnіkі	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.305450	26.1702840	36.0	00000000000008FE
0.0	1.0	2004-03-01 00:00:00	1.0E9	Брестская	Брестская	3,	Брэсцкая	3,	Bresckaja	101.0	существует	1.0	0.0		г Брест	0.0			N-34-144	52.101700	23.7208000	1.0	00000000000008FF
0.0	86.0	2004-03-01 00:00:00	1.204812009E9	Бытковщина	Бытковщина		Быткоўшчына	5,	Bytkoŭščyna	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	3,23	N-35-89	53.346342	26.1077810	86.0	0000000000000901
0.0	90.0	2004-03-01 00:00:00	1.204812035E9	Карчёво	Карчёво		Карчова	5,	Karčova	235.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.365035	26.1172720	90.0	0000000000000902
0.0	53.0	2004-03-01 00:00:00	1.204812019E9	Гирмантовцы	Гирмантовцы		Гірмантаўцы	2,	Hіrmantaŭcy	235.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.275226	25.9194460	53.0	0000000000000903
0.0	88.0	2004-03-01 00:00:00	1.204812015E9	Высадовичи	Высадовичи		Высадавічы	2,	Vysadavіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.366290	26.1883180	88.0	0000000000000904
0.0	87.0	2004-03-01 00:00:00	1.204812014E9	Вызорок	Вызорок	2,	Вызарак	2,	Vyzarak	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	23	N-35-101	53.309763	26.0988410	87.0	0000000000000905
0.0	89.0	2004-03-01 00:00:00	1.204812022E9	Гречихи	Гречихи		Грачыхі	5,	Hračychі	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.361816	26.0794430	89.0	0000000000000906
0.0	93.0	2004-03-01 00:00:00	1.204812069E9	Олизаровщина	Олизаровщина		Алізараўшчына	5,	Alіzaraŭščyna	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.356237	26.0880630	93.0	0000000000000907
0.0	75.0	2004-03-01 00:00:00	1.204815036E9	Жемчужный	Жемчужный		Жамчужны	5,	Žamčužny	235.0	существует	1.0	104.0	Жемчужненский с/с		3.0	1,23	2,3,23	N-35-100	53.137656	25.8712570	75.0	0000000000000908
0.0	10.0	2004-03-01 00:00:00	1.204812023E9	Грибовщина	Грибовщина		Грыбаўшчына	3,	Hrybaŭščyna	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,23	2,3,23	N-35-101	53.314273	26.0387000	10.0	0000000000000909
0.0	63.0	2004-03-01 00:00:00	1.204812067E9	Огородники	Огородники		Агароднікі	5,	Aharodnіkі	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.254892	25.8789650	63.0	000000000000090A
0.0	8.0	2004-03-01 00:00:00	1.204812012E9	Великое Село	Великое Село	4,12	Вялікае Сяло	4,12,	Vialіkaje Sialo	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,4,5,7,23	2,3,7,23	N-35-101	53.310826	26.0000210	8.0	000000000000090B
0.0	94.0	2004-03-01 00:00:00	1.204812074E9	Пенчин	Пенчин		Пянчын	5,	Piančyn	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-89	53.340772	26.1065520	94.0	000000000000090C
0.0	64.0	2004-03-01 00:00:00	1.204812087E9	Селявичи	Селявичи		Сялявічы	4,	Sialiavіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,23	2,3,23	N-35-100	53.297767	25.9427120	64.0	000000000000090D
51.0	51.0	2004-03-01 00:00:00	1.204811E9	Гирмантовский	Гирмантовский	2,	Гірмантаўскі	2,	Hіrmantaŭskі	103.0	не существует	1.0	104.0		аг Гирмантовцы	0.0	23	2,3,23	N-35-100	53.275600	25.9236000	51.0	000000000000090E
0.0	6.0	2004-03-01 00:00:00	1.204812007E9	Болтичи	Болтичи		Боўцічы	2,	Boŭcіčy	231.0	существует	1.0	104.0	Городищенский с/с		0.0	1,2,3,5,7,23	2,7,23	N-35-89	53.360302	26.0353010	6.0	000000000000090F
0.0	37.0	2004-03-01 00:00:00	1.204807011E9	Верхнее Чернихово	Верхнее Чернихово		Верхняе Чэрніхава	2,10,	Vierchniaje Černіchava	231.0	существует	1.0	104.0	Вольновский с/с		0.0	1,2,3,5,7,23	2,3,7,23	N-35-101	53.244671	26.2323910	37.0	0000000000000910
0.0	4.0	2004-03-01 00:00:00	1.204812E9	Городищенский	Городищенский	6	Гарадзішчанскі	7,	Haradzіščanskі	103.0	существует	1.0	104.0		гп Городище	0.0	1,2,3,23	2,3,23	N-35-101	53.327554	26.0084270	4.0	0000000000000911
\.


--
-- Data for Name: _dbo_kn_dbfgo; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_dbfgo ("ID_FGO", "DATEREG", "NAMEBEL", "UDARBEL", "SINFOBEL", "NAMERUS", "UDARRUS", "SINFORUS", "NAMELAT", "RODFGO", "EXISTENCE", "OBL", "RA", "GEOPR", "X_WGS", "Y_WGS", "NOMENKLAT", "BASRIVER", "PRITOK", "FALL", "DISTANCE", "AREA", "SUDOHOD", "DEPTH", "SPECNOTES", "SSMA_TimeStamp") FROM stdin;
12.0	2003-08-26 00:00:00	Мутвіца	2,	12	Мутьвица	2,	4,12	Mutvіca	21.0	существует	1.0	156.0		52.7858	24.8975	N-35-110	Припять	п	р. Ружанка	0.0	0.00		0.0		0000000000000912
8.0	2003-08-26 00:00:00	Калода	4,	10,12	Колода	4,	4,12	Kaloda	21.0	существует	1.0	156.0		52.7975	24.8883	N-35-110	Припять	л	р. Ружанка	4.0	0.00		0.0		0000000000000913
9.0	2003-08-26 00:00:00	Цемра	2,	10,12	Темра	2,	4,12	Ciemra	21.0	существует	1.0	156.0		52.7233	24.5275	N-35-110	Припять	л	р. Ясельда	20.0	0.00		0.0		0000000000000914
10.0	2003-08-26 00:00:00	Гуцкi	2,	10,12	Гутский	2,	4,12	Hucki	10.0	существует	1.0	156.0		52.7569	24.5944	N-35-110	Припять	п	р. Темра	7.6	0.00		0.0		0000000000000915
11.0	2003-08-26 00:00:00	Ружанка	4,	12	Ружанка	4,	4,12	Ružanka	21.0	существует	1.0	156.0		52.8967	24.8725	N-35-110	Припять	п	р. Зельвянки	19.0	0.00		0.0		0000000000000916
13.0	2003-08-26 00:00:00	Козіца	2,	12	Козица	2,	4,12	Kozіca	9.0	существует	1.0	156.0		52.7342	24.5461	N-35-110	Припять	п	р. Темра	0.0	0.00		0.0		0000000000000917
14.0	2003-08-26 00:00:00	Смалянiца	7,	10,12	Смоляница	7,	4,12	Smalianica	10.0	существует	1.0	156.0		52.7053	24.5478	N-35-110	Припять	л	р. Ясельда	6.5	0.00		0.0		0000000000000918
15.0	2003-08-26 00:00:00	Белка	2,	12	Белка	2,	4,12	Bielka	10.0	существует	1.0	156.0	4 км на ЮЗ о д. Смоляница, левобережье р. Ясельда	52.6922	24.5828	N-35-110	Припять			0.0	0.00		0.0		0000000000000919
18.0	2003-08-26 00:00:00	Хатава	6,	10,12	Хотова	6,	4,12	Chatava	21.0	существует	1.0	104.0		52.6344	24.8306	N-35-122	Припять	л	р. Ясельда	24.0	0.00		0.0		000000000000091A
17.0	2003-08-26 00:00:00	Мацоўка	4,	10,12	Мацовка	4,	4,12	Macoŭka	21.0	существует	1.0	156.0		52.6703	24.7397	N-35-110	Припять	п	р. Хотова	0.0	0.00		0.0	Хотова в верхнем	000000000000091B
19.0	2003-08-26 00:00:00	Туроса	4,	12	Туроса	4,	4,12	Turosa	21.0	существует	1.0	134.0	Название канавы Плоская в верхнем течении	52.6992	24.9025	N-35-110	Припять			0.0	0.00		0.0		000000000000091C
20.0	2003-08-26 00:00:00	Бронная	3,	10,12	Бронная	3,	4,12	Bronnaja	21.0	существует	1.0	134.0		52.6667	25.0000	N-35-111	Припять	л	кан. Плоская	5.0	0.00		0.0		000000000000091D
22.0	2003-08-26 00:00:00	Ражковiцкi	5,	10,12	Рожковичский	5,	4,12	Ražkovicki	10.0	существует	1.0	156.0	в верхнем течении - кан. Колядичский	52.6772	24.5583	N-35-110	Припять	п	р. Ясельда,	13.4	0.00		0.0		000000000000091E
23.0	2003-08-26 00:00:00	Орля	1,	12	Орля	1,	4,12	Orlia	21.0	существует	1.0	134.0		52.6589	25.0561	N-35-123	Припять	л	кан. Плоская	6.6	0.00		0.0		000000000000091F
24.0	2003-08-26 00:00:00	Фядоска	4,	10,12	Федоска	4,	4,12	Fiadoska	21.0	существует	1.0	134.0		52.6533	25.0914	N-35-123	Припять	л	р. Жегулянка	15.0	0.00		0.0		0000000000000920
27.0	2003-08-26 00:00:00	Свяцiцкая	5,	10,12	Святицкая	5,	4,12	Sviacickaja	9.0	существует	1.0	150.0		52.7369	25.9386	N-35-112	Нёман	л	р. Щара	0.0	0.00		0.0		0000000000000921
28.0	2003-08-26 00:00:00	Восьмы	2,	10,12	Восьмой	6,	4,12	Vośmy	10.0	существует	1.0	134.0		52.6761	25.5053	N-35-112	Нёман	п	кан. Коссовский	20.0	0.00		0.0		0000000000000922
29.0	2003-08-26 00:00:00	Клячытна	5,	12	Клечитна	5,	4,12	Kliačytna	21.0	существует	1.0	150.0		52.7000	25.9750	N-35-112	Припять		оз. Выгонощанское	0.0	0.00		0.0		0000000000000923
30.0	2003-08-26 00:00:00	Выганашчанскае	9,	10,12	Выгонощанское	8,	4,12,13	Vyhanaščanskaje	14.0	существует	1.0	134.0	37 км на В от г. Ивацевичи, около д. Выгонощи	52.6667	25.9583	N-35-112	Припять			0.0	26.00		0.0		0000000000000924
31.0	2003-08-26 00:00:00	Любашаўскае	4,	10,12	Любашево	4,	4,12	Liubašaŭskaje	1.0	существует	1.0	116.0	5 км на С от г. Ганцевичи, 1 км на С от д. Любашево	52.8044	26.4275	N-35-113	Припять			0.0	0.76		0.0		0000000000000925
33.0	2003-08-26 00:00:00	Качайла	4,	10	Качайло	4,	4,12	Kačajla	14.0	существует	1.0	150.0	35 км на ЮЗ от г. Ляховичи, 5 км на Ю от д. Новосёлки, басс. р. Щара	52.7306	26.1503	N-35-113	Припять			0.0	0.06		0.0		0000000000000926
34.0	2003-08-26 00:00:00	Шчыльнае	3,	10,12	Щильное	2,	4,12	Ščyĺnaje	14.0	существует	1.0	116.0	Южная окраина г. Ганцевичи	52.7283	26.4778	N-35-113	Припять			0.0	0.00		0.0		0000000000000927
36.0	2003-08-26 00:00:00	Качайскае	4,	10,12	Качайское	4,	4,12	Kačajskaje	14.0	существует	1.0	116.0	5 км на ЮЗ от г. Ганцевичи, басс. р. Цна	52.7119	26.4061	N-35-113	Припять			0.0	0.17		0.0		0000000000000928
6.0	2003-08-26 00:00:00	Водападводзячы 2-i	9,	12	Водоподводящий 2-й	11,	4,12	Vodapadvodziačy 2-i	10.0	существует	1.0	156.0		52.6933	24.5458	N-35-110	Припять	п	р. Ясельда	0.0	0.00		0.0		0000000000000929
5.0	2003-08-26 00:00:00	Кушлiцкi	5,	10,12	Кушликский	5,	4,12	Kušlicki	10.0	существует	1.0	156.0		52.7242	24.4119	N-35-109	Припять	п	кан. Черпаковский	5.0	0.00		0.0		000000000000092A
39.0	2003-08-26 00:00:00	Выдранка	5,	10	Выдренка	2,	4,12	Vydranka	21.0	существует	1.0	116.0		52.6808	26.5119	N-35-114	Припять	п	р. Цна	9.2	0.00		0.0		000000000000092B
43.0	2003-08-26 00:00:00	Лактышы	7,	10,12	Локтыши	7,	4,12	Laktyšy	1.0	существует	1.0	116.0	20 км на В от г. Ганцевичи, между д. Локтыши, д. Будча	52.8025	26.7467	N-35-114	Припять			0.0	15.90		0.0		000000000000092C
47.0	2003-08-26 00:00:00	Крынiчная	5,	10,12	Криничная	5,	4,12	Kryničnaja	9.0	существует	1.0	147.0		52.6358	26.9997	N-35-127	Припять	п	кан. Плесса	12.4	0.00		0.0		000000000000092D
48.0	2003-08-26 00:00:00	Бохнава	2,	12	Бохново	2,	4,12	Bochnava	14.0	существует	1.0	116.0	1,8 км на С от д. Переволоки	52.7750	27.0111	N-35-115	Припять			0.0	0.00		0.0		000000000000092E
49.0	2003-08-26 00:00:00	Стары	5,	12	Старый	3,	4,12	Stary	9.0	не существует	1.0	156.0		52.6536	24.5128	N-35-122	Припять	л	кан. Рожковичский	0.0	0.00		0.0		000000000000092F
51.0	2003-08-26 00:00:00	Нет сведений			Острова		4	Niet sviedienиj	13.0	не существует	1.0	156.0	2,3 км на СВ от д. Скорцы	52.6350	24.7036	N-35-122	Припять			0.0	0.00		0.0		0000000000000930
53.0	2003-08-26 00:00:00	Мартусавы Ямы	2,11,	12	Мартусовы Ямы	2,11,	4,12	Martusavy Jamy	14.0	существует	1.0	108.0	6,8 км на З от г. Берёза, 1,9 км на ЮЗ от д. Селовщина	52.5444	24.8892	N-35-122	Припять			0.0	0.00		0.0		0000000000000931
54.0	2003-08-26 00:00:00	Башта	2,	10,12	Башта	2,	4,12	Bašta	21.0	существует	1.0	108.0		52.6022	24.8919	N-35-122	Припять	п	р. Ясельда	0.0	0.00		0.0		0000000000000932
55.0	2003-08-26 00:00:00	Крэчат	3,	10,12	Кречет	3,	4,12	Krečat	22.0	существует	1.0	108.0		52.5347	25.0044	N-35-123	Припять	п	р. Ясельда	15.0	0.00		0.0		0000000000000933
56.0	2003-08-26 00:00:00	Задваранскі	7,	12	Задворянский	7,	4,12	Zadvaranskі	10.0	существует	1.0	156.0		52.5269	24.6581	N-35-122	Припять	п	кан. Винец	0.0	0.00		0.0		0000000000000934
59.0	2003-08-26 00:00:00	Чарняўка	5,	10,12	Чернявка	5,	4,12	Čarniaŭka	21.0	существует	1.0	108.0		52.4272	24.8508	N-35-122	Припять	л	кан. Винец	0.0	0.00		0.0		0000000000000935
60.0	2003-08-26 00:00:00	Калядзіцкі	4,	12	Колядичский	4,	4,12	Kaliadzіckі	10.0	существует	1.0	156.0	Название кан. Рожковичский в верхнем течении	52.6000	24.5861	N-35-122	Припять			0.0	0.00		0.0		0000000000000936
61.0	2003-08-26 00:00:00	Нет сведений			Копейна		4	Niet sviedienиj	9.0	существует	1.0	134.0	Является началом канала Давыдовский	52.6092	25.3364	N-35-123	Припять			0.0	0.00		0.0		0000000000000937
63.0	2003-08-26 00:00:00	Рульеў	2,	12	Рульев	2,	4,12	Ruĺjeŭ	10.0	существует	1.0	134.0		52.5731	25.2169	N-35-123	Припять	л	кан. Лешковский	6.0	0.00		0.0		0000000000000938
64.0	2003-08-26 00:00:00	Жыгулянка	6,	10,12	Жегулянка	6,	4	Žyhulianka	21.0	существует	1.0	108.0	Название р. Дорогобуж в верхнем течении	52.4500	25.2472	N-35-123	Припять			0.0	0.00		0.0		0000000000000939
65.0	2003-08-26 00:00:00	Корачын	2,	12	Корочин	2,	4,12	Koračyn	14.0	существует	1.0	134.0	около д. Корочин	52.5556	25.3478	N-35-123	Припять			0.0	0.00		0.0		000000000000093A
66.0	2003-08-26 00:00:00	Хадакоўскi	6,	12	Ходаковский	6,	4,12	Chadakoŭski	10.0	существует	1.0	134.0		52.5497	25.4500	N-35-123	Припять	л	кан. Главный	0.0	0.00		0.0		000000000000093B
68.0	2003-08-26 00:00:00	Башта	2,	12	Башта	2,	4,12	Bašta	10.0	существует	1.0	108.0		52.6028	24.8917	N-35-122	Припять	п	р. Ясельда	0.0	0.00		0.0		000000000000093C
69.0	2003-08-26 00:00:00	Давыдавiцкi	4,	10,12	Давидовичский	4,	4	Davydavicki	10.0	существует	1.0	108.0		52.5450	24.6583	N-35-122	Припять	л	кан. Винец	0.0	0.00		0.0		000000000000093D
70.0	2003-08-26 00:00:00	Сялец	4,	10	Селец	4,	4	Sialiec	1.0	существует	1.0	108.0	7 км на СЗ от г. Берёза, около д. Селец	52.6217	24.8500	N-35-122	Припять			0.0	20.70		0.0		000000000000093E
71.0	2003-08-26 00:00:00	Углянскi	4,	10,12	Углянский	4,	4,12	Uhlianski	10.0	существует	1.0	108.0		52.4847	25.0156	N-35-123	Припять	п	р. Ясельда	11.6	0.00		0.0		000000000000093F
73.0	2003-08-26 00:00:00	Давыдаўскi	4,	12	Давыдовский	4,	4,12	Davydaŭski	10.0	существует	1.0	134.0		52.5008	25.3322	N-35-123	Припять	л	кан. Главный	15.0	0.00		0.0		0000000000000940
74.0	2003-08-26 00:00:00	Будскі	2,	12	Будский	2,	4,12	Budskі	10.0	существует	1.0	108.0	. Берет начало в 4 км к СЗ от д. Корочин, впадает в 5,5 км к ЮЗ от д. Корочин	52.5311	25.2222	N-35-123	Припять	л	кан. Главный Правый	0.0	0.00		0.0		0000000000000941
75.0	2003-08-26 00:00:00	Тмінскі	3,	12	Тминский	3,	4,12	Tmіnskі	10.0	существует	1.0	108.0	Вытекает из кан.Главный, на В от оз. Чёрное	52.4897	25.2700	N-35-123	Припять			0.0	0.00		0.0		0000000000000942
77.0	2003-08-26 00:00:00	Чорнае	2,	10,12	Чёрное		4,12	Čornaje	14.0	существует	1.0	108.0	17 км на ЮВ от г. Берёза, 2,5 км на В от г. Белоозерск	52.4786	25.2458	N-35-123	Припять			0.0	0.00		0.0		0000000000000943
78.0	2003-08-26 00:00:00	Безымянны	6,	12	Безымянный	6,	4,12	Biezymianny	10.0	существует	1.0	108.0		52.4786	25.0300	N-35-123	Припять	л	р. Ясельда	0.0	0.00		0.0		0000000000000944
38.0	2003-08-26 00:00:00	Горнае	2,	12	Горное	2,	4,12	Hornaje	14.0	существует	1.0	116.0	7 км на Ю от г. Ганцевичи	52.6986	26.4644	N-35-113	Припять			0.0	0.00		0.0		0000000000000945
84.0	2003-08-26 00:00:00	Цёплы		12	Тёплый		4,12	Cioply	10.0	существует	1.0	108.0	Связывает оз. Белое и оз. Чёрное	52.4208	25.1681	N-35-123	Припять			0.0	0.00		0.0		0000000000000946
87.0	2003-08-26 00:00:00	Гніліца	3,	12	Гнилица	3,	4,12	Hnіlіca	14.0	существует	1.0	108.0	2,8 км на ЮЗ от д. Спорово	52.4006	25.3058	N-35-123	Припять			0.0	0.00		0.0		0000000000000947
88.0	2003-08-26 00:00:00	Хомск			Хомск		4	Chomsk	1.0	существует	1.0	120.0	17 км на СВ от г. Дрогичин, около д. Хомск	52.3453	25.1889	N-35-123	Припять			0.0	0.00		0.0		0000000000000948
89.0	2003-08-26 00:00:00	Ласiнцы	4,	10,12	Лосинцы	4,	4,12	Lasincy	22.0	существует	1.0	120.0		52.0306	25.1728	N-35-135	Припять	п	р. Ясельда	22.0	0.00		0.0		0000000000000949
91.0	2003-08-26 00:00:00	Дзевяты	5,	10,12	Девятый	4,	4,12	Dzieviaty	10.0	существует	1.0	134.0		52.5503	25.5303	N-35-124	Припять	п	кан. Коссовский	18.0	0.00		0.0		000000000000094A
92.0	2003-08-26 00:00:00	Вузенькі	2,	12	Узенький	1,	4,12	Vuzieńkі	10.0	существует	1.0	134.0		52.6139	25.5500	N-35-124	Припять	п	кан. Главный	0.0	0.00		0.0		000000000000094B
95.0	2003-08-26 00:00:00	Першы	2,	12	Первый	2,	4,12	Pieršy	10.0	существует	1.0	134.0		52.6278	25.5575	N-35-124	Припять	л	кан. Узенький	5.4	0.00		0.0		000000000000094C
96.0	2003-08-26 00:00:00	Пісарава	2,	12	Писарева	2,	4,12	Pіsarava	10.0	существует	1.0	134.0		52.6069	25.5089	N-35-124	Припять	п	кан. Главный	0.0	0.00		0.0		000000000000094D
97.0	2003-08-26 00:00:00	Вулькаўскае	2,	10,12	Вульковское	2,	4,12	Vuĺkaŭskaje	14.0	существует	1.0	134.0	39 км на ЮВ от г. Ивацевичи, около д. Вулька Телеханская, басс. р. Ясельда	52.5389	25.8697	N-35-124	Припять			0.0	0.51		0.0		000000000000094E
98.0	2003-08-26 00:00:00	Сомiнскае	2,	12	Соминское	2,	4,12	Sominskaje	14.0	существует	1.0	134.0	44 км на ЮВ от г. Ивацевичи, около д. Сомино	52.5364	25.6000	N-35-124	Припять			0.0	0.41		0.0		000000000000094F
82.0	2003-08-26 00:00:00	Халодны	4,	12	Холодный	4,	4,12	Chalodny	10.0	существует	1.0	108.0		52.4347	25.1653	N-35-123	Припять		оз. Белое с В	0.0	0.00		0.0		0000000000000950
83.0	2003-08-26 00:00:00	Белае	2,	10,12	Белое	2,	4,12	Bielaje	14.0	существует	1.0	108.0	14 км на ЮВ от г. Берёза, 3,8 км на ЮЗ от г. Белоозерск, басс. р. Ясельда	52.4328	25.1531	N-35-123	Припять			0.0	0.00		0.0		0000000000000951
50.0	2003-08-26 00:00:00	Радагошч	6,	12	Радогощ	6,	4,12	Radahošč	21.0	существует	1.0	108.0	впадает в вдхр. Селец с С	52.6458	24.8736	N-35-122	Припять	л	р. Ясельда,	0.0	0.00		0.0		0000000000000952
52.0	2003-08-26 00:00:00	Вiнец	4,	10,12	Винец	4,	4,12	Viniec	10.0	существует	1.0	108.0		52.4319	25.0672	N-35-123	Припять	п	р. Ясельда	0.0	0.00		0.0		0000000000000953
72.0	2003-08-26 00:00:00	Запасечная	4,	10,12	Запасечная	4,	4,12	Zapasiečnaja	9.0	существует	1.0	108.0		52.4939	25.3597	N-35-123	Припять	л	кан. Главный	8.1	0.00		0.0		0000000000000954
76.0	2003-08-26 00:00:00	Доўгi	2,	10,12	Долгий	2,	4,12	Doŭhi	10.0	существует	1.0	108.0		52.4492	25.4125	N-35-123	Припять	л	кан. Главный	7.0	0.00		0.0		0000000000000955
79.0	2003-08-26 00:00:00	Прыстаньская	3,	12	Пристаньская	3,	4,12	Prystańskaja	9.0	существует	1.0	108.0		52.4372	25.4361	N-35-123	Припять	л	кан. Главный	0.0	0.00		0.0		0000000000000956
80.0	2003-08-26 00:00:00	Жыдаўка	2,	10,12	Жидовка	4,	4,12	Žydaŭka	10.0	существует	1.0	108.0		52.4103	25.4972	N-35-123	Припять	л	р. Ясельда	0.0	0.00		0.0		0000000000000957
85.0	2003-08-26 00:00:00	Спораўскае	3,	10,12	Споровское	3,	4,12	Sporaŭskaje	14.0	существует	1.0	108.0	26 км на ЮВ от г. Берёза, около д. Спорово, басс. р. Ясельда	52.4069	25.3500	N-35-123	Припять			0.0	11.50		0.0		0000000000000958
90.0	2003-08-26 00:00:00	Ляшкоўскi	5,	10,12	Лешковский	5,	4,12	Liaškoŭski	10.0	существует	1.0	108.0		52.5414	25.1894	N-35-123	Припять	л	р. Жегулянка	9.0	0.00		0.0		0000000000000959
93.0	2003-08-26 00:00:00	Агiнскi	3,	10,12	Огинский	3,	4,12	Ahinski	10.0	существует	1.0	134.0	Часть бывшего Днепровско-Нёманского канала	52.2708	25.9328	N-35-136	Припять	л	р. Ясельда	54.0	0.00		0.0		000000000000095A
99.0	2003-08-26 00:00:00	Стрэлка	4,	10	Стрелка	4,	4	Strelka	10.0	существует	1.0	134.0		52.3858	25.6419	N-35-124	Припять	л	кан. Главный Обровский	17.7	0.00		0.0		000000000000095B
100.0	2003-08-26 00:00:00	Галоўны Аброўскi	4,12,	10,12	Главный Обровский	3,12,	4,12	Haloŭny Abroŭski	10.0	существует	1.0	134.0	Берет начало в 3,5 км на ЮЗ от д. Великая Гать	52.3683	25.7050	N-35-124	Припять	п	кан. Ясельдовский.	0.0	0.00		0.0	Впадение в 6,5 км к СВ от д. Тышковичи	000000000000095C
101.0	2003-08-26 00:00:00	Аброўскi	4,	12	Обровский	4,	4,12	Abroŭski	10.0	существует	1.0	134.0	Берёт начало в 6,2 км на З от д. Великая Гать. В верхнем течении - Ямный канал	52.3753	25.5747	N-35-124	Припять	л	р. Ясельда	0.0	0.00		0.0		000000000000095D
67.0	2003-08-26 00:00:00	Лясны	5,	12	Лесной	5,	4,12	Liasny	22.0	существует	1.0	108.0		52.6414	24.8222	N-35-122	Припять	л	р. Хотова	0.0	0.00		0.0		000000000000095E
44.0	2003-08-26 00:00:00	Плеса	3,	12,58	Плесса	3,	4,12,58	Pliesa	9.0	существует	1.0	147.0		52.5778	27.0272	N-35-127	Припять	л	кан. Заозерская	0.0	0.00		0.0		000000000000095F
35.0	2003-08-26 00:00:00	Цна		10,12	Цна		4,12	Cna	21.0	существует	1.0	150.0		52.1633	27.0303	N-35-139	Припять	л	р. Припять	0.0	0.00		0.0		0000000000000960
42.0	2003-08-26 00:00:00	Лань		10,12,58	Лань		4,12,58	Lań	21.0	существует	1.0	147.0		52.1578	27.2997	N-35-139	Припять	л	р. Припять	147.0	0.00		0.0		0000000000000961
25.0	2003-08-26 00:00:00	Косаўскi	2,	10,12	Коссовский	2,	4,12	Kosaŭski	10.0	существует	1.0	134.0		52.7467	25.4442	N-35-111	Нёман	п	р. Гривда	16.0	0.00		0.0		0000000000000962
1.0	2003-08-26 00:00:00	Нача	2,	10,12	Нача	2,	4,12	Nača	21.0	существует	1.0	150.0	Начинается на З от д. Конюхи Ляховичского р-на, устье в 2 км на В от д. Начь Ганцевичского р-на	52.8611	26.6667	N-35-114	Припять	п	р. Лань	42.0	0.00		0.0		0000000000000963
3.0	2003-08-26 00:00:00	Сплёты		10,12	Сплёты		4,12	Splioty	10.0	существует	1.0	156.0		52.7250	24.4561	N-35-109	Припять	л	кан. Кушликский	10.4	0.00		0.0		0000000000000964
4.0	2003-08-26 00:00:00	Чарпакоўскi	7,	10,12	Черпаковский	7,	4,12	Čarpakoŭski	10.0	существует	1.0	156.0		52.7278	24.5244	N-35-110	Припять	п	р. Ясельда	11.6	0.00		0.0		0000000000000965
26.0	2003-08-26 00:00:00	Галенчыцкае	4,	12	Голенчицкое	4,	4,12	Halienčyckaje	14.0	существует	1.0	134.0	5 км на В от г. Ивацевичи, около д. Голенчицы	52.7022	25.4239	N-35-111	Припять			0.0	0.00		0.0		0000000000000966
37.0	2003-08-26 00:00:00	Жабы	2,	12	Жабы	2,	4,12	Žaby	14.0	существует	1.0	116.0	5,5 км на ЮЗ от г. Ганцевичи, 3 км на ЮВ от д. Борки	52.7161	26.3750	N-35-113	Припять			0.0	0.00		0.0		0000000000000967
58.0	2003-08-26 00:00:00	Чарнiчны	5,	10,12	Черничный	5,	4,12	Čarničny	10.0	существует	1.0	108.0	в 1,5 км на В от д. Туловщина	52.5411	24.6633	N-35-122	Припять	л	р. Винец	0.0	0.00		0.0	Начинается около д. Сосновка	0000000000000968
81.0	2003-08-26 00:00:00	Храхоўская	5,	12	Хроховская	5,	4,12	Chrachoŭskaja	9.0	существует	1.0	130.0		52.4072	25.4833	N-35-123	Припять	л	кан. Главный	0.0	0.00		0.0		0000000000000969
94.0	2003-08-26 00:00:00	Бабровiцкае	5,	10,12	Бобровичское	5,	4,12	Babrovickaje	14.0	существует	1.0	134.0	30 км на ЮВ от г. Ивацевичи, около д. Бобровичи, басс. р. Гривда	52.6322	25.7864	N-35-124	Припять			0.0	9.47		0.0		000000000000096A
41.0	2003-08-26 00:00:00	Бобрык	2,	10,12	Бобрик	2,	4,12	Bobryk	21.0	существует	1.0	154.0		52.1375	26.7694	N-35-138	Припять	л	р. Припять	109.0	0.00		0.0		000000000000096B
7.0	2003-08-26 00:00:00	Чарэшынка	3,4,	10,12	Черешинка	4,	4,12	Čarešynka	21.0	существует	1.0	156.0		52.8222	24.8792	N-35-110	Припять	л	р. Ружанка	5.5	0.00		0.0		000000000000096C
21.0	2003-08-26 00:00:00	Плоская	3,	10,12	Плоская	3,	4,12	Ploskaja	9.0	существует	1.0	134.0	в верхнем течении - р. Туроса	52.6533	25.0914	N-35-123	Припять	п	р. Жегулянка,	0.0	0.00		0.0		000000000000096D
40.0	2003-08-26 00:00:00	Дубаўское	8,	10,12	Дубовское	8,	4,12	Dubaŭskoje	14.0	существует	1.0	116.0	9 км на Ю от г. Ганцевичи,1км на В от д. Полонь	52.6667	26.4728	N-35-113	Припять			0.0	0.20		0.0		000000000000096E
86.0	2003-08-26 00:00:00	Дарагабуж	8,	12	Дорогобуж	8,	4,12	Darahabuž	21.0	существует	1.0	108.0	в верхнем течении - р. Жегулянка (Жегулянский канал)	52.3967	25.2886	N-35-123	Припять	л	р. Ясельда,	0.0	0.00		0.0		000000000000096F
57.0	2003-08-26 00:00:00	Панасавiцкi	8,	10,12	Панасовичский	4,	4,12	Panasavicki	10.0	существует	1.0	108.0		52.6256	24.7333	N-35-122	Припять	п	р. Ясельда	8.5	0.00		0.0		0000000000000970
62.0	2003-08-26 00:00:00	Галоўны	4,	10,12	Главный	3,	4,12	Haloŭny	10.0	существует	1.0	108.0	Начинается с Днепровско-Бугского канала, 5 км на ЮВ от д. Житлин Ивацевичского р-на	52.4283	25.3558	N-35-123	Припять		оз.Споровское с СВ	0.0	0.00		0.0		0000000000000971
2.0	2003-08-26 00:00:00	Ясельда	1,	10,12	Ясельда	1,	4,12	Jasieĺda	21.0	существует	1.0	108.0		52.1172	26.4478	N-35-137	Припять	л	р. Припять	250.0	0.00		0.0	Начинается в 4 км на С от д. Клепачи Пружанского района, устье около д. Качановичи Пинского района	0000000000000972
45.0	2003-08-26 00:00:00	Стрыжава	4,	10,12	Стрижево	4,	4,12	Stryžava	10.0	существует	1.0	116.0	Начинается в 3 км на ЮВ от д. Шашки Ганцевичского р-на	52.5875	26.7792	N-35-126	Припять		канал на мелиорационной системе "Волчанская"	25.0	0.00		0.0	Устье - 4 км на ЮЗ от д. Бол. Чучевичи	0000000000000973
46.0	2003-08-26 00:00:00	Ланскi	2,	10,12	Ланьский	2,	4,12	Lanski	10.0	существует	1.0	116.0	Начинается в 1 км на З от д. Будча, устье - 10 км на ЮВ от д. Денисковичи	52.5875	26.7667	N-35-126	Припять	л	кан. Заозерская	11.0	0.00		0.0		0000000000000974
16.0	2003-08-26 00:00:00	Дзiкае	3,	12	Дикое	2,	4,12	Dzikaje	14.0	существует	1.0	134.0	5,2 км на Ю от д. Островок Пружанского района	52.7358	24.9844	N-35-110	Припять			0.0	0.00		0.0		0000000000000975
\.


--
-- Data for Name: _dbo_kn_dbfgo_nomenklat; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_dbfgo_nomenklat (id, id_fgo, nomenklat, "SSMA_TimeStamp") FROM stdin;
1380.0	395.0	N-35-112	0000000000000976
1381.0	395.0	N-35-99	0000000000000977
1382.0	3190.0	N-35-109	0000000000000978
1383.0	3197.0	N-35-41	0000000000000979
1384.0	3197.0	N-35-53	000000000000097A
1385.0	3197.0	N-35-54	000000000000097B
1386.0	3197.0	N-35-44	000000000000097C
1387.0	3197.0	N-35-55	000000000000097D
1388.0	3197.0	N-35-56	000000000000097E
1389.0	3224.0	N-35-52	000000000000097F
1390.0	3224.0	N-35-53	0000000000000980
1391.0	3225.0	N-35-52	0000000000000981
1392.0	3225.0	N-35-53	0000000000000982
1393.0	3226.0	N-35-53	0000000000000983
1394.0	3231.0	N-35-52	0000000000000984
1395.0	3240.0	N-35-54	0000000000000985
1396.0	3250.0	N-35-53	0000000000000986
1397.0	3251.0	N-35-53	0000000000000987
1398.0	3260.0	N-35-64	0000000000000988
1399.0	3261.0	N-35-52	0000000000000989
1400.0	3261.0	N-35-64	000000000000098A
1401.0	3263.0	N-35-62	000000000000098B
1402.0	3263.0	N-35-75	000000000000098C
1403.0	3265.0	N-35-63	000000000000098D
1404.0	3266.0	N-35-63	000000000000098E
1405.0	3268.0	N-35-63	000000000000098F
1406.0	3268.0	N-35-64	0000000000000990
1407.0	3268.0	N-35-75	0000000000000991
1408.0	3269.0	N-35-64	0000000000000992
1409.0	3271.0	N-35-61	0000000000000993
1410.0	3272.0	N-35-64	0000000000000994
1411.0	3273.0	N-35-63	0000000000000995
1412.0	3277.0	N-35-65	0000000000000996
1413.0	3283.0	N-35-64	0000000000000997
1414.0	3285.0	N-35-64	0000000000000998
1415.0	3285.0	N-35-76	0000000000000999
1416.0	3292.0	N-35-64	000000000000099A
1417.0	3292.0	N-35-65	000000000000099B
1418.0	3314.0	N-35-73	000000000000099C
1419.0	3317.0	N-34-84	000000000000099D
1420.0	3331.0	N-35-73	000000000000099E
1421.0	3331.0	N-35-74	000000000000099F
1422.0	3331.0	N-35-62	00000000000009A0
1423.0	3332.0	N-35-74	00000000000009A1
1424.0	3348.0	N-35-74	00000000000009A2
1425.0	3357.0	N-35-73	00000000000009A3
1426.0	3359.0	N-35-73	00000000000009A4
1427.0	3362.0	N-35-74	00000000000009A5
1428.0	3368.0	N-35-74	00000000000009A6
1429.0	3369.0	N-35-73	00000000000009A7
1430.0	3370.0	N-35-74	00000000000009A8
1431.0	3372.0	N-35-74	00000000000009A9
1432.0	3375.0	N-35-75	00000000000009AA
1433.0	3384.0	N-35-75	00000000000009AB
1434.0	3389.0	N-35-74	00000000000009AC
1435.0	3389.0	N-35-75	00000000000009AD
1436.0	3390.0	N-35-74	00000000000009AE
1437.0	3390.0	N-35-86	00000000000009AF
1438.0	3392.0	N-35-75	00000000000009B0
1450.0	3402.0	N-35-76	00000000000009B1
1451.0	3403.0	N-35-87	00000000000009B2
1452.0	3403.0	N-35-88	00000000000009B3
1453.0	3406.0	N-35-76	00000000000009B4
1454.0	3408.0	N-35-76	00000000000009B5
1455.0	3410.0	N-35-75	00000000000009B6
1456.0	3421.0	N-35-76	00000000000009B7
1457.0	3421.0	N-35-64	00000000000009B8
1458.0	3423.0	N-35-77	00000000000009B9
1459.0	3423.0	N-35-65	00000000000009BA
1460.0	3423.0	N-35-66	00000000000009BB
1461.0	3423.0	N-35-67	00000000000009BC
1462.0	3431.0	N-35-76	00000000000009BD
1463.0	3435.0	N-35-76	00000000000009BE
1464.0	3435.0	N-35-88	00000000000009BF
1465.0	3437.0	N-35-65	00000000000009C0
1466.0	3437.0	N-35-66	00000000000009C1
1467.0	3440.0	N-35-65	00000000000009C2
1468.0	3440.0	N-35-66	00000000000009C3
1469.0	3440.0	N-35-78	00000000000009C4
1470.0	3440.0	N-35-79	00000000000009C5
1471.0	3442.0	N-35-78	00000000000009C6
1472.0	3451.0	N-35-89	00000000000009C7
1473.0	3454.0	N-35-88	00000000000009C8
1474.0	3454.0	N-35-89	00000000000009C9
1475.0	3455.0	N-35-89	00000000000009CA
1476.0	3456.0	N-35-89	00000000000009CB
1477.0	3457.0	N-35-78	00000000000009CC
1478.0	3461.0	N-34-96	00000000000009CD
1479.0	3463.0	N-34-96	00000000000009CE
1480.0	3466.0	N-34-96	00000000000009CF
1481.0	3467.0	N-34-96	00000000000009D0
1482.0	3468.0	N-34-96	00000000000009D1
1483.0	3468.0	N-34-108	00000000000009D2
1484.0	3468.0	N-35-97	00000000000009D3
1485.0	3470.0	N-35-97	00000000000009D4
1486.0	3470.0	N-35-85	00000000000009D5
1487.0	3476.0	N-35-86	00000000000009D6
1488.0	3476.0	N-35-74	00000000000009D7
1489.0	3476.0	N-35-75	00000000000009D8
1490.0	3479.0	N-35-86	00000000000009D9
\.


--
-- Data for Name: _dbo_kn_dbfgo_obl_ra; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_dbfgo_obl_ra (id, fgo_id, obl, ra, "SSMA_TimeStamp") FROM stdin;
6701.0	2.0	1.0	108.0	00000000000009DA
6702.0	2.0	1.0	130.0	00000000000009DB
6703.0	2.0	1.0	154.0	00000000000009DC
6704.0	3.0	1.0	156.0	00000000000009DD
6705.0	4.0	1.0	156.0	00000000000009DE
6706.0	5.0	1.0	156.0	00000000000009DF
6707.0	6.0	1.0	156.0	00000000000009E0
6708.0	7.0	1.0	156.0	00000000000009E1
6709.0	8.0	1.0	156.0	00000000000009E2
6710.0	9.0	1.0	156.0	00000000000009E3
6711.0	10.0	1.0	156.0	00000000000009E4
6712.0	11.0	1.0	156.0	00000000000009E5
6713.0	12.0	1.0	156.0	00000000000009E6
6714.0	12.0	1.0	134.0	00000000000009E7
6715.0	13.0	1.0	156.0	00000000000009E8
6716.0	14.0	1.0	156.0	00000000000009E9
6717.0	15.0	1.0	156.0	00000000000009EA
6719.0	17.0	1.0	156.0	00000000000009EB
6722.0	19.0	1.0	134.0	00000000000009EC
6723.0	20.0	1.0	134.0	00000000000009ED
6724.0	21.0	1.0	134.0	00000000000009EE
6725.0	22.0	1.0	156.0	00000000000009EF
6726.0	23.0	1.0	134.0	00000000000009F0
6727.0	24.0	1.0	134.0	00000000000009F1
6728.0	25.0	1.0	134.0	00000000000009F2
6729.0	26.0	1.0	134.0	00000000000009F3
6730.0	27.0	1.0	150.0	00000000000009F4
6731.0	28.0	1.0	134.0	00000000000009F5
6732.0	29.0	1.0	150.0	00000000000009F6
6733.0	30.0	1.0	134.0	00000000000009F7
6734.0	31.0	1.0	116.0	00000000000009F8
6735.0	33.0	1.0	150.0	00000000000009F9
6736.0	34.0	1.0	116.0	00000000000009FA
6741.0	36.0	1.0	116.0	00000000000009FB
6742.0	37.0	1.0	116.0	00000000000009FC
6743.0	38.0	1.0	116.0	00000000000009FD
6744.0	39.0	1.0	116.0	00000000000009FE
6745.0	40.0	1.0	116.0	00000000000009FF
6746.0	41.0	1.0	154.0	0000000000000A01
6747.0	41.0	1.0	150.0	0000000000000A02
6748.0	41.0	1.0	147.0	0000000000000A03
6749.0	41.0	1.0	116.0	0000000000000A04
6755.0	43.0	1.0	116.0	0000000000000A05
6758.0	45.0	1.0	116.0	0000000000000A06
6759.0	45.0	1.0	147.0	0000000000000A07
6760.0	46.0	1.0	116.0	0000000000000A08
6761.0	46.0	1.0	147.0	0000000000000A09
6762.0	47.0	1.0	147.0	0000000000000A0A
6763.0	48.0	1.0	116.0	0000000000000A0B
6764.0	49.0	1.0	156.0	0000000000000A0C
6765.0	50.0	1.0	108.0	0000000000000A0D
6766.0	50.0	1.0	156.0	0000000000000A0E
6767.0	51.0	1.0	156.0	0000000000000A0F
6768.0	52.0	1.0	108.0	0000000000000A10
6769.0	52.0	1.0	156.0	0000000000000A11
6770.0	53.0	1.0	108.0	0000000000000A12
6771.0	54.0	1.0	108.0	0000000000000A13
6772.0	55.0	1.0	108.0	0000000000000A14
6773.0	56.0	1.0	156.0	0000000000000A15
6774.0	57.0	1.0	108.0	0000000000000A16
6775.0	57.0	1.0	156.0	0000000000000A17
6776.0	58.0	1.0	108.0	0000000000000A18
6777.0	59.0	1.0	108.0	0000000000000A19
6778.0	60.0	1.0	156.0	0000000000000A1A
6779.0	61.0	1.0	134.0	0000000000000A1B
6780.0	62.0	1.0	108.0	0000000000000A1C
6781.0	62.0	1.0	134.0	0000000000000A1D
6782.0	63.0	1.0	134.0	0000000000000A1E
6783.0	64.0	1.0	108.0	0000000000000A1F
6784.0	65.0	1.0	134.0	0000000000000A20
6785.0	66.0	1.0	134.0	0000000000000A21
6786.0	67.0	1.0	108.0	0000000000000A22
6787.0	67.0	1.0	156.0	0000000000000A23
6788.0	68.0	1.0	108.0	0000000000000A24
6789.0	69.0	1.0	108.0	0000000000000A25
6790.0	70.0	1.0	108.0	0000000000000A26
6791.0	71.0	1.0	108.0	0000000000000A27
6792.0	72.0	1.0	108.0	0000000000000A28
6793.0	72.0	1.0	134.0	0000000000000A29
6794.0	73.0	1.0	134.0	0000000000000A2A
6795.0	74.0	1.0	108.0	0000000000000A2B
6796.0	75.0	1.0	108.0	0000000000000A2C
8572.0	1.0	1.0	150.0	0000000000000A2D
8573.0	1.0	1.0	116.0	0000000000000A2E
8574.0	1.0	6.0	625.0	0000000000000A2F
8575.0	35.0	1.0	150.0	0000000000000A30
8576.0	35.0	1.0	116.0	0000000000000A31
8577.0	35.0	1.0	147.0	0000000000000A32
8578.0	35.0	6.0	625.0	0000000000000A33
8579.0	42.0	1.0	147.0	0000000000000A34
8580.0	42.0	1.0	116.0	0000000000000A35
8581.0	42.0	6.0	642.0	0000000000000A36
8582.0	42.0	6.0	650.0	0000000000000A37
8583.0	42.0	6.0	625.0	0000000000000A38
8584.0	44.0	1.0	147.0	0000000000000A39
8585.0	44.0	6.0	650.0	0000000000000A3A
11300.0	16.0	1.0	134.0	0000000000000A3B
11428.0	18.0	1.0	104.0	0000000000000A3C
11429.0	18.0	1.0	108.0	0000000000000A3D
11430.0	18.0	1.0	156.0	0000000000000A3E
\.


--
-- Data for Name: _dbo_kn_dbrw; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_dbrw ("ID_RW", "DATEREG", "ECP", "NAMERUS", "NAMEBEL", "NAMELAT", "NAMENORM", "CATEGORY", "NODS", "OBL", "RA", "GEOPR", "X_WGS", "Y_WGS", "NOMENKLAT", "UDARRUS", "UDARBEL", "EXISTENCE", "SSMA_TimeStamp") FROM stdin;
30.0	2010-12-20 00:00:00	138437.0	Барановичи-Северные	Баранавічы-Паўночныя	Baranavіčy-Paŭnočnyja	Барановичи-Павночные	1.0	2.0	1.0	0.0	г. Барановичи	53.153908	26.0154351	N-35-101	4,13,	4,16,	существует	0000000000000A3F
31.0	2010-12-20 00:00:00	138507.0	Барановичи-Центральные	Баранавічы-Цэнтральныя	Baranavіčy-Centraĺnyja		1.0	2.0	1.0	0.0	г. Барановичи	53.132153	25.9935383	N-35-100	4,17	4, 17,	существует	0000000000000A40
15.0	2010-12-20 00:00:00	157724.0	Антоновка	Антонаўка	Antonaŭka		3.0	5.0	7.0	744.0	1,0 км на ЮЗ от д. Городня	53.840508	30.6072106	N-36-74	4	4	существует	0000000000000A41
17.0	2010-12-20 00:00:00	154726.0	Антополь	Антопаль	Antopaĺ		3.0	4.0	3.0	345.0	1 км на С от д. Антополь	52.336357	30.2278171	N-36-121	4	4	существует	0000000000000A42
16.0	2010-12-20 00:00:00	132816.0	Антополь	Антопаль	Antopaĺ		3.0	3.0	1.0	120.0	1,6 км на Ю от г.п. Антополь	52.189587	24.7819863	N-35-134	4,	4	существует	0000000000000A43
13.0	2010-12-20 00:00:00	161607.0	Алёща	Алёшча	Aliošča		1.0	6.0	2.0	238.0	д. Алёща	55.734474	29.3300012	N-35-11	3,	3	существует	0000000000000A44
51.0	2010-12-20 00:00:00	133700.0	Берёза-Картузская	Бяроза-Картузская	Biaroza-Kartuzskaja		1.0	3.0	1.0	108.0	д. Первомайская	52.532955	24.8994016	N-35-122	12	4, 12	существует	0000000000000A45
14.0	2010-12-20 00:00:00	136249.0	Андреевичи	Андрэевічы	Andrejevіčy		4.0	2.0	4.0	408.0	д. Андреевичи	53.111416	24.3003101	N-35-97	5	5	существует	0000000000000A46
88.0	2010-12-20 00:00:00	130204.0	Брест-Восточный	Брэст-Усходні	Brest-Uschodnі	Брест-Усходний	1.0	3.0	1.0	0.0	г. Брест	52.110271	23.7272760	N-34-144	11	10	существует	0000000000000A47
28.0	2010-12-20 00:00:00	0.0	Барановичи-Восточные	Баранавічы-Усходнія	Baranavіčy-Uschodnіja	Барановичи-Павночные	5.0	2.0	1.0	0.0	северо-восточная окраина г. Барановичи	53.151791	26.0418891	N-35-101	4, 16	4, 15	существует	0000000000000A48
89.0	2010-12-20 00:00:00	130308.0	Брест-Полесский	Брэст-Палескі	Brest-Palieskі		1.0	3.0	1.0	0.0	г. Брест	52.094589	23.7105017	N-34-144	10	10	существует	0000000000000A49
33.0	2010-12-20 00:00:00	156127.0	Баркалабово	Баркалабава	Barkalabava	Борколабово	3.0	5.0	7.0	713.0	1,0 км на З от д. Залохвенье, 3,6 км на ЮЗ от д. Борколабово	53.601033	30.2425060	N-36-85	7	7	существует	0000000000000A4A
4.0	2010-12-20 00:00:00	167016.0	Скребни	Скрэбні	Skrebnі		3.0	6.0	2.0	212.0	0,4 км на СЗ от д. Скребни	55.044701	30.1682297	N-36-25	4	4	существует	0000000000000A4B
5.0	2010-12-20 00:00:00	167020.0	Савченки	Саўчанкі	Saŭčankі		3.0	6.0	2.0	212.0	1,7 км на СЗ от д. Савченки	54.985508	30.1773940	N-36-37	2	2	существует	0000000000000A4C
6.0	2010-12-20 00:00:00	147741.0	331 км	331 км	331 km		3.0	5.0	7.0	708.0	1 км на СВ от д. Телуша	53.069073	29.4052989	N-35-107			существует	0000000000000A4D
7.0	2010-12-20 00:00:00	154529.0	Авраамовская	Аўраамаўская	Aŭraamaŭskaja		3.0	4.0	3.0	354.0	д. Партизанская	52.051506	29.9949195	N-35-144	5	5	существует	0000000000000A4E
39.0	2010-12-20 00:00:00	148655.0	Безверховичи	Бязверхавічы	Biazvierchavіčy		3.0	2.0	6.0	646.0	северо-восточная окраина д. Безверховичи	53.028759	27.4359092	N-35-103	5	5	существует	0000000000000A4F
47.0	2010-12-20 00:00:00	137909.0	Беняконе	Беняконі	Bieniakonі	Бенякони	1.0	2.0	4.0	413.0	д. Бенякони	54.245312	25.3531074	N-35-63	6	6	существует	0000000000000A50
36.0	2010-12-20 00:00:00	137805.0	Бастуны	Бастуны	Bastuny		1.0	2.0	4.0	413.0	д. Бастуны	54.078384	25.2937648	N-35-63	5	5	существует	0000000000000A51
32.0	2010-12-20 00:00:00	151408.0	Барбаров	Барбароў	Barbaroŭ		1.0	4.0	3.0	335.0	г. Мозырь	51.900986	29.2730469	M-35-11	7	7	существует	0000000000000A52
45.0	2010-12-20 00:00:00	158233.0	Бель	Бель	Bieĺ		3.0	5.0	7.0	740.0	1,1 км на СЗ от д. Павловичи	53.802761	31.6604029	N-36-76	2	2	существует	0000000000000A53
35.0	2010-12-20 00:00:00	141336.0	Барсуки	Барсукі	Barsukі		3.0	1.0	6.0	648.0	д. Яловка; 1,9 км на ЮВ от д. Барсуки	54.066418	28.2809577	N-35-69	7	7	существует	0000000000000A54
38.0	2010-12-20 00:00:00	131283.0	Батча	Батча	Batča		3.0	3.0	1.0	125.0	3,4 км на ЮВ от д. Большие Яковчицы	52.218102	24.1717275	N-35-133	2	2	существует	0000000000000A55
37.0	2010-12-20 00:00:00	160341.0	Батали	Баталі	Batalі		3.0	6.0	2.0	218.0	д. Ботали	55.389599	30.0828675	N-36-13	6	6	существует	0000000000000A56
43.0	2010-12-20 00:00:00	163316.0	Белосельский	Беласельскі	Bielasieĺskі		3.0	1.0	4.0	456.0	1,5 км на С от д. Сукневичи	54.456726	26.4568122	N-35-53	6	6	существует	0000000000000A57
40.0	2010-12-20 00:00:00	143609.0	Беларусь	Беларусь	Bielaruś		1.0	1.0	6.0	636.0	г. Заславль, центр	54.008846	27.2838381	N-35-67	6	6	существует	0000000000000A58
42.0	2010-12-20 00:00:00	133804.0	Белоозёрск	Белаазёрск	Bielaaziorsk		1.0	3.0	1.0	108.0	г. Белоозёрск	52.466724	25.1870840	N-35-123		7	существует	0000000000000A59
46.0	2010-12-20 00:00:00	161823.0	Бениславского	Беніслаўскага	Bienіslaŭskaha		3.0	6.0	2.0	210.0	2,7 км на В от аг. Волынцы	55.715766	28.2125830	N-35-9	7,	7	существует	0000000000000A5A
10.0	2010-12-20 00:00:00	156929.0	Александрия	Александрыя	Alieksandryja		3.0	5.0	7.0	758.0	д. Александрия	54.342587	30.2778312	N-36-49	10	10	существует	0000000000000A5B
41.0	2010-12-20 00:00:00	137542.0	Белогруда	Белагруда	Bielahruda		3.0	2.0	4.0	436.0	1,7 км на ЮВ от д. Белогруда; 2,2 км на ЮВ от д. Тараново	53.786968	25.1797500	N-35-75	7	7	существует	0000000000000A5C
49.0	2010-12-20 00:00:00	141618.0	Бережок	Беражок	Bieražok		3.0	1.0	6.0	630.0	д. Плавущее Галое	54.297047	28.9329557	N-35-70	6	6	существует	0000000000000A5D
44.0	2010-12-20 00:00:00	159005.0	Белынковичи	Бялынкавічы	Bialynkavіčy		1.0	5.0	7.0	735.0	п. Станция Белынковичи	53.233173	32.1614714	N-36-101	4	4	существует	0000000000000A5E
27.0	2010-12-20 00:00:00	162116.0	Баравуха	Баравуха	Baravucha	Боровуха	1.0	6.0	2.0	238.0	г.п. Боровуха	55.584549	28.5964359	N-35-22	6	6	существует	0000000000000A5F
9.0	2010-12-20 00:00:00	168663.0	Адровка	Адроўка	Adroŭka		3.0	1.0	2.0	236.0	0,9 км на СЗ от д. Селец	54.636189	30.0504583	N-36-49	4,	4	существует	0000000000000A60
48.0	2010-12-20 00:00:00	144527.0	Бережа	Бярэжа	Biareža		3.0	1.0	6.0	622.0	д. Бережа	53.716202	27.2709798	N-35-79	4	4	существует	0000000000000A61
54.0	2010-12-20 00:00:00	162633.0	Березинское	Беразінскае	Bierazіnskaje		3.0	1.0	6.0	638.0	аг. Березинское	54.217880	26.6146941	N-35-66	6	6	существует	0000000000000A62
3.0	2010-12-20 00:00:00	150299.0	15 км	15 км	15 km		3.0	4.0	3.0	310.0	2,2 км на ЮЗ от д. Климовка	52.274349	31.0814602	N-36-135			существует	0000000000000A63
26.0	2010-12-20 00:00:00	154425.0	Бабичи	Бабічы	Babіčy		1.0	4.0	3.0	345.0	д. Бабичи	52.291218	30.0007320	N-36-133	2	2	существует	0000000000000A64
58.0	2010-12-20 00:00:00	136200.0	Берестовица	Бераставіца	Bierastavіca		1.0	2.0	4.0	404.0	пгт Пограничный	53.116108	23.9678025	N-34-108	9	9	существует	0000000000000A65
53.0	2010-12-20 00:00:00	141410.0	Березина	Бярэзіна	Biarezіna		3.0	1.0	6.0	608.0	восточная окраина г. Борисов	54.241333	28.5525455	N-35-70	4	4	существует	0000000000000A66
52.0	2010-12-20 00:00:00	147703.0	Березина	Бярэзіна	Biarezіna		1.0	5.0	7.0	0.0	г. Бобруйск	53.130920	29.2491794	N-35-107	4	4	существует	0000000000000A67
55.0	2010-12-20 00:00:00	150212.0	Берёзки	Бярозкі	Biarozkі		4.0	4.0	3.0	310.0	д. Берёзки	52.391693	31.1006561	N-36-123		4	существует	0000000000000A68
25.0	2010-12-20 00:00:00	147718.0	Бабино	Бабіна	Babіna		3.0	5.0	7.0	708.0	3,4 км на ЮЗ от д. Бабино 1	53.117649	29.3208707	N-35-107	2	2	существует	0000000000000A69
11.0	2010-12-20 00:00:00	149111.0	Александровка	Аляксандраўка	Aliaksandraŭka		3.0	5.0	6.0	652.0	1,5 км на З от д. Александровка	53.080387	28.2917683	N-35-105	6	6	существует	0000000000000A6A
12.0	2010-12-20 00:00:00	133310.0	Алёнушка	Алёнушка	Alionuška		3.0	3.0	1.0	154.0	2,1 км на СВ от п. Городище	52.188049	26.2869973	N-35-137	3,	3	существует	0000000000000A6B
59.0	2010-12-20 00:00:00	146823.0	Бибковщина	Бібкаўшчына	Bіbkaŭščyna		3.0	5.0	7.0	708.0	д. Бибковщина	53.183182	29.0360487	N-35-107	2	2	существует	0000000000000A6C
8.0	2010-12-20 00:00:00	162012.0	Адамово	Адамова	Adamova		4.0	6.0	2.0	238.0	д. Адамово	55.621281	28.4692389	N-35-21	5	5	существует	0000000000000A6D
34.0	2010-12-20 00:00:00	156134.0	Барсуки	Барсукі	Barsukі		4.0	5.0	7.0	713.0	д. Барсуки; 1,7 км на СЗ от д. Дальнее Лядо	53.661373	30.2612089	N-36-85	7	7	существует	0000000000000A6E
57.0	2010-12-20 00:00:00	162313.0	Березовцы	Бярэзаўцы	Biarezaŭcy		3.0	2.0	4.0	429.0	0,5 км на С от д. Березовцы; 2 км на Ю от д. Козинцы	54.000050	25.7113480	N-35-64	4	4	существует	0000000000000A6F
76.0	2010-12-20 00:00:00	159043.0	Бони	Боні	Bonі		3.0	5.0	7.0	735.0	д. Бони	53.200684	32.2099626	N-36-101	2	2	существует	0000000000000A70
56.0	2010-12-20 00:00:00	130825.0	Берёзовая Роща	Бярозавы Гай	Biarozavy Haj	Берёзовый Гай	3.0	3.0	1.0	112.0	2,8 км на СЗ от аг. Мухавец	52.045475	23.7758869	N-34-144	4, 12	4, 11	существует	0000000000000A71
70.0	2010-12-20 00:00:00	162506.0	Богданов	Багданаў	Bahdanaŭ		1.0	1.0	6.0	620.0	п. Богданов	54.171196	26.1537819	N-35-65	5	5	существует	0000000000000A72
61.0	2010-12-20 00:00:00	135349.0	Бирюличи	Бірулічы	Bіrulіčy	Бируличи	3.0	2.0	4.0	420.0	2,2 км на СЗ от д. Бируличи	53.587948	24.1603248	N-35-85	4	4	существует	0000000000000A73
64.0	2010-12-20 00:00:00	145426.0	Блужа	Блужа	Bluža		3.0	1.0	6.0	644.0	рзд Блужа	53.436642	28.2292875	N-35-93	3	3	существует	0000000000000A74
93.0	2010-12-20 00:00:00	153314.0	Бринёво	Брынёва	Bryniova		4.0	4.0	3.0	316.0	0,4 км на З от д. Бринёво; 1,8 км на В от д. Полянка	52.252865	28.0003668	N-35-141		5	существует	0000000000000A75
95.0	2010-12-20 00:00:00	146452.0	Бродище	Брадзішча	Bradzіšča		3.0	5.0	7.0	748.0	1,5 км на СВ от д. Бродище	53.269688	28.7725512	N-35-106	5	6	существует	0000000000000A76
74.0	2010-12-20 00:00:00	135250.0	Бокуны	Бакуны	Bakuny	Бакуны	3.0	2.0	4.0	420.0	южная окраина д. Бакуны	53.564232	23.7227191	N-34-96	6	6	существует	0000000000000A77
66.0	2010-12-20 00:00:00	153526.0	Бобрич	Бобрыч	Bobryč		3.0	4.0	3.0	343.0	1,4 км на З от д. Оголичская Рудня	52.205708	28.4616041	N-35-141	2	2	существует	0000000000000A78
68.0	2010-12-20 00:00:00	131298.0	Бобры	Бабры	Babry		3.0	3.0	1.0	125.0	на С от д. Пантюхи; 1,5 км на З от д. Бобры	52.217468	24.0919512	N-35-133	5	5	существует	0000000000000A79
72.0	2010-12-20 00:00:00	135227.0	Богушевка	Багушоўка	Bahušoŭka	Богушовка	3.0	2.0	4.0	420.0	1 км на В от д. Богушовка	53.760147	23.9596650	N-34-84	6	6	существует	0000000000000A7A
79.0	2010-12-20 00:00:00	161908.0	Борковичи	Боркавічы	Borkavіčy		1.0	6.0	2.0	210.0	д. Борковичи	55.670242	28.3262051	N-35-9	2	2	существует	0000000000000A7B
73.0	2010-12-20 00:00:00	167001.0	Богушевская	Багушэўская	Bahušeŭskaja		1.0	6.0	2.0	244.0	г.п. Богушевск	54.842926	30.2071427	N-36-37	6	6	существует	0000000000000A7C
78.0	2010-12-20 00:00:00	134224.0	Борки	Боркі	Borkі		3.0	3.0	1.0	134.0	д. Борки	52.777897	25.4104756	N-35-111	2	2	существует	0000000000000A7D
83.0	2010-12-20 00:00:00	137129.0	Боровцы	Бараўцы	Baraŭcy		1.0	2.0	1.0	104.0	д. Боровцы	53.106899	25.9383948	N-35-100	7,	7	существует	0000000000000A7E
82.0	2010-12-20 00:00:00	165103.0	Боровое	Баравое	Baravoje		1.0	6.0	2.0	215.0	д. Боровое	55.214615	28.0791403	N-35-33	6	6	существует	0000000000000A7F
71.0	2010-12-20 00:00:00	151234.0	Богутичи	Багуцічы	Bahucіčy		3.0	4.0	3.0	314.0	1,5 км на В от д. Богутичи	51.756657	29.1246351	M-35-11	4	4	существует	0000000000000A80
77.0	2010-12-20 00:00:00	141406.0	Борисов	Барысаў	Barysaŭ		1.0	1.0	6.0	608.0	г. Борисов	54.220482	28.5309291	N-35-70	4	4	существует	0000000000000A81
99.0	2010-12-20 00:00:00	135104.0	Брузги	Брузгі	Bruzhі		1.0	2.0	4.0	420.0	0,8 км на З от д. Брузги	53.555534	23.6666414	N-34-96	6	6	существует	0000000000000A82
92.0	2010-12-20 00:00:00	130837.0	Брест-Южный	Брэст-Паўднёвы	Brest-Paŭdniovy	Брест-Павднёвый	1.0	3.0	1.0	0.0	г. Брест	52.064388	23.7501916	N-34-144	7,	3, 12	существует	0000000000000A83
91.0	2010-12-20 00:00:00	130007.0	Брест-Центральный	Брэст-Цэнтральны	Brest-Centraĺny		1.0	3.0	1.0	0.0	г. Брест	52.100010	23.6810380	N-34-144	12	12	существует	0000000000000A84
69.0	2010-12-20 00:00:00	137256.0	Бобры	Бабры	Babry		3.0	2.0	4.0	458.0	д. Рожанка; 1,2 км на С от д. Бобра	53.531898	24.7425513	N-35-86	5	5	существует	0000000000000A85
87.0	2010-12-20 00:00:00	142324.0	Бояры	Баяры	Bajary		3.0	1.0	6.0	638.0	д. Бояры	54.191490	27.0840837	N-35-67	3	3	существует	0000000000000A86
90.0	2010-12-20 00:00:00	130100.0	Брест-Северный	Брэст-Паўночны	Brest-Paŭnočny	Брест-Павночный	1.0	3.0	1.0	0.0	г. Брест	52.111336	23.6540199	N-34-144	8	11	существует	0000000000000A87
86.0	2010-12-20 00:00:00	139478.0	Бостынь	Бастынь	Bastyń		3.0	2.0	1.0	147.0	д. Бостынь	52.394032	26.7611324	N-35-126	5	5	существует	0000000000000A88
63.0	2010-12-20 00:00:00	168339.0	Блажевщина	Блажэўшчына	Blažeŭščyna		3.0	1.0	2.0	251.0	д. Блажевщина	54.739178	29.4430774	N-35-47	5	5	существует	0000000000000A89
94.0	2010-12-20 00:00:00	146429.0	Брицаловичи	Брыцалавічы	Brycalavіčy		3.0	5.0	7.0	748.0	2,7 км на ЮВ от д. Брицаловичи	53.353146	28.8434220	N-35-94	5	5	существует	0000000000000A8A
96.0	2010-12-20 00:00:00	147493.0	Брожа	Брожа	Broža		3.0	5.0	7.0	708.0	п. Брожа	52.951984	29.1131895	N-35-119	3,	3	существует	0000000000000A8B
75.0	2010-12-20 00:00:00	155856.0	Больница	Бальніца	Baĺnіca		3.0	4.0	3.0	318.0	г. Жлобин	52.904968	30.0030695	N-36-109	6	6	существует	0000000000000A8C
60.0	2010-12-20 00:00:00	161700.0	Бигосово	Бігосава	Bіhosava		1.0	6.0	2.0	210.0	д. Бигосово	55.834309	27.7375197	N-35-8	4	4	существует	0000000000000A8D
65.0	2010-12-20 00:00:00	141800.0	Бобр	Бобр	Bobr		1.0	1.0	6.0	630.0	п. Бобр	54.319641	29.2619001	N-35-71	2	2	существует	0000000000000A8E
97.0	2010-12-20 00:00:00	152129.0	Бронислав	Браніслаў	Branіslaŭ		3.0	2.0	3.0	316.0	2,8 км на С от д. Бронислав	52.227795	27.6036438	N-35-140	8	8	существует	0000000000000A8F
62.0	2010-12-20 00:00:00	157921.0	Благовичи	Благавічы	Blahavіčy		3.0	5.0	7.0	754.0	1,9 км на ЮВ от д. Атражье; 4,8 км на Ю от д. Благовичи	53.794754	30.8394313	N-36-74	3	3	существует	0000000000000A90
81.0	2010-12-20 00:00:00	157739.0	Боровка	Бароўка	Baroŭka		3.0	5.0	7.0	744.0	г. Могилёв, ЮВ окраина	53.866211	30.4474980	N-36-73	4	4	существует	0000000000000A91
98.0	2010-12-20 00:00:00	134008.0	Бронная Гора	Бронная Гара	Bronnaja Hara		1.0	3.0	1.0	108.0	д. Бронная Гора	52.606777	25.0927158	N-35-123	3,12	3, 12	существует	0000000000000A92
100.0	2010-12-20 00:00:00	155201.0	Буда-Кошелёвская	Буда-Кашалёўская	Buda-Kašalioŭskaja		1.0	4.0	3.0	305.0	г. Буда-Кошелёво	52.712601	30.5672257	N-36-110	2,11	2, 11	существует	0000000000000A93
67.0	2010-12-20 00:00:00	147008.0	Бобруйск	Бабруйск	Babrujsk		1.0	5.0	7.0	0.0	г. Бобруйск	53.137630	29.1951358	N-35-107	5	5	существует	0000000000000A94
18.0	2010-12-20 00:00:00	143524.0	Анусино	Анусіна	Anusіna		3.0	1.0	6.0	636.0	0,8 км на СВ от д. Анусино	54.049732	27.2241757	N-35-67	3	3	существует	0000000000000A95
80.0	2010-12-20 00:00:00	132534.0	Боровая	Баравая	Baravaja		3.0	3.0	1.0	112.0	6,6 км на ЮВ от д. Подлесье-Каменецкое	51.956486	23.8976590	M-34-12	6	6	существует	0000000000000A96
29.0	2010-12-20 00:00:00	138901.0	Барановичи-Полесские	Баранавічы-Палескія	Baranavіčy-Palieskіja		1.0	2.0	1.0	0.0	г. Барановичи	53.129192	26.0422843	N-35-101	4,13,	4,13,	существует	0000000000000A97
23.0	2010-12-20 00:00:00	144438.0	Асино	Асіна	Asіna		3.0	2.0	6.0	622.0	2,5 км на С от д. Старая Мезеновка	53.564075	27.0079293	N-35-91	1	1	существует	0000000000000A98
50.0	2010-12-20 00:00:00	134116.0	Берёза-Город	Бяроза-Горад	Biaroza-Horad		3.0	3.0	1.0	104.0	г. Берёза	52.547874	24.9735543	N-35-122	9,	4, 9,	существует	0000000000000A99
20.0	2010-12-20 00:00:00	163528.0	Асановский	Асанаўскі	Asanaŭskі		3.0	1.0	6.0	638.0	д. Асаново	54.331753	26.7302944	N-35-66	3	3,	существует	0000000000000A9A
1.0	2010-12-20 00:00:00	168767.0	11 км	11 км	11 km		3.0	1.0	2.0	236.0	д. Мошково	54.571442	30.2713724	N-36-49			существует	0000000000000A9B
22.0	2010-12-20 00:00:00	144828.0	Асеевка	Асееўка	Asiejeŭka	Осеевка	3.0	1.0	6.0	636.0	д. Осеевка	53.768673	27.6535533	N-35-80	3	3	существует	0000000000000A9C
85.0	2010-12-20 00:00:00	153776.0	Борречье	Барэчча	Barečča	Бобречье	3.0	4.0	3.0	343.0	2,8 км на ЮЗ от д. Бобречье	52.188290	28.7441525	N-35-142	5	4	существует	0000000000000A9D
84.0	2010-12-20 00:00:00	150636.0	Борок	Барок	Barok		3.0	4.0	3.0	312.0	2,2 км на СЗ от д. Иваки	52.273315	31.3210842	N-36-135	4	4	существует	0000000000000A9E
19.0	2010-12-20 00:00:00	156825.0	Аполлоновка	Апалонаўка	Apalonaŭka		3.0	5.0	7.0	758.0	южная окраина г. Шклов; 4,7 км на В от д. Аполлоновка	54.183563	30.2913603	N-36-61	6	5	существует	0000000000000A9F
24.0	2010-12-20 00:00:00	135301.0	Аульс	Аульс	Auĺs		1.0	2.0	4.0	0.0	восточная окраина г. Гродно	53.674274	23.9596152	N-34-84	2	2	существует	0000000000000AA0
2.0	2010-12-20 00:00:00	150778.0	151 км	151 км	151 km		2.0	4.0	3.0	312.0	1,2 км на В от д. Николаевка	52.150982	31.4392230	N-36-135			существует	0000000000000AA1
21.0	2010-12-20 00:00:00	144832.0	Асеевка	Асееўка	Asiejeŭka	Осеевка	2.0	1.0	6.0	636.0	южная окраина п. Гатово; 0,3 км на СВ от д. Осеевка	53.771770	27.6455000	N-35-80	3	3	существует	0000000000000AA2
\.


--
-- Data for Name: _dbo_kn_fgodrtnamebel; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_fgodrtnamebel ("ID_FGO", "DRTNAMEBEL", "SINFOBEL", "ID", "SSMA_TimeStamp") FROM stdin;
45.0	Стрыжаўскі	10	78.0	0000000000000AA3
116.0	Пакамерскія	12	79.0	0000000000000AA4
114.0	Люсінскі	10	80.0	0000000000000AA5
114.0	Масцішчанскі	12	81.0	0000000000000AA6
449.0	Палахва	12	82.0	0000000000000AA7
115.0	Лінова	10	83.0	0000000000000AA8
115.0	Лунёва	12	84.0	0000000000000AA9
115.0	Лунево	12	85.0	0000000000000AAA
99.0	Страла	12	86.0	0000000000000AAB
151.0	Папярэчны	12	87.0	0000000000000AAC
454.0	Кобрынка	10	88.0	0000000000000AAD
459.0	Мухавец	10	89.0	0000000000000AAE
486.0	Нiзеўскi	12	90.0	0000000000000AAF
142.0	Прысела	12	91.0	0000000000000AB0
431.0	Студзёнка	10	92.0	0000000000000AB1
431.0	Студзянка, кан.	12	93.0	0000000000000AB2
187.0	Дудрынка	10	94.0	0000000000000AB3
187.0	Выдранка	12	95.0	0000000000000AB4
138.0	Смерць	10	96.0	0000000000000AB5
139.0	Чарабасаўскі канал	10	97.0	0000000000000AB6
480.0	Дварышчанскае	12	98.0	0000000000000AB7
485.0	Асiпаўка	12	99.0	0000000000000AB8
12.0	Муцьвіца	12	100.0	0000000000000AB9
598.0	Крывое возера	10	172.0	0000000000000ABA
608.0	Нядзведна	10	173.0	0000000000000ABB
597.0	Плюскае возера	10	175.0	0000000000000ABC
594.0	Рыча	10	176.0	0000000000000ABD
594.0	Рычу		177.0	0000000000000ABE
600.0	Вусач	12	178.0	0000000000000ABF
502.0	Бяла	10	181.0	0000000000000AC0
506.0	Пукоўка	10	182.0	0000000000000AC1
504.0	Палічная	10	183.0	0000000000000AC2
503.0	Хвашчоўскі Роў	10	184.0	0000000000000AC3
541.0	Труднiца	12	196.0	0000000000000AC4
573.0	Агнеж	10	223.0	0000000000000AC5
352.0	Гляхоўка	10	338.0	0000000000000AC6
356.0	Дамашэвіцкае	12	339.0	0000000000000AC7
39.0	Выдрэйка	10	343.0	0000000000000AC8
39.0	Выдранка	12	344.0	0000000000000AC9
1.0	Нач	10	345.0	0000000000000ACA
605.0	Канстанцiнова	12	346.0	0000000000000ACB
158.0	Жыраўскi	12	348.0	0000000000000ACC
30.0	Выганаўскае	10	349.0	0000000000000ACD
391.0	Клімаўка	10	350.0	0000000000000ACE
25.0	Любішчанскі	10	351.0	0000000000000ACF
452.0	Літоўка	10	353.0	0000000000000AD0
421.0	Каралеўскі	10	354.0	0000000000000AD1
421.0	Мухавец	12	355.0	0000000000000AD2
456.0	Шамятоўка	10	356.0	0000000000000AD3
33.0	Качалле	12	358.0	0000000000000AD4
27.0	Свеціцкая	10	359.0	0000000000000AD5
489.0	Лукаўскае вадасховішча	10	362.0	0000000000000AD6
481.0	Олтуш	10	363.0	0000000000000AD7
453.0	Трасцяніцкі канал	10	364.0	0000000000000AD8
110.0	Ясельдскі	10	365.0	0000000000000AD9
420.0	Багон	12	366.0	0000000000000ADA
382.0	канава № 1		367.0	0000000000000ADB
57.0	Панасавіцкі	12	369.0	0000000000000ADC
339.0	Мышанка	12	370.0	0000000000000ADD
479.0	Капаёўка	10	391.0	0000000000000ADE
473.0	Медна	10	392.0	0000000000000ADF
496.0	Селяхі	10	393.0	0000000000000AE0
496.0	Селяхінскае	10	394.0	0000000000000AE1
470.0	Серадова Рэчка	12	395.0	0000000000000AE2
462.0	Паднеўка	10,12	396.0	0000000000000AE3
509.0	Плесо	54	397.0	0000000000000AE4
392.0	Бродак	10	546.0	0000000000000AE5
427.0	Дахлаўка	12	559.0	0000000000000AE6
499.0	Цяплуха	10	560.0	0000000000000AE7
394.0	Мiзгiраўка	12	561.0	0000000000000AE8
154.0	Няслуха	12	562.0	0000000000000AE9
103.0	Доўскі Роў	12	574.0	0000000000000AEA
103.0	Ашанскі канал	10	575.0	0000000000000AEB
588.0	Акменіца	10	586.0	0000000000000AEC
588.0	Акмяніца	12	587.0	0000000000000AED
124.0	Заазёрскі канал	10	703.0	0000000000000AEE
555.0	Чарпецкае		803.0	0000000000000AEF
555.0	Чарапецкае		804.0	0000000000000AF0
46.0	Ланьскі	57	815.0	0000000000000AF1
61.0	Капейка	12	847.0	0000000000000AF2
346.0	Кутаўшчына	12	848.0	0000000000000AF3
348.0	Ішкалдзянка	12	849.0	0000000000000AF4
152.0	Белаазерскi	12	884.0	0000000000000AF5
448.0	Барысаўка, р.	12	888.0	0000000000000AF6
182.0	Гарнаўскі Ров	12	890.0	0000000000000AF7
170.0	Завішчоўскае	10	901.0	0000000000000AF8
153.0	Плеса	12	905.0	0000000000000AF9
145.0	Навасёлкаўскі	10	906.0	0000000000000AFA
145.0	Повіцкі	12	907.0	0000000000000AFB
166.0	Самаранка	10,12	908.0	0000000000000AFC
510.0	Мальніца	12	979.0	0000000000000AFD
403.0	Міша	10	987.0	0000000000000AFE
443.0	Мухавец	12	989.0	0000000000000AFF
582.0	Негра	12	994.0	0000000000000B01
400.0	Басенка	10	996.0	0000000000000B02
400.0	Басінка	12	997.0	0000000000000B03
357.0	Мшачак	12	999.0	0000000000000B04
365.0	Паўлінава	12	1000.0	0000000000000B05
354.0	Сакалоўка	12	1001.0	0000000000000B06
302.0	Дзем'яне	12	1014.0	0000000000000B07
\.


--
-- Data for Name: _dbo_kn_fgodrtnamerus; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_fgodrtnamerus ("ID_FGO", "DRTNAMERUS", "SINFORUS", "ID", "SSMA_TimeStamp") FROM stdin;
1046.0	Равкетас	12	3.0	0000000000000B08
1176.0	Великое Язно		4.0	0000000000000B09
667.0	Орцы	12	5.0	0000000000000B0A
911.0	Великое Белое		6.0	0000000000000B0B
1611.0	Великий Беленок		7.0	0000000000000B0C
1205.0	Великий Киловец		8.0	0000000000000B0D
99.0	Стрела	12	12.0	0000000000000B0E
169.0	Сбросной	12	13.0	0000000000000B0F
431.0	Студянка, кан.	12	14.0	0000000000000B10
409.0	Липнянка	12	15.0	0000000000000B11
715.0	Карасева	12	41.0	0000000000000B12
617.0	Волос	12	52.0	0000000000000B13
964.0	Волконько	12	55.0	0000000000000B14
989.0	Туровка	10,12	56.0	0000000000000B15
1602.0	Медведки	12	59.0	0000000000000B16
905.0	Осмато	12	62.0	0000000000000B17
69.0	Давыдовичский	12	72.0	0000000000000B18
1457.0	Гарна	12	77.0	0000000000000B19
1138.0	Бережье	12	78.0	0000000000000B1A
1112.0	Миорское	12	79.0	0000000000000B1B
1629.0	Жадунь	12	81.0	0000000000000B1C
1630.0	Костино	12	82.0	0000000000000B1D
1445.0	Бирвета	12	85.0	0000000000000B1E
1546.0	Борок	12	86.0	0000000000000B1F
1493.0	Большие Сурвилишки	12	87.0	0000000000000B20
1559.0	Коловское	12	88.0	0000000000000B21
1453.0	Тузьба	12	89.0	0000000000000B22
1516.0	Чортка	12	90.0	0000000000000B23
1556.0	Бульбуново	12	91.0	0000000000000B24
1634.0	Беленок	12	96.0	0000000000000B25
910.0	Свина	1	99.0	0000000000000B26
356.0	Домашевичское	12	102.0	0000000000000B27
482.0	Рита		117.0	0000000000000B28
109.0	Горьчаковка	12	121.0	0000000000000B29
1184.0	Луничино	12	133.0	0000000000000B2A
462.0	Падневка	12	139.0	0000000000000B2B
499.0	Переволока	12	202.0	0000000000000B2C
64.0	Жигулянка	12	203.0	0000000000000B2D
64.0	Жегулянский канал	4 (2005г.)	204.0	0000000000000B2E
1508.0	Голбеица	12	206.0	0000000000000B2F
233.0	канава Петрашевская	4	208.0	0000000000000B30
103.0	Довский Рыв	4(1991),12	210.0	0000000000000B31
1459.0	Чарна	12	211.0	0000000000000B32
1119.0	Великое		252.0	0000000000000B33
1498.0	Свита	12	254.0	0000000000000B34
862.0	Хатнежик		257.0	0000000000000B35
749.0	Мошница	12	277.0	0000000000000B36
690.0	Лешня	12	278.0	0000000000000B37
637.0	Оплиса	12	288.0	0000000000000B38
633.0	Потех	12	289.0	0000000000000B39
1034.0	Сцервинка	12	290.0	0000000000000B3A
61.0	Копейка	12	294.0	0000000000000B3B
346.0	Кутовщина	12	295.0	0000000000000B3C
348.0	Ишколдянка	12	296.0	0000000000000B3D
299.0	Безымянное	12	336.0	0000000000000B3E
152.0	Белоозерский	12	337.0	0000000000000B3F
1042.0	Альбеновское	12	339.0	0000000000000B40
1100.0	Бержонка	12	341.0	0000000000000B41
448.0	Борисовка, р.	12	343.0	0000000000000B42
615.0	Войтка	12	346.0	0000000000000B43
812.0	Волосатик	12	347.0	0000000000000B44
223.0	Гленбовка	12	348.0	0000000000000B45
182.0	Горновской Ров	12	350.0	0000000000000B46
636.0	Глубощина	12	353.0	0000000000000B47
1518.0	Грунвальды	12	356.0	0000000000000B48
1029.0	Думбле	12	358.0	0000000000000B49
1524.0	Гутское	12	360.0	0000000000000B4A
1091.0	Золово	12	363.0	0000000000000B4B
1035.0	Илгайцы	12	364.0	0000000000000B4C
634.0	Ильмёнок	12	365.0	0000000000000B4D
170.0	Завищанское	12	375.0	0000000000000B4E
292.0	Кобыльская	12	383.0	0000000000000B4F
300.0	Карасино	12	386.0	0000000000000B50
1497.0	Большое Камайское	12	388.0	0000000000000B51
145.0	Повитский	12	401.0	0000000000000B52
166.0	Саморанка	12	408.0	0000000000000B53
203.0	Сытино	12	412.0	0000000000000B54
1487.0	Ксендзовское	12	426.0	0000000000000B55
1550.0	Лучайское	12	433.0	0000000000000B56
735.0	Машница	12	439.0	0000000000000B57
1060.0	Новято	12	442.0	0000000000000B58
1589.0	Огурневка	12	443.0	0000000000000B59
523.0	Просторица	12	448.0	0000000000000B5A
1597.0	Станулевское	12	454.0	0000000000000B5B
1510.0	Тименцы	12	459.0	0000000000000B5C
1405.0	Талынь	12	460.0	0000000000000B5D
629.0	Казаринское	12	461.0	0000000000000B5E
1603.0	Чечелевское	12	464.0	0000000000000B5F
1142.0	Ямненский	12	468.0	0000000000000B60
1539.0	Ясюки	12	469.0	0000000000000B61
1503.0	Оржавка	12	521.0	0000000000000B62
443.0	Муховец	12	527.0	0000000000000B63
1043.0	Дрысвятка	4 (2004г.)	529.0	0000000000000B64
1059.0	Несьпиш	4	534.0	0000000000000B65
582.0	Негра	12	536.0	0000000000000B66
400.0	Басинка	12	537.0	0000000000000B67
357.0	Мшечек	12	539.0	0000000000000B68
365.0	Павлиново	12	540.0	0000000000000B69
354.0	Соколовка	12	541.0	0000000000000B6A
1269.0	Толокнянка	4	544.0	0000000000000B6B
\.


--
-- Data for Name: _dbo_kn_hchangeair; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_hchangeair ("ID_AIR", "REDATE", "CHANGES", "NAMEDOC", "DATEDOC", "INAMEBEL", "INAMERUS", "HYPERLINK", "ID", "SSMA_TimeStamp") FROM stdin;
5.0	2017-05-19 00:00:00	Закрыт с 23.12.2015	Указ Президента РБ № 456	2015-09-22 00:00:00				2.0	0000000000000B6C
8.0	2017-09-07 00:00:00	Аэродром Орша открыт для выполнения международных полетов	Постановление Совмина № 651	2017-08-25 00:00:00				4.0	0000000000000B6D
\.


--
-- Data for Name: _dbo_kn_hchangeate; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_hchangeate ("KOD_ATE", "REDATE", "CHANGES", "NAMEDOC", "DATEDOC", "INAMEBEL", "INAMERUS", "HYPERLINK", "ID", "SSMA_TimeStamp") FROM stdin;
30.0	2006-06-12 00:00:00	Уточнено наименование на рус. и бел. языках	Реш. райсовета № 100	2006-03-28 00:00:00				3136.0	0000000000000B6E
43.0	2006-06-12 00:00:00	Уточнено наименование на рус. и бел. языках	Реш. райсовета  № 100	2006-03-28 00:00:00	Нагорная	Нагорная		3139.0	0000000000000B6F
25.0	2008-04-09 00:00:00	Уточнение границ	Реш. облсовета  № 35	2007-05-18 00:00:00				3142.0	0000000000000B70
51.0	2008-04-21 00:00:00	Уточнение границ	Реш. облсовета № 35	2007-05-18 00:00:00				3145.0	0000000000000B71
51.0	2010-09-23 00:00:00	изменение категории в административном центре (на агрогородок)	Решение районного Совета депутатов (Барановичского районного Совета депутатов) от 14.03.2008г. № 47					3146.0	0000000000000B72
67.0	2008-04-09 00:00:00	Уточнение границ	Реш. облсовета № 35	2007-05-18 00:00:00				3147.0	0000000000000B73
112.0	2008-04-09 00:00:00	Уточнение границ	Реш. облсовета № 35	2007-05-18 00:00:00				3149.0	0000000000000B74
126.0	2008-04-09 00:00:00	Уточнение границ	Реш. облсовета № 35	2007-05-18 00:00:00				3151.0	0000000000000B75
135.0	2008-04-09 00:00:00	Уточнение границ	Реш. облсовета № 35	2007-05-18 00:00:00				3153.0	0000000000000B76
5.0	2010-05-15 00:00:00	Изменена категория д. на аг.	Реш. райсовета № 101	2009-03-13 00:00:00				3134.0	0000000000000B77
35.0	2010-09-23 00:00:00	Изменена категория центра с/с (д. на аг.)	Реш. райсовета № 47	2008-03-14 00:00:00				3144.0	0000000000000B78
35.0	2008-04-09 00:00:00	Уточнение границ	Реш. облсовета  № 35	2007-05-18 00:00:00				3143.0	0000000000000B79
135.0	2010-09-23 00:00:00	Изменена категория центра с/с (д. на аг.)	Реш. райсовета № 101	2009-03-13 00:00:00				3154.0	0000000000000B7A
67.0	2010-09-23 00:00:00	Изменена категория центра с/с (д. на аг.)	Реш. райсовета № 47	2008-03-14 00:00:00				3148.0	0000000000000B7B
112.0	2010-09-23 00:00:00	Изменена категория центра с/с (д. на аг.)	Реш. райсовета № 47	2008-02-14 00:00:00				3150.0	0000000000000B7C
126.0	2010-09-23 00:00:00	Изменена категория центра с/с (д. на аг.)	Реш. райсовета № 165	2010-03-26 00:00:00				3152.0	0000000000000B7D
85.0	2012-06-25 00:00:00	Изменение категории в административном центре (на агрогородок)	Реш. райсовета № 47	2008-03-14 00:00:00				8139.0	0000000000000B7E
143.0	2012-06-25 00:00:00	Изменена категория п. на аг.	Реш. райсовета № 101	2009-03-13 00:00:00				8142.0	0000000000000B7F
53.0	2012-06-25 00:00:00	Изменена категория д. на аг.	Реш. райсовета № 47	2008-03-14 00:00:00				8136.0	0000000000000B80
75.0	2012-06-25 00:00:00	Изменена категория п. на аг.	Реш. райсовета № 47	2008-03-14 00:00:00				8137.0	0000000000000B81
90.0	2012-06-25 00:00:00	Изменена категория д. на аг.	Реш. райсовета № 47	2008-03-14 00:00:00				8138.0	0000000000000B82
116.0	2012-06-25 00:00:00	Изменена категория д. на аг.	Реш. райсовета № 47	2008-03-14 00:00:00				8140.0	0000000000000B83
131.0	2012-06-25 00:00:00	Изменена категория д. на аг.	Реш. райсовета № 165	2010-03-26 00:00:00				8141.0	0000000000000B84
102.0	2013-01-03 00:00:00	Упразднена	Реш. райсовета № 124	2012-08-29 00:00:00				8664.0	0000000000000B85
147.0	2013-01-03 00:00:00	Упразднена	Реш. райсовета № 124	2012-08-29 00:00:00				8665.0	0000000000000B86
4.0	2008-04-09 00:00:00	Уточнение границ	Реш. облсовета № 35	2007-05-18 00:00:00				3140.0	0000000000000B87
51.0	2013-10-02 00:00:00	Упразднён (нас. пункты переданы в Городищенский с/с)	Реш. облсовета № 286	2013-06-26 00:00:00				10455.0	0000000000000B88
85.0	2013-10-02 00:00:00	Упразднён (нас. пункты переданы в Городищенский с/с)	Реш. облсовета № 286	2013-06-26 00:00:00				10456.0	0000000000000B89
100.0	2013-10-02 00:00:00	Упразднён (нас. пункты переданы в Столовичский и Крошинский с/с)	Реш. облсовета № 286	2013-06-26 00:00:00				10457.0	0000000000000B8A
149.0	2013-10-02 00:00:00	Упразднён (нас. пункты переданы в Столовичский с/с)	Реш. облсовета № 286	2013-06-26 00:00:00				10459.0	0000000000000B8B
4.0	2013-10-02 00:00:00	Изменена категория п/с на с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10462.0	0000000000000B8C
66.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10465.0	0000000000000B8D
65.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10466.0	0000000000000B8E
64.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10464.0	0000000000000B8F
63.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10467.0	0000000000000B90
62.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10468.0	0000000000000B91
61.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10469.0	0000000000000B92
60.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10470.0	0000000000000B93
59.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10471.0	0000000000000B94
58.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10472.0	0000000000000B95
57.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10473.0	0000000000000B96
56.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10474.0	0000000000000B97
55.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10475.0	0000000000000B98
54.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10476.0	0000000000000B99
53.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10477.0	0000000000000B9A
52.0	2013-10-02 00:00:00	Передан из Гирмантовского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10478.0	0000000000000B9B
99.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10479.0	0000000000000B9C
98.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10480.0	0000000000000B9D
97.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10481.0	0000000000000B9E
96.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10482.0	0000000000000B9F
95.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10483.0	0000000000000BA0
94.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10484.0	0000000000000BA1
93.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10485.0	0000000000000BA2
92.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10486.0	0000000000000BA3
91.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10487.0	0000000000000BA4
90.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10488.0	0000000000000BA5
89.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10489.0	0000000000000BA6
88.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10490.0	0000000000000BA7
87.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10491.0	0000000000000BA8
86.0	2013-10-02 00:00:00	Передан из Карчёвского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10492.0	0000000000000BA9
111.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10501.0	0000000000000BAA
108.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10502.0	0000000000000BAB
107.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10503.0	0000000000000BAC
106.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10504.0	0000000000000BAD
105.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10505.0	0000000000000BAE
101.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10506.0	0000000000000BAF
110.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10507.0	0000000000000BB0
109.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10508.0	0000000000000BB1
104.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10509.0	0000000000000BB2
103.0	2013-10-02 00:00:00	Передан из Колпеницкого с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10510.0	0000000000000BB3
20.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10533.0	0000000000000BB4
5.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10534.0	0000000000000BB5
7.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10536.0	0000000000000BB6
8.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10537.0	0000000000000BB7
9.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10538.0	0000000000000BB8
10.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10539.0	0000000000000BB9
11.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10540.0	0000000000000BBA
12.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10541.0	0000000000000BBB
14.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10542.0	0000000000000BBC
15.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10543.0	0000000000000BBD
13.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10544.0	0000000000000BBE
17.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10545.0	0000000000000BBF
16.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10546.0	0000000000000BC0
19.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10547.0	0000000000000BC1
18.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10548.0	0000000000000BC2
21.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10549.0	0000000000000BC3
22.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10550.0	0000000000000BC4
23.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10551.0	0000000000000BC5
24.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10552.0	0000000000000BC6
3.0	2013-10-03 00:00:00	Включён в состав  Городищенского с/с	Реш. облсовета № 286	2013-06-26 00:00:00				10553.0	0000000000000BC7
33.0	2010-05-15 00:00:00	Изменена категория д. на аг.	Реш. райсовета № 47	2008-03-14 00:00:00				3137.0	0000000000000BC8
38.0	2010-05-15 00:00:00	Изменена категория д. на аг.	Реш. райсовета № 47	2008-03-14 00:00:00				3138.0	0000000000000BC9
12.0	2016-04-07 00:00:00	Уточнено наименование (прежнее Зеленая)	Письмо райисполкома № 26-15	2016-02-26 00:00:00		Зеленая		14349.0	0000000000000BCA
90.0	2016-04-07 00:00:00	Уточнено наименование (прежнее Карчево)	Письмо райисполкома № 26-15	2016-02-26 00:00:00		Карчево		14350.0	0000000000000BCB
19.0	2016-04-07 00:00:00	Уточнено наименование (прежнее Новоселки)	Письмо райисполкома № 26-15	2016-02-26 00:00:00		Новоселки		14351.0	0000000000000BCC
127.0	2016-04-07 00:00:00	Уточнено наименование (прежнее Березовка)	Письмо райисполкома № 26-15	2016-02-26 00:00:00		Березовка		14355.0	0000000000000BCD
25.0	2019-09-09 00:00:00	Перенесён центр с/с из д. Великие Луки в аг. Русино	Реш. райсовета № 79	2019-08-02 00:00:00				15487.0	0000000000000BCE
26.0	2019-09-09 00:00:00	Перенесён центр с/с в аг. Русино	Реш. райсовета № 79	2019-08-02 00:00:00				15488.0	0000000000000BCF
33.0	2019-09-09 00:00:00	Перенесён центр с/с из д. Великие Луки	Реш. райсовета № 79	2019-08-02 00:00:00				15489.0	0000000000000BD0
6.0	2013-10-03 00:00:00	Передан из Городищенского п/с	Реш. облсовета № 286	2013-06-26 00:00:00				10535.0	0000000000000BD1
\.


--
-- Data for Name: _dbo_kn_hchangefgo; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_hchangefgo ("ID_FGO", "REDATE", "CHANGES", "NAMEDOC", "DATEDOC", "INAMEBEL", "INAMERUS", "HYPERLINK", "ID", "SSMA_TimeStamp") FROM stdin;
4601.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Воронина		1.0	0000000000000BD2
788.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Волоба		2.0	0000000000000BD3
769.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Глубо		3.0	0000000000000BD4
617.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Волос		4.0	0000000000000BD5
1025.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Дрисвята		5.0	0000000000000BD6
1095.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Густата		6.0	0000000000000BD7
1915.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Саро		7.0	0000000000000BD8
664.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Дрисса		8.0	0000000000000BD9
1005.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Вымна		10.0	0000000000000BDA
960.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Лужесянка		11.0	0000000000000BDB
1427.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Лучеса		12.0	0000000000000BDC
2264.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Задрач		13.0	0000000000000BDD
961.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Лосвида		14.0	0000000000000BDE
1755.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Урада		16.0	0000000000000BDF
8958.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Удранка		17.0	0000000000000BE0
1120.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Ельня		18.0	0000000000000BE1
1112.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Миорское		19.0	0000000000000BE2
2156.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Большое Ореховское		20.0	0000000000000BE3
1285.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Болныря		21.0	0000000000000BE4
902.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Большое Островито		22.0	0000000000000BE5
1228.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Ушачь		23.0	0000000000000BE6
2246.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Большая Швакшта		24.0	0000000000000BE7
2245.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Малая Швакшта		26.0	0000000000000BE8
1738.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Плина		27.0	0000000000000BE9
1828.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Полуозерье		28.0	0000000000000BEA
2319.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Коселянка		31.0	0000000000000BEB
495.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Буг		32.0	0000000000000BEC
496.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Селяхинское		33.0	0000000000000BED
2969.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Прудок		35.0	0000000000000BEE
3122.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Славечна		36.0	0000000000000BEF
3121.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Бативля		38.0	0000000000000BF0
184.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Стырь		39.0	0000000000000BF1
2511.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Ведречь		40.0	0000000000000BF2
2174.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Вяликая		41.0	0000000000000BF3
3740.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00	Баторын	Баторин		42.0	0000000000000BF4
4252.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Заславльское		43.0	0000000000000BF5
4410.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Гольша		44.0	0000000000000BF6
4365.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Ослик		45.0	0000000000000BF7
4696.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Мужичек		46.0	0000000000000BF8
4848.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Пересопня		47.0	0000000000000BF9
4651.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Ельна		49.0	0000000000000BFA
4539.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Волчас		50.0	0000000000000BFB
4564.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Молотовка		51.0	0000000000000BFC
1729.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Березовое		52.0	0000000000000BFD
778.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Дриссы		53.0	0000000000000BFE
549.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Тутчо		54.0	0000000000000BFF
4708.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Альшовка		55.0	0000000000000C01
3990.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Осочанка		58.0	0000000000000C02
4751.0		Уточнено название	Пост. СМ БССР № 31	1984-01-27 00:00:00		Балоновка		59.0	0000000000000C03
9217.0	28/10/2005 00:00:00	Подписано название	N-35-53-А г-2					60.0	0000000000000C04
30.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Выгоновское		29.0	0000000000000C05
9536.0	04/11/2015 00:00:00	Присвоено наименование водоёму	Постановление Совмина РБ № 915	2015-11-02 00:00:00				61.0	0000000000000C06
2668.0		Уточнено наименование	Пост. СМ БССР № 31	1984-01-27 00:00:00		Песоченка		34.0	0000000000000C07
1971.0		Уточнено наименование	Пост. СМ № 31	1984-01-27 00:00:00		Эсса		15.0	0000000000000C08
1493.0		Уточнено наименование (прежнее Большие Сурвилишки)	Пост. СМ БССР № 31	1984-01-27 00:00:00		Большие Сурвилишки		25.0	0000000000000C09
2026.0		Уточнено название	Пост. СМ № 31	1984-01-27 00:00:00		Лукомльское		57.0	0000000000000C0A
3957.0	06/05/2016 00:00:00	После проведения мелиорации стала притоком р. Уса. Ранее р. Нёманец считалась истоком р. Нёман и в верхнем течении названием реки Нёман	Письмо ГУ "Гидромет" № 17.2.1.-6/12	2016-04-04 00:00:00				62.0	0000000000000C0B
3400.0	06/05/2016 00:00:00	Изменён исток реки (исток - 2,5 км на СЗ от д. Речица, около насосной станции). Длина реки уменьшилась на 24 км	Письмо ГУ "Гидромет" № 17.2.1-6/12	2016-04-04 00:00:00				63.0	0000000000000C0C
9534.0	09/09/2018 00:00:00	Наименование на бел. яз. согласовано с Институтом языкознания (06.09.2018)		2011-07-08 00:00:00			Такое написание будет дано на картах с Польшей	64.0	0000000000000C0D
\.


--
-- Data for Name: _dbo_kn_hchangerw; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_hchangerw ("ID_RW", "REDATE", "CHANGES", "NAMEDOC", "DATEDOC", "INAMEBEL", "INAMERUS", "HYPERLINK", "ID", "SSMA_TimeStamp") FROM stdin;
657.0	2014-07-07 00:00:00	Переименован (бывшее наименование Победа)	Реш. Крошинского сельисполкома № 157	2014-06-24 00:00:00	Пабеда	Победа		3.0	0000000000000C0E
963.0	2019-08-09 00:00:00	Образован остановочный пункт	Реш. райисполкома № 1237	2019-08-06 00:00:00				44.0	0000000000000C0F
657.0	2014-09-17 00:00:00	Переименован (бывшее наименование Победа)	Приказ Белорусской ж/д № 789НЗ	2014-07-25 00:00:00				4.0	0000000000000C10
182.0	2015-09-15 00:00:00	Переименован (прежнее Гомель)	Приказ Белорусской ж/д № 215 НЗ	2007-03-26 00:00:00	Гомель	Гомель		6.0	0000000000000C11
542.0		Переименован (прежнее Бернады)	Приказ Белорусской железной дороги № 467НЗ	2006-07-17 00:00:00		Бернады		7.0	0000000000000C12
96.0	2017-04-26 00:00:00	Изменена категория ст. на оп.	Приказ БелЖД № 81Н	2014-02-20 00:00:00				8.0	0000000000000C13
672.0	2017-04-26 00:00:00	Изменена категория ст. на рзд.	Приказ БелЖД № 411Н	2015-12-31 00:00:00				9.0	0000000000000C14
135.0	2017-04-26 00:00:00	Изменена категория ст. на оп.	Приказ БелЖД № 409Н	2015-12-31 00:00:00				10.0	0000000000000C15
545.0	2017-04-26 00:00:00	Изменена категория оп. на ст.	Приказ БелЖД № 397Н	2012-11-12 00:00:00				11.0	0000000000000C16
957.0	2017-04-26 00:00:00	Переименована (прежнее Дегтярёвка-Техническая)	Приказ БелЖД № 333НЗ	2014-03-28 00:00:00		Дегтярёвка-Техническая	53,51,42// 27,23,28	12.0	0000000000000C17
713.0	2012-09-05 00:00:00	Упразднен	Приказ БелЖД	2011-11-05 00:00:00	Радыятарны	Радиаторный		1.0	0000000000000C18
113.0	2017-04-27 00:00:00	Закрыт	Приказ БелЖД № 971	2011-09-15 00:00:00				15.0	0000000000000C19
227.0	2017-04-27 00:00:00	Закрыт	Приказ БелЖД № 971НЗ	2011-09-15 00:00:00				16.0	0000000000000C1A
617.0	2017-04-27 00:00:00	Закрыт	Приказ БелЖД № 971НЗ	2011-09-15 00:00:00				17.0	0000000000000C1B
670.0	2017-04-27 00:00:00	Закрыт	Приказ БелЖД № 209НЗ	2013-02-27 00:00:00				18.0	0000000000000C1C
961.0	2017-06-08 00:00:00	Открыт остановочный пункт	Приказ БелЖД № 75НЗ	2011-01-25 00:00:00			55,21,16// 30,05,28	20.0	0000000000000C1D
93.0	2017-10-02 00:00:00	Изменена категория ст на рзд	Приказ БелЖД № 270Н	2017-09-26 00:00:00				26.0	0000000000000C1E
406.0	2017-10-02 00:00:00	Изменена категория ст на рзд	Приказ БелЖД № 270Н	2017-09-26 00:00:00				27.0	0000000000000C1F
962.0	2017-04-27 00:00:00	Переименован с августа 2011 года (прежнее Слободка)	Приказ БелЖД № 140НЗ	2011-02-10 00:00:00		Слободка	54,15,42// 30,15,16	23.0	0000000000000C20
850.0	2017-05-02 00:00:00	Закрыт с ноября 2015 г.	Уточнено в БелЖД. Реквизитов приказа нет					25.0	0000000000000C21
293.0	2017-05-02 00:00:00	Закрыт с августа 2014 г.	Уточнено в БелЖД. Реквизитов приказа нет					24.0	0000000000000C22
960.0	2017-06-08 00:00:00	Открыт остановочный пункт	Приказ БелЖД № 971НЗ	2011-09-15 00:00:00			53,54,13// 30,16,07	19.0	0000000000000C23
958.0	2017-06-08 00:00:00	Образована станция	Приказ БелЖД № 232НЗ	2012-03-06 00:00:00				13.0	0000000000000C24
959.0	2017-06-08 00:00:00	Образована станция	Приказ БелЖД № 436Н	2012-12-10 00:00:00				14.0	0000000000000C25
379.0	2017-10-02 00:00:00	Изменена категория ст на рзд	Приказ БелЖД № 270Н	2017-09-26 00:00:00				28.0	0000000000000C26
794.0	2017-06-08 00:00:00	Остановочный пункт в августе 2011 года смещен к д. Слабодка	Приказ БелЖД № 140НЗ	2011-02-10 00:00:00			54,16,16// 30,15,17	21.0	0000000000000C27
489.0	2017-10-02 00:00:00	Изменена категория ст на рзд	Приказ БелЖД № 270Н	2017-09-26 00:00:00				29.0	0000000000000C28
55.0	2017-10-02 00:00:00	Изменена категория ст на рзд	Приказ БелЖД № 270Н	2017-09-26 00:00:00				30.0	0000000000000C29
405.0	2017-10-02 00:00:00	Изменена категория ст на обг. пункт	Приказ БелЖД № 270Н	2017-09-26 00:00:00				31.0	0000000000000C2A
282.0	2017-10-02 00:00:00	Изменена категория ст на обг. пункт	Приказ БелЖД № 270Н	2017-09-26 00:00:00				32.0	0000000000000C2B
286.0	2018-01-08 00:00:00	Упразднён	Приказ Белжд № 449НЗ	2017-04-21 00:00:00				33.0	0000000000000C2C
623.0	2018-01-08 00:00:00	Существует для грузовых перевозок, посадка и высадка пассажиров не производится	Приказ Белжд № 449НЗ	2017-04-21 00:00:00				34.0	0000000000000C2D
345.0		Сдана в аренду						35.0	0000000000000C2E
283.0		В билетных кассах идёт Жлобин-Пассажирский						36.0	0000000000000C2F
182.0		В билетных кассах идёт Гомель-Пассажирский						37.0	0000000000000C30
105.0	2018-02-08 00:00:00	Изменена категория ст. на оп.	Приказ БелЖД № 408Н	2009-10-14 00:00:00				38.0	0000000000000C31
822.0	2018-04-02 00:00:00	Изменена категория ст. на разъезд	Приказ Белжд № 98Н	2018-03-26 00:00:00				39.0	0000000000000C32
778.0	2018-10-01 00:00:00	Изменена категория ст. на рзд.	Приказ Белжд № 151Н	2018-05-21 00:00:00				40.0	0000000000000C33
924.0	2019-01-03 00:00:00	Переименован (прежнее Шинная)	Приказ БелЖД № 1267П	2018-10-17 00:00:00	Шынная	Шинная	грузовая станция; посадка-высадка пассажиров никогда не производилась	41.0	0000000000000C34
143.0	2019-02-05 00:00:00	Переименование (прежнее Волковыск-Центральный)	Приказ БелЖД № 1045 НЗ	2018-12-11 00:00:00	Ваўкавыск-Цэнтральны	Волковыск-Центральный		43.0	0000000000000C35
430.0	2014-09-17 00:00:00	Переименован ( прежнее наименование Крошино)	Приказ Белорусской ж/д № 789НЗ	2014-07-25 00:00:00		Крошино		5.0	0000000000000C36
430.0	2014-07-07 00:00:00	Переименован (прежнее наименование Крошино)	Реш. Крошинского сельисполкома № 157	2014-06-24 00:00:00	Крошын	Крошино		2.0	0000000000000C37
964.0	2019-08-27 00:00:00	Образован новый объект с 3.09.2019	Приказ Белжд № 682 П	2019-08-16 00:00:00				45.0	0000000000000C38
297.0	2019-01-10 00:00:00	Изменена категория ст. на оп.	Тарифное руководство № 4; сайт railwayz.info; Бел. ж/д (звонок)					42.0	0000000000000C39
4.0	2019-11-11 00:00:00	Переименован (прежнее наименование 19 км); изменена категория путевой пост на о.п.	Приказ Белжд № 753НЗ	2015-08-10 00:00:00	19 км	19 км		46.0	0000000000000C3A
5.0	2019-11-11 00:00:00	Переименован (прежнее наименование 25 км); изменена категория путевой пост на о.п.	Приказ Белжд № 753НЗ	2015-08-10 00:00:00	25 км	25 км		47.0	0000000000000C3B
921.0		Действует для грузовых перевозок						48.0	0000000000000C3C
357.0	2019-12-03 00:00:00	Закрыт с 01.12.2019	Приказ Белжд № 1091НЗ	2019-11-21 00:00:00				51.0	0000000000000C3D
258.0	2019-12-03 00:00:00	Закрыт с 01.12.2019	Приказ Белжд № 1091НЗ	2019-11-21 00:00:00				50.0	0000000000000C3E
244.0	2020-03-13 00:00:00	Изменена категория (ст. на раъезд)	Приказ Белжд № 68Н	2020-02-27 00:00:00			Изменена категория с 01.05.2020 г.	52.0	0000000000000C3F
454.0	2025-01-24 00:00:00	Изменена категория станция на разъезд с 20.01.2025	Приказ Белжд № 262Н	2024-11-18 00:00:00				82.0	0000000000000C40
429.0	2020-07-30 00:00:00	Закрыт c 30.10.2020	Приказ БелЖД № 215Н	2020-06-23 00:00:00				53.0	0000000000000C41
296.0	2021-01-05 00:00:00	Изменена категория (ст. на разъезд)	Приказ Белжд № 978НЗ	2020-12-22 00:00:00				54.0	0000000000000C42
384.0	2021-01-05 00:00:00	Изменена категория (ст. на разъезд)	Приказ Белжд № 978НЗ	2020-12-22 00:00:00				55.0	0000000000000C43
946.0	2021-01-05 00:00:00	Изменена категория (ст. на разъезд)	Приказ Белжд № 978НЗ	2020-12-22 00:00:00				56.0	0000000000000C44
8.0	2021-01-05 00:00:00	Изменена категория (ст. на разъезд)	Приказ Белжд № 978НЗ	2020-12-22 00:00:00				57.0	0000000000000C45
769.0	2021-01-05 00:00:00	Изменена категория (ст. на разъезд)	Приказ Белжд № 978НЗ	2020-12-22 00:00:00				58.0	0000000000000C46
563.0	2022-02-09 00:00:00	Упразднён	Приказ БелЖД (без номера)	2018-06-01 00:00:00				59.0	0000000000000C47
870.0	2022-02-09 00:00:00	Изменена категория (станция на разъезд)	Приказ БелЖД № 13Н	2022-01-06 00:00:00				60.0	0000000000000C48
766.0	2022-02-09 00:00:00	Изменена категория разъезд на остановочный пункт	Приказ БелЖД № 173Н	2021-05-21 00:00:00				61.0	0000000000000C49
332.0	2022-09-08 00:00:00	Упразднён с 10.05.2010	Приказ БелЖД № 419НЗ	2019-05-04 00:00:00			Самого приказа нет	62.0	0000000000000C4A
799.0	2022-09-21 00:00:00	Упразднён с 01.08.2016	Приказ БелЖД № 682НЗ	2016-07-26 00:00:00				63.0	0000000000000C4B
780.0	2022-12-22 00:00:00	Изменена категория (ст. на разъезд)	Приказ Белжд № 170Н	2022-06-29 00:00:00				64.0	0000000000000C4C
325.0		Переведён в разряд грузового						65.0	0000000000000C4D
779.0		Переведён в разряд грузового						67.0	0000000000000C4E
871.0		Переведён в разряд грузового						68.0	0000000000000C4F
911.0		Переведён в разряд грузового						69.0	0000000000000C50
665.0		Переведён в разряд грузового с 11.10.2021						66.0	0000000000000C51
906.0	2024-09-04 00:00:00	Изменена категория с 01.02.2024 (ст. на разъезд)	Приказ Белжд № 264Н	2023-11-03 00:00:00				72.0	0000000000000C52
281.0	2024-09-04 00:00:00	Изменена категория с 01.02.2024 (ст. на разъезд)	Приказ Белжд № 264Н	2023-11-03 00:00:00				71.0	0000000000000C53
14.0	2024-09-04 00:00:00	Изменена категория с 10.09.2024 (ст. на разъезд)	Приказ Белжд № 173Н	2024-07-01 00:00:00				73.0	0000000000000C54
547.0	2024-09-04 00:00:00	Изменена категория с 10.09.2024 (ст. на разъезд)	Приказ Белжд № 173Н	2024-07-01 00:00:00				74.0	0000000000000C55
158.0	2024-09-03 00:00:00	Изменена категория с 10.09.2024 (ст. на разъезд)	Приказ Белжд № 173Н	2024-07-01 00:00:00				75.0	0000000000000C56
581.0	2024-09-04 00:00:00	Изменена категория с 10.09.2024 (ст. на разъезд)	Приказ Белжд № 173Н	2024-07-01 00:00:00				76.0	0000000000000C57
390.0	2024-10-28 00:00:00	Переименование (прежнее Козенки)	Приказ Белжд № 969НЗ	2024-10-23 00:00:00	Козенкі	Козенки		77.0	0000000000000C58
552.0	2024-10-28 00:00:00	Переименование (прежнее Мозырь)	Приказ Белжд № 969НЗ	2024-10-23 00:00:00	Мазыр	Мозырь		78.0	0000000000000C59
486.0	2025-01-10 00:00:00	Изменена категория ст. на разъезд с 10.01.2025	Приказ Белжд № 232Н	2024-10-28 00:00:00				79.0	0000000000000C5A
34.0	2025-01-10 00:00:00	Изменена категория ст. на разъезд с 10.01.2025	Приказ Белжд № 232Н	2024-10-28 00:00:00				80.0	0000000000000C5B
102.0	2025-01-24 00:00:00	Изменена категория станция на разъезд с 20.01.2025	Приказ Белжд № 262Н	2024-11-18 00:00:00				81.0	0000000000000C5C
\.


--
-- Data for Name: _dbo_kn_hpopular; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_hpopular ("KOD_ATE", "POPULAR", "DATACENSUS", "ID", "SSMA_TimeStamp") FROM stdin;
5.0	645.0	1999-01-01 00:00:00	928.0	0000000000000C5D
5.0	535.0	2010-01-01 00:00:00	929.0	0000000000000C5E
8.0	170.0	1999-01-01 00:00:00	930.0	0000000000000C5F
8.0	160.0	2010-01-01 00:00:00	931.0	0000000000000C60
6.0	33.0	1999-01-01 00:00:00	932.0	0000000000000C61
6.0	11.0	2010-01-01 00:00:00	933.0	0000000000000C62
9.0	50.0	1999-01-01 00:00:00	934.0	0000000000000C63
9.0	34.0	2010-01-01 00:00:00	935.0	0000000000000C64
10.0	6.0	1999-01-01 00:00:00	936.0	0000000000000C65
10.0	3.0	2010-01-01 00:00:00	937.0	0000000000000C66
11.0	20.0	1999-01-01 00:00:00	938.0	0000000000000C67
11.0	5.0	2010-01-01 00:00:00	939.0	0000000000000C68
13.0	141.0	1999-01-01 00:00:00	940.0	0000000000000C69
13.0	97.0	2010-01-01 00:00:00	941.0	0000000000000C6A
14.0	161.0	1999-01-01 00:00:00	942.0	0000000000000C6B
14.0	145.0	2010-01-01 00:00:00	943.0	0000000000000C6C
15.0	41.0	1999-01-01 00:00:00	944.0	0000000000000C6D
15.0	16.0	2010-01-01 00:00:00	945.0	0000000000000C6E
16.0	53.0	1999-01-01 00:00:00	946.0	0000000000000C6F
16.0	31.0	2010-01-01 00:00:00	947.0	0000000000000C70
17.0	35.0	1999-01-01 00:00:00	948.0	0000000000000C71
17.0	18.0	2010-01-01 00:00:00	949.0	0000000000000C72
18.0	8.0	1999-01-01 00:00:00	950.0	0000000000000C73
18.0	5.0	2010-01-01 00:00:00	951.0	0000000000000C74
19.0	69.0	1999-01-01 00:00:00	952.0	0000000000000C75
19.0	45.0	2010-01-01 00:00:00	953.0	0000000000000C76
20.0	66.0	1999-01-01 00:00:00	954.0	0000000000000C77
20.0	53.0	2010-01-01 00:00:00	955.0	0000000000000C78
21.0	100.0	1999-01-01 00:00:00	956.0	0000000000000C79
21.0	43.0	2010-01-01 00:00:00	957.0	0000000000000C7A
22.0	37.0	1999-01-01 00:00:00	958.0	0000000000000C7B
22.0	24.0	2010-01-01 00:00:00	959.0	0000000000000C7C
23.0	95.0	1999-01-01 00:00:00	960.0	0000000000000C7D
23.0	42.0	2010-01-01 00:00:00	961.0	0000000000000C7E
24.0	71.0	1999-01-01 00:00:00	962.0	0000000000000C7F
24.0	33.0	2010-01-01 00:00:00	963.0	0000000000000C80
26.0	501.0	1999-01-01 00:00:00	964.0	0000000000000C81
26.0	423.0	2010-01-01 00:00:00	965.0	0000000000000C82
27.0	16.0	1999-01-01 00:00:00	966.0	0000000000000C83
27.0	21.0	2010-01-01 00:00:00	967.0	0000000000000C84
28.0	184.0	1999-01-01 00:00:00	968.0	0000000000000C85
28.0	126.0	2010-01-01 00:00:00	969.0	0000000000000C86
29.0	9.0	1999-01-01 00:00:00	970.0	0000000000000C87
29.0	51.0	2010-01-01 00:00:00	971.0	0000000000000C88
30.0	8.0	1999-01-01 00:00:00	972.0	0000000000000C89
30.0	5.0	2010-01-01 00:00:00	973.0	0000000000000C8A
31.0	107.0	1999-01-01 00:00:00	974.0	0000000000000C8B
31.0	81.0	2010-01-01 00:00:00	975.0	0000000000000C8C
32.0	45.0	1999-01-01 00:00:00	976.0	0000000000000C8D
32.0	40.0	2010-01-01 00:00:00	977.0	0000000000000C8E
33.0	1470.0	1999-01-01 00:00:00	978.0	0000000000000C8F
33.0	1560.0	2010-01-01 00:00:00	979.0	0000000000000C90
34.0	64.0	1999-01-01 00:00:00	980.0	0000000000000C91
34.0	55.0	2010-01-01 00:00:00	981.0	0000000000000C92
36.0	181.0	1999-01-01 00:00:00	982.0	0000000000000C93
38.0	808.0	1999-01-01 00:00:00	984.0	0000000000000C94
4.0	2092.0	1999-01-01 00:00:00	2841.0	0000000000000C95
4.0	1541.0	2010-01-01 00:00:00	2842.0	0000000000000C96
25.0	2404.0	1999-01-01 00:00:00	2846.0	0000000000000C97
25.0	2362.0	2010-01-01 00:00:00	2847.0	0000000000000C98
35.0	2755.0	1999-01-01 00:00:00	2848.0	0000000000000C99
35.0	1890.0	2010-01-01 00:00:00	2849.0	0000000000000C9A
7.0	86.0	1999-01-01 00:00:00	2871.0	0000000000000C9B
7.0	59.0	2010-01-01 00:00:00	2872.0	0000000000000C9C
3.0	2600.0	1999-01-01 00:00:00	2926.0	0000000000000C9D
2.0	49000.0	1999-01-01 00:00:00	2928.0	0000000000000C9E
2.0	41883.0	2010-01-01 00:00:00	2929.0	0000000000000C9F
1.0	1485095.0	1999-01-01 00:00:00	46093.0	0000000000000CA0
1.0	1402016.0	2010-01-01 00:00:00	46094.0	0000000000000CA1
12.0	205.0	1999-01-01 00:00:00	46502.0	0000000000000CA2
12.0	182.0	2010-01-01 00:00:00	46503.0	0000000000000CA3
37.0	19.0	1999-01-01 00:00:00	48385.0	0000000000000CA4
37.0	14.0	2010-01-01 00:00:00	48386.0	0000000000000CA5
36.0	107.0	2010-01-01 00:00:00	983.0	0000000000000CA6
3.0	2200.0	2010-01-01 00:00:00	2927.0	0000000000000CA7
3.0	2040.0	2016-01-01 00:00:00	48840.0	0000000000000CA8
1.0	1386982.0	2016-01-01 00:00:00	48931.0	0000000000000CA9
2.0	31886.0	2016-01-01 00:00:00	48937.0	0000000000000CAA
2.0	31340.0	2017-01-01 00:00:00	48980.0	0000000000000CAB
3.0	2024.0	2017-01-01 00:00:00	48981.0	0000000000000CAC
1.0	1386351.0	2017-01-01 00:00:00	49091.0	0000000000000CAD
1.0	1384476.0	2018-01-01 00:00:00	49306.0	0000000000000CAE
3.0	1992.0	2018-01-01 00:00:00	49316.0	0000000000000CAF
2.0	30850.0	2018-01-01 00:00:00	49513.0	0000000000000CB0
1.0	1380391.0	2019-01-01 00:00:00	49636.0	0000000000000CB1
2.0	30344.0	2019-01-01 00:00:00	49642.0	0000000000000CB2
3.0	1990.0	2019-01-01 00:00:00	49646.0	0000000000000CB3
1.0	1347000.0	2020-01-01 00:00:00	49963.0	0000000000000CB4
1.0	1338044.0	2021-01-01 00:00:00	49981.0	0000000000000CB5
2.0	29110.0	2021-01-01 00:00:00	49991.0	0000000000000CB6
3.0	1843.0	2021-01-01 00:00:00	49992.0	0000000000000CB7
1.0	1324027.0	2022-01-01 00:00:00	50316.0	0000000000000CB8
2.0	28337.0	2022-01-01 00:00:00	50327.0	0000000000000CB9
3.0	1785.0	2022-01-01 00:00:00	50328.0	0000000000000CBA
1.0	1315405.0	2023-01-01 00:00:00	50655.0	0000000000000CBB
2.0	27664.0	2023-01-01 00:00:00	50662.0	0000000000000CBC
3.0	1748.0	2023-01-01 00:00:00	50663.0	0000000000000CBD
1.0	1308569.0	2024-01-01 00:00:00	50980.0	0000000000000CBE
2.0	27287.0	2024-01-01 00:00:00	50989.0	0000000000000CBF
3.0	1705.0	2024-01-01 00:00:00	50990.0	0000000000000CC0
\.


--
-- Data for Name: _dbo_kn_nod; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_nod ("OBJECTID", "ID_NOD", "NOD_CUT", "NOD", "SSMA_TimeStamp") FROM stdin;
8.0	1.0	НОД-1	Минское	0000000000000CC1
9.0	2.0	НОД-2	Барановичское	0000000000000CC2
10.0	3.0	НОД-3	Брестское	0000000000000CC3
11.0	4.0	НОД-4	Гомельское	0000000000000CC4
12.0	5.0	НОД-5	Могилёвское	0000000000000CC5
13.0	6.0	НОД-6	Витебское	0000000000000CC6
\.


--
-- Data for Name: _dbo_kn_obl; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_obl ("ID_OBL", "KOD_OBL", "OBL", "SSMA_TimeStamp") FROM stdin;
1.0	1.0	Брестская	0000000000000CC7
2.0	2.0	Витебская	0000000000000CC8
3.0	3.0	Гомельская	0000000000000CC9
4.0	4.0	Гродненская	0000000000000CCA
5.0	5.0	Минск	0000000000000CCB
6.0	6.0	Минская	0000000000000CCC
7.0	7.0	Могилёвская	0000000000000CCD
\.


--
-- Data for Name: _dbo_kn_ra; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_ra ("ID_RA", "KOD_RA", "RA", "SSMA_TimeStamp", "ID_OBL") FROM stdin;
104.0	4.0	Барановичский	0000000000000CCE	1.0
112.0	12.0	Брестский	0000000000000CCF	1.0
116.0	16.0	Ганцевичский	0000000000000CD0	1.0
120.0	20.0	Дрогичинский	0000000000000CD1	1.0
125.0	25.0	Жабинковский	0000000000000CD2	1.0
130.0	30.0	Ивановский	0000000000000CD3	1.0
134.0	34.0	Ивацевичский	0000000000000CD4	1.0
140.0	40.0	Каменецкий	0000000000000CD5	1.0
143.0	43.0	Кобринский	0000000000000CD6	1.0
147.0	47.0	Лунинецкий	0000000000000CD7	1.0
150.0	50.0	Ляховичский	0000000000000CD8	1.0
152.0	52.0	Малоритский	0000000000000CD9	1.0
154.0	54.0	Пинский	0000000000000CDA	1.0
156.0	56.0	Пружанский	0000000000000CDB	1.0
158.0	58.0	Столинский	0000000000000CDC	1.0
205.0	5.0	Бешенковичский	0000000000000CDD	2.0
208.0	8.0	Браславский	0000000000000CDE	2.0
210.0	10.0	Верхнедвинский	0000000000000CDF	2.0
212.0	12.0	Витебский	0000000000000CE0	2.0
215.0	15.0	Глубокский	0000000000000CE1	2.0
218.0	18.0	Городокский	0000000000000CE2	2.0
221.0	21.0	Докшицкий	0000000000000CE3	2.0
224.0	24.0	Дубровенский	0000000000000CE4	2.0
227.0	27.0	Лепельский	0000000000000CE5	2.0
230.0	30.0	Лиозненский	0000000000000CE6	2.0
233.0	33.0	Миорский	0000000000000CE7	2.0
236.0	36.0	Оршанский	0000000000000CE8	2.0
238.0	38.0	Полоцкий	0000000000000CE9	2.0
240.0	40.0	Поставский	0000000000000CEA	2.0
242.0	42.0	Россонский	0000000000000CEB	2.0
244.0	44.0	Сенненский	0000000000000CEC	2.0
246.0	46.0	Толочинский	0000000000000CED	2.0
249.0	49.0	Ушачский	0000000000000CEE	2.0
251.0	51.0	Чашникский	0000000000000CEF	2.0
255.0	55.0	Шарковщинский	0000000000000CF0	2.0
258.0	58.0	Шумилинский	0000000000000CF1	2.0
303.0	3.0	Брагинский	0000000000000CF2	3.0
305.0	5.0	Буда-Кошелёвский	0000000000000CF3	3.0
308.0	8.0	Ветковский	0000000000000CF4	3.0
310.0	10.0	Гомельский	0000000000000CF5	3.0
312.0	12.0	Добрушский	0000000000000CF6	3.0
314.0	14.0	Ельский	0000000000000CF7	3.0
316.0	16.0	Житковичский	0000000000000CF8	3.0
318.0	18.0	Жлобинский	0000000000000CF9	3.0
323.0	23.0	Калинковичский	0000000000000CFA	3.0
325.0	25.0	Кормянский	0000000000000CFB	3.0
328.0	28.0	Лельчицкий	0000000000000CFC	3.0
330.0	30.0	Лоевский	0000000000000CFD	3.0
335.0	35.0	Мозырский	0000000000000CFE	3.0
338.0	38.0	Наровлянский	0000000000000CFF	3.0
340.0	40.0	Октябрьский	0000000000000D01	3.0
343.0	43.0	Петриковский	0000000000000D02	3.0
345.0	45.0	Речицкий	0000000000000D03	3.0
347.0	47.0	Рогачёвский	0000000000000D04	3.0
350.0	50.0	Светлогорский	0000000000000D05	3.0
354.0	54.0	Хойникский	0000000000000D06	3.0
356.0	56.0	Чечерский	0000000000000D07	3.0
404.0	4.0	Берестовицкий	0000000000000D08	4.0
408.0	8.0	Волковысский	0000000000000D09	4.0
413.0	13.0	Вороновский	0000000000000D0A	4.0
420.0	20.0	Гродненский	0000000000000D0B	4.0
423.0	23.0	Дятловский	0000000000000D0C	4.0
426.0	26.0	Зельвенский	0000000000000D0D	4.0
429.0	29.0	Ивьевский	0000000000000D0E	4.0
433.0	33.0	Кореличский	0000000000000D0F	4.0
436.0	36.0	Лидский	0000000000000D10	4.0
440.0	40.0	Мостовский	0000000000000D11	4.0
443.0	43.0	Новогрудский	0000000000000D12	4.0
446.0	46.0	Островецкий	0000000000000D13	4.0
449.0	49.0	Ошмянский	0000000000000D14	4.0
452.0	52.0	Свислочский	0000000000000D15	4.0
454.0	54.0	Слонимский	0000000000000D16	4.0
456.0	56.0	Сморгонский	0000000000000D17	4.0
458.0	58.0	Щучинский	0000000000000D18	4.0
604.0	4.0	Березинский	0000000000000D19	6.0
608.0	8.0	Борисовский	0000000000000D1A	6.0
613.0	13.0	Вилейский	0000000000000D1B	6.0
620.0	20.0	Воложинский	0000000000000D1C	6.0
622.0	22.0	Дзержинский	0000000000000D1D	6.0
625.0	25.0	Клецкий	0000000000000D1E	6.0
628.0	28.0	Копыльский	0000000000000D1F	6.0
630.0	30.0	Крупский	0000000000000D20	6.0
632.0	32.0	Логойский	0000000000000D21	6.0
634.0	34.0	Любанский	0000000000000D22	6.0
636.0	36.0	Минский	0000000000000D23	6.0
638.0	38.0	Молодечненский	0000000000000D24	6.0
640.0	40.0	Мядельский	0000000000000D25	6.0
642.0	42.0	Несвижский	0000000000000D26	6.0
644.0	44.0	Пуховичский	0000000000000D27	6.0
646.0	46.0	Слуцкий	0000000000000D28	6.0
648.0	48.0	Смолевичский	0000000000000D29	6.0
650.0	50.0	Солигорский	0000000000000D2A	6.0
652.0	52.0	Стародорожский	0000000000000D2B	6.0
654.0	54.0	Столбцовский	0000000000000D2C	6.0
656.0	56.0	Узденский	0000000000000D2D	6.0
658.0	58.0	Червенский	0000000000000D2E	6.0
704.0	4.0	Белыничский	0000000000000D2F	7.0
708.0	8.0	Бобруйский	0000000000000D30	7.0
713.0	13.0	Быховский	0000000000000D31	7.0
108.0	8.0	Берёзовский	0000000000000D32	1.0
701.0	1.0	Глусский	0000000000000D83	7.0
702.0	2.0	Горецкий	0000000000000D84	7.0
703.0	3.0	Дрибинский	0000000000000D85	7.0
705.0	5.0	Кировский	0000000000000D86	7.0
706.0	6.0	Кличевский	0000000000000D87	7.0
707.0	7.0	Климовичский	0000000000000D88	7.0
709.0	9.0	Костюковичский	0000000000000D89	7.0
710.0	10.0	Краснопольский	0000000000000D8A	7.0
711.0	11.0	Кричевский	0000000000000D8B	7.0
712.0	12.0	Круглянский	0000000000000D8C	7.0
714.0	14.0	Могилёвский	0000000000000D8D	7.0
715.0	15.0	Мстиславский	0000000000000D8E	7.0
716.0	16.0	Осиповичский	0000000000000D8F	7.0
717.0	17.0	Славгородский	0000000000000D90	7.0
718.0	18.0	Чаусский	0000000000000D91	7.0
719.0	19.0	Чериковский	0000000000000D92	7.0
720.0	20.0	Шкловский	0000000000000D93	7.0
721.0	21.0	Хотимский	0000000000000D94	7.0
\.


--
-- Data for Name: _dbo_kn_rodate; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_rodate ("ID_RODATE", "RATECUT", "RATENAME", "SSMA_TimeStamp") FROM stdin;
235.0	аг.	Сельский населенный пункт - агрогородок	0000000000000D33
202.0	вгр-н	Внутригородской район	0000000000000D34
112.0	гоп	Город областного подчинения	0000000000000D35
121.0	гп	Поселок городского типа - городской поселок	0000000000000D36
113.0	грп	Город районного подчинения	0000000000000D37
231.0	д	Сельский населенный пункт - деревня	0000000000000D38
245.0	зак.р-н	Заказник районного значения	0000000000000D39
241.0	запов.	Заповедник	0000000000000D3A
261.0	икц	Историко-культурная ценность	0000000000000D3B
122.0	кп	Поселок городского типа - курортный поселок	0000000000000D3C
101.0	обл.	Область	0000000000000D3D
232.0	п	Сельский населенный пункт - поселок	0000000000000D3E
102.0	р-н	Район области	0000000000000D3F
123.0	рп	Поселок городского типа - рабочий поселок	0000000000000D40
233.0	с	Сельский населенный пункт - село	0000000000000D41
103.0	с/с	Сельсовет	0000000000000D42
239.0	снп	Сельский населенный пункт - иное	0000000000000D43
111.0	стол.	Столица Республики Беларусь	0000000000000D44
281.0	сэз	Свободная экономическая зона	0000000000000D45
271.0	тон	Территория оборонного назначения	0000000000000D46
234.0	х	Сельский населенный пункт - хутор	0000000000000D47
999.0	п/с	Поселковый совет	0000000000000D48
555.0	г/c	Городской совет	0000000000000D49
666.0	р/c	Районный совет	0000000000000D4A
299.0	оэз	Особая экономическая зона	0000000000000D4B
243.0	зак.респ.	Заказник республиканского значения	0000000000000D4C
244.0	зак.обл.	Заказник областного значения	0000000000000D4D
242.0	нац.парк	Национальный парк	0000000000000D4E
251.0	пам. прир.респ.	Памятник природы республиканского значения	0000000000000D4F
252.0	пам. прир.обл.	Памятник природы областного значения	0000000000000D50
253.0	пам. прир.р-н	Памятник природы районного значения	0000000000000D51
\.


--
-- Data for Name: _dbo_kn_rodfgo; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_rodfgo ("RFGONAME", "ID_RODFGO", "SSMA_TimeStamp") FROM stdin;
вдхр.	1.0	0000000000000D52
болото	2.0	0000000000000D53
возвышенность	3.0	0000000000000D54
высота	4.0	0000000000000D55
гора	5.0	0000000000000D56
гряда	6.0	0000000000000D57
долина	7.0	0000000000000D58
залив	8.0	0000000000000D59
канава	9.0	0000000000000D5A
канал	10.0	0000000000000D5B
лес	11.0	0000000000000D5C
низменность	12.0	0000000000000D5D
озёра	13.0	0000000000000D5E
озеро	14.0	0000000000000D5F
остров	15.0	0000000000000D60
перекат	16.0	0000000000000D61
протока	17.0	0000000000000D62
пруд	18.0	0000000000000D63
пруды	19.0	0000000000000D64
равнина	20.0	0000000000000D65
река	21.0	0000000000000D66
ручей	22.0	0000000000000D67
стар. русло	23.0	0000000000000D68
староречье	25.0	0000000000000D69
урочище	26.0	0000000000000D6A
старица	24.0	0000000000000D6B
\.


--
-- Data for Name: _dbo_kn_sinfo; Type: TABLE DATA; Schema: public; Owner: rebasedata
--

COPY public._dbo_kn_sinfo ("ID_SINFO", "SINFOCUT", "SINFONAME", "SSMA_TimeStamp") FROM stdin;
1.0	НКА	Единый Реестр Национального кадастрового агентства	0000000000000D6C
2.0	р/с	Списки населенных пунктов районных Советов депутатов на 1.01-1.06.2000 г.	0000000000000D6D
3.0	с/с	Списки предварительного учета сельских населенных пунктов	0000000000000D6E
4.0	д.к.	Дежурная справочная карта Республики Беларусь масштаба 1:100000	0000000000000D6F
5.0	Сп. Комзема	Списки населенных пунктов Комзема к дежурной справочной карте	0000000000000D70
6.0	ПВС	Картотека Президиума Верховного Совета БССР	0000000000000D71
7.0	Рап	Слоўнік назваў населеных пунктаў Рэспублікі Беларусь, Я.Н. Рапановіч, "Навука і тэхніка", 1977-1986 гг.	0000000000000D72
8.0	НАН	Материалы Национальной академии наук Беларуси	0000000000000D73
9.0	Бг	Списки РУП "Белгеодезия"	0000000000000D74
10.0	Бл. кн.	Энцыклапедыя "Блакітная кніга Беларусі", БелЭн, 1994 г.	0000000000000D75
11.0	Вод. ресурсы	Справочник "Изменение гидрографической сети Беларуси под воздействием мелиоративных работ", 1999 г.	0000000000000D76
12.0	р/и	Письмо районного исполнительного комитета	0000000000000D77
13.0	Пост. СМ	Постановление Совета Министров БССР № 31 от 27.01.84 г.	0000000000000D78
14.0	БЭ	Беларуская энцыклапедыя	0000000000000D79
15.0	Шаруха	Географа-статчыстычны слоўнік Магілёўскай вобласці, І.М. Шаруха	0000000000000D7A
16.0	Давед. Гродзен. вобл.	Нарматыўны даведнік "Назвы населеных пунктаў Рэспублікі Беларусь. Гродзенская вобласць", 2004 г.	0000000000000D7B
17.0	Давед. Мінская вобл.	Нарматыўны даведнік "Назвы населеных пунктаў Рэспублікі Беларусь. Мінская вобласць", 2003 г.	0000000000000D7C
18.0	НА	Нацыянальны атлас Беларусі, Мінск 2002	0000000000000D7D
19.0	Давед. Гомельская вобл.	Нарматыўны даведнік "Назвы населеных пунктаў Рэспублікі Беларусь. Гомельская вобласць", 2006 г.	0000000000000D7E
20.0	Давед. Магілёўская вобл.	Нарматыўны даведнік "Назвы населеных пунктаў Рэспублікі Беларусь. Магілёўская вобласць", 2007 г.	0000000000000D7F
21.0	Карта м-ба 1:10 000	Топографическая карта м-ба 1:10 000	0000000000000D80
23.0	Давед. Брэсцкая вобласць	Нарматыўны даведнік "Назвы населеных пунктаў Рэспублікі Беларусь. Брэсцкая вобласць", 2010 г.	0000000000000D81
22.0	Давед. Віцебская вобласць	Нарматыўны даведнік "Назвы населеных пунктаў Рэспублікі Беларусь. Віцебская вобласць", 2009	0000000000000D82
\.


--
-- PostgreSQL database dump complete
--


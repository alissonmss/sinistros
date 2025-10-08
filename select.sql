-- contagem de sinistros por bairro
SELECT count(bairro), bairro FROM public.recife_sinistros
group by bairro
order by count(bairro) desc
LIMIT 24

/*
8960	"BOA VIAGEM"
4330	"IMBIRIBEIRA"
3516	"SANTO AMARO"
2744	"AFOGADOS"
2640	"BOA VISTA"
2638	"MADALENA"
2006	"DERBY"
1992	"CASA AMARELA"
1922	"IPSEP"
1897	"PINA"
1687	"CORDEIRO"
1604	"IBURA"
1541	"SÃO JOSÉ"
1531	"ESPINHEIRO"
1426	"TORRE"
1252	"AREIAS"
1179	"IPUTINGA"
1158	"CAXANGÁ"
1149	"CAMPO GRANDE"
1124	"GRAÇAS"
1120	"VÁRZEA"
1026	"CASA FORTE"
1021	"SAN MARTIN"
1004	"ENCRUZILHADA"
*/


SELECT 
  MOD(ROUND(EXTRACT(hour FROM cast(to_timestamp(hora, 'hh24')::time as integer)) * 60 + EXTRACT(minute FROM cast(to_timestamp(hora, 'hh24')::time as integer)) / 60)::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora


SELECT 
  MOD(ROUND(EXTRACT(hour FROM hora::timestamp::time)::integer * 60 + EXTRACT(minute FROM hora::timestamp::time)::integer / 60)::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora
--ERROR:  invalid input syntax for type timestamp: "00:01:00"

SELECT 
  MOD(ROUND(EXTRACT(hour FROM hora::time)::integer * 60 + EXTRACT(minute FROM hora::time)::integer / 60)::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora
--ERROR:  invalid input syntax for type time: "M"

SELECT 
  MOD(ROUND(EXTRACT(hour FROM hora::time)::integer * 60 + EXTRACT(minute FROM hora::time)::integer / 60)::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE hora not in('M', 'MARINALVA', '1037712:00:00', '07/mai', '.', '1049592:00:00', '48:00:00', 'judia', 'CITTAMOBI') and EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora
/*
0	28082
12	27302
*/

SELECT 
  MOD(ROUND(EXTRACT(hour FROM hora::time) * 60 + EXTRACT(minute FROM hora::time) / 60)::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE hora not in('M', 'MARINALVA', '1037712:00:00', '07/mai', '.', '1049592:00:00', '48:00:00', 'judia', 'CITTAMOBI') and EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora

/*
0	14619
1	13463
12	14080
13	13222
*/

SELECT 
  MOD((EXTRACT(hour FROM hora::time) + EXTRACT(minute FROM hora::time))::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE hora not in('M', 'MARINALVA', '1037712:00:00', '07/mai', '.', '1049592:00:00', '48:00:00', 'judia', 'CITTAMOBI', '29208:00:00') and EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora

/*
0	2265
1	2280
2	2223
3	2166
4	2127
5	2150
6	1967
7	2012
8	2115
9	2171
10	2283
11	2309
12	2349
13	2303
14	2369
15	2495
16	2545
17	2592
18	2555
19	2488
20	2459
21	2444
22	2340
23	2377
*/
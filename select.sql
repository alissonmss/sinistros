-- total de registros: 72255
select count(*) from recife_sinistros

SELECT COUNT(*)
FROM recife_sinistros
WHERE extract(year from data) = 2022
-- total ano 2022: 2669

-- 69521 + 2669 (2022 null)= 72190
-- 72255 - 72190 = 65
-- 65 = 10 (invalidos) + 55 (null entre 2016 e 2019)

-- total de type invalido: 10
select id from recife_sinistros
WHERE hora in('M', 'MARINALVA', '1037712:00:00', '07/mai', '.', '1049592:00:00', '48:00:00', 'judia', 'CITTAMOBI', '29208:00:00')
/*
3321	"M"
3724	"MARINALVA"
4456	"1037712:00:00"
4626	"07/mai"
5626	"."
8377	"1049592:00:00"
10214	"48:00:00"
1324	"judia"
216	"29208:00:00"
2022	"CITTAMOBI"
*/

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


-- sinistro por hora todos dias
 SELECT 
  MOD(((EXTRACT(hour FROM hora::time)*60 + EXTRACT(minute FROM hora::time)) / 60)::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE hora not in('M', 'MARINALVA', '1037712:00:00', '07/mai', '.', '1049592:00:00', '48:00:00', 'judia', 'CITTAMOBI', '29208:00:00') --and EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora
/*
0	849
1	865
2	965
3	848
4	955
5	943
6	1565
7	3175
8	5410
9	4925
10	4865
11	4595
12	4854
13	4476
14	3963
15	4064
16	4126
17	3692
18	3556
19	3425
20	2624
21	1846
22	1761
23	1174
*/
-- total 69521

-- sinistro por hora todos dias / ANO (2022 missing hora)
 SELECT 
  MOD(((EXTRACT(hour FROM hora::time)*60) / 60)::integer, 24) AS nhora, 
  COUNT(*)
FROM recife_sinistros
WHERE extract(year from data) = 2022 and hora not in('M', 'MARINALVA', '1037712:00:00', '07/mai', '.', '1049592:00:00', '48:00:00', 'judia', 'CITTAMOBI', '29208:00:00') --and EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY nhora
ORDER BY nhora
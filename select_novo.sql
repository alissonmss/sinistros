-- segunda a domingo
SELECT EXTRACT(year from data::date) AS ano, MOD(((EXTRACT(hour from hora::time) * 60 + EXTRACT(minute from hora::time) + 30) / 60)::integer, 24) AS horas, COUNT(*)
FROM public.recife_sinistros
WHERE is_valid_time(hora) = true
GROUP BY ano, horas
ORDER BY ano, horas

-- segunda a sexta
SELECT EXTRACT(year from data::date) AS ano, MOD(((EXTRACT(hour from hora::time) * 60 + EXTRACT(minute from hora::time) + 30) / 60)::integer, 24) AS horas, COUNT(*)
FROM public.recife_sinistros
WHERE is_valid_time(hora) = true and EXTRACT(DOW FROM data) BETWEEN 1 AND 5
GROUP BY ano, horas
ORDER BY ano, horas


-- sábado e domingo
SELECT EXTRACT(year from data::date) AS ano, MOD(((EXTRACT(hour from hora::time) * 60 + EXTRACT(minute from hora::time) + 30) / 60)::integer, 24) AS horas, COUNT(*)
FROM public.recife_sinistros
WHERE is_valid_time(hora) = true and EXTRACT(DOW FROM data) in(6,7)
GROUP BY ano, horas
ORDER BY ano, horas
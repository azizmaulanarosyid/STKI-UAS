SELECT * FROM token; 

SELECT id,kata,SUM(freq) freq FROM token GROUP BY id,kata ORDER BY id+0,NO+0;

SELECT id,SUM(freq) jmlkata FROM token GROUP BY id+0; 

SELECT a.id,a.kata,a.freq,b.jmlkata,(a.freq/b.jmlkata) tf FROM
(SELECT id,kata,SUM(freq) freq FROM token GROUP BY id,kata ORDER BY id+0,NO+0) AS a
JOIN
(SELECT id,SUM(freq) jmlkata FROM token GROUP BY id+0) AS b
ON a.id=b.id; 


SELECT COUNT(id) jmldok FROM
(SELECT id FROM token GROUP BY id+0) AS c; 

SELECT kata,COUNT(kata) katajmldok FROM
(SELECT id,no,kata,SUM(freq) freq FROM token GROUP BY id,kata ORDER BY id+0,NO+0) AS d GROUP BY kata ORDER BY id+0,NO+0; 

SELECT kata,f.jmldok,e.katajmldok,LOG10(f.jmldok/e.katajmldok) idf FROM
(SELECT kata,COUNT(kata) katajmldok FROM
(SELECT id,no,kata,SUM(freq) freq FROM token GROUP BY id,kata ORDER BY id+0,NO+0) AS d GROUP BY kata ORDER BY id+0,NO+0) AS e
JOIN
(SELECT COUNT(id) jmldok FROM
(SELECT id FROM token GROUP BY id+0) AS c) AS f; 

SELECT g.id,g.kata,g.freq,g.jmlkata,g.tf,h.jmldok,h.katajmldok,h.idf,(g.tf*h.idf) tf_idf from
(SELECT a.id,a.kata,a.freq,b.jmlkata,(a.freq/b.jmlkata) tf FROM
(SELECT id,kata,SUM(freq) freq FROM token GROUP BY id,kata ORDER BY id+0,NO+0) AS a
JOIN
(SELECT id,SUM(freq) jmlkata FROM token GROUP BY id+0) AS b
ON a.id=b.id) AS g
JOIN
(SELECT kata,f.jmldok,e.katajmldok,LOG10(f.jmldok/e.katajmldok) idf FROM
(SELECT kata,COUNT(kata) katajmldok FROM
(SELECT id,no,kata,SUM(freq) freq FROM token GROUP BY id,kata ORDER BY id+0,NO+0) AS d GROUP BY kata ORDER BY id+0,NO+0) AS e
JOIN
(SELECT COUNT(id) jmldok FROM
(SELECT id FROM token GROUP BY id+0) AS c) AS f) AS h
ON g.kata=h.kata; 
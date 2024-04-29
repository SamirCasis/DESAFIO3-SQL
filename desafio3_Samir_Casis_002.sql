--RESPUESTA N°1
SELECT * FROM usuarios ORDER BY id;
SELECT * FROM posts;
SELECT * FROM comentarios;

--RESPUESTA N°2
SELECT u.nombre, u.email, p.titulo, p.contenido
FROM usuarios AS u
INNER JOIN posts AS p ON u.id = p.usuario_id;

--RESPUESTA N°3
SELECT p.id, p.titulo, p.contenido
FROM posts AS p
INNER JOIN usuarios AS u ON p.usuario_id = u.id
WHERE u.rol = 'administrador';

--RESPUESTA N°4
SELECT u.id, u.email, COUNT(p.id) AS "posts de cada usuario"
FROM usuarios AS u
LEFT JOIN posts AS p ON u.id = p.usuario_id
GROUP BY u.id, u.email
ORDER BY id;

--RESPUESTA N°5
SELECT u.email
FROM Usuarios u
INNER JOIN Posts p ON u.id = p.usuario_id
GROUP BY u.email
ORDER BY COUNT(p.id) DESC
LIMIT 1;

--RESPUESTA N°6
SELECT u.id, u.email, MAX(p.fecha_actualizacion) AS "fecha del último post"
FROM usuarios AS u
LEFT JOIN posts AS p ON u.id = p.usuario_id
GROUP BY u.id, u.email
ORDER BY id;

--RESPUESTA N°7
SELECT p.titulo, p.contenido
FROM Posts p
LEFT JOIN (
    SELECT post_id, COUNT(*) AS "numero de comentarios"
    FROM Comentarios
    GROUP BY post_id
) AS "contador" ON p.id = contador.post_id
ORDER BY "numero de comentarios" DESC
LIMIT 1;

--RESPUESTA N°8
SELECT p.titulo AS "titulo del post", p.contenido AS "contenido del post",
c.contenido AS "contenido del comentario", u.email
FROM posts AS p
LEFT JOIN comentarios AS c ON p.id = c.post_id
LEFT JOIN usuarios AS u ON c.usuario_id = u.id
LIMIT 5;

--RESPUESTA N°9
SELECT u.id, u.email, c.contenido AS "Contenido del último comentario"
FROM usuarios AS u
LEFT JOIN (
  SELECT usuario_id, contenido, fecha_creacion
  FROM   comentarios
  WHERE  (usuario_id, fecha_creacion) 
  IN (   
	SELECT usuario_id, MAX(fecha_creacion)
    FROM comentarios
    GROUP BY usuario_id
  )
 ) AS c ON u.id = c.usuario_id
ORDER BY u.id
LIMIT 3;

--RESPUESTA N°10
SELECT u.email
FROM usuarios AS u
LEFT JOIN Comentarios AS c ON u.id = c.usuario_id
WHERE c.usuario_id IS NULL;
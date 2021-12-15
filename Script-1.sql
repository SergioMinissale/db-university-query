-- 1. Selezionare tutti gli studenti nati nel 1990 
select *
from students
where year(date_of_birth) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti
select *
from courses
where cfu > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
select *
from students
where timestampdiff(year, date_of_birth, curdate()) > 30;

-- 4. Selezionare tutti i corsi di laurea magistrale
select *
from degrees 
where `level` = 'magistrale';

-- 5. Da quanti dipartimenti è composta l’università?
select count(id) as num_dipartimenti
from departments;

-- 6. Quanti sono gli insegnanti che non hanno un numero di telefono?
select count(id) as insegnati_senza_numero_di_telefono
from teachers t
where t.phone is null;

-- 7. Contare quanti iscritti ci sono stati ogni anno
select YEAR(s.enrolment_date) as Anno_iscrizione, count(s.id) as Iscritti_per_anno 
from students s 
group by Anno_iscrizione
order by Iscritti_per_anno;

-- 8. Calcolare la media dei voti di ogni appello d’esame
select e.id as Id_Esame, avg(es.vote) as Media_voti
from exams e 
inner join exam_student es 
where e.id = es.exam_id
group by e.id;

-- 9. Contare quanti corsi di laurea ci sono per ogni dipartimento
select dep.name as Nome_Dipartimento, count(c.id) as Num_Corsi 
from courses c 
inner join degrees d on c.degree_id = d.id 
inner join departments dep on d.department_id = dep.id
group by dep.name;

-- 10. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
select s.surname as Cognome, s.name as Nome, d.name as Corso
from students s 
inner join degrees d 
on s.degree_id = d.id
where d.name = 'Corso di Laurea in Economia'
order by s.surname, s.name;

-- 11. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
select d.id as Id_corso, d.name as Corso, d.`level` as Tipo_di_laurea, dep.id as Id_dipartimento, dep.name as Dipartimento
from degrees d 
inner join departments dep
on d.department_id = dep.id
where dep.name = 'Dipartimento Di Neuroscienze'
and d.level = 'magistrale';

-- 12. Selezionare tutti i corsi in cui insegna Fulvio Amato
select t.id as Id_insegnante, t.name as Nome, t.surname as Cognome, c.id as Id_corso, c.name as Nome_corso, c.description as Descrizione, c.period as Periodo, c.`year` , c.cfu as Crediti_formativi
from course_teacher ct 
inner join teachers t 
on ct.teacher_id = t.id
inner join courses c 
on ct.course_id = c.id
where t.name = 'Fulvio' and t.surname = 'Amato';

-- 13. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
select s.id as Id_studente, s.surname as Cognome, s.name as Nome, d.name as Nome_del_corso, d.`level` as Tipo_di_laurea, dep.name as Nome_dipartimento
from students s
inner join `degrees` d on s.degree_id = d.id
inner join departments dep on d.department_id = dep.id
order by s.surname, s.name;

-- BONUS Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
select s.id as Id_studente, s.surname as Cognome_studente, s.name as Nome_studente, s.fiscal_code as Codice_fiscale_studente, e.id as Id_esame, count(es.exam_id) as Tentativi_esame
from exam_student es 
inner join students s
on s.id = es.student_id
inner join exams e
on e.id = es.exam_id
group by es.exam_id ;

use UNIVER;

select p1.SUBJECT, p1.NOTE, (select COUNT(*) from PROGRESS p where p.SUBJECT=p.SUBJECT and p.NOTE=p1.NOTE)[йнК-бн] from PROGRESS p1
group by p1.NOTE, p1.SUBJECT 
having note in (8,9);
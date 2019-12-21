SPOOL "D:\hw2.log"
Set echo on;

--1.
select c.clientno, c.fname, c.lname, c.telno, c.preftype, c.maxrent, c.email, p.rent
from client c, viewing v, propertyforrent p
where c.clientno=v.clientno
and v.propertyno=p.propertyno
and v.viewdate>to_date('2013-04','YYYY-MM')
and p.staffno=(select staffno 
               from staff
               where fname='Mary' and lname='Howe');
               
--2.
select s.staffno, s.fname, s.lname, count(p.propertyno), rank() over(order by count(p.propertyno) desc) rank
from propertyforrent p RIGHT OUTER JOIN staff s
on p.staffno=s.staffno
group by s.staffno, s.fname, s.lname;


--3.
select distinct s.staffno, s.fname, s.lname
from staff s, propertyforrent p, viewing v
where s.staffno=p.staffno
and p.propertyno=v.propertyno
and v.viewdate>=to_date('2013-05-01','YYYY-MM-DD')
and v.viewdate<=to_date('2013-05-31','YYYY-MM-DD')
order by s.staffno desc;

--4.
select distinct c.c_last, c.c_first, it.item_desc, i.inv_price
from orders o, order_line ol, inventory i, item it, customer c
where o.o_methpmt='CC' and o.o_id=ol.o_id
and ol.inv_id=i.inv_id and i.item_id=it.item_id
and o.c_id=c.c_id;

--5.
select lastn, firstn, (case when sl.sl_date_received is null then 'NOT YET ARRIVED' else '' end) as status
from (select c.c_last as lastn, c.c_first as firstn,c.c_id as cid, ol.inv_id as invid
      from orders o, customer c, order_line ol
      where o.o_id=ol.o_id and o_date>=to_date('2006-05-01','YYYY-MM-DD')
      and o_date<=to_date('2006-05-31','YYYY-MM-DD')
      and o.c_id=c.c_id) LEFT OUTER JOIN shipment_line sl
on sl.inv_id=invid;


--6.
select cat.cat_desc as catagories, sum(ol.ol_quantity) as orders, sum(inv.inv_qoh) as inventories
from item it, inventory inv, order_line ol, category cat
where it.item_id=inv.item_id and inv.inv_id=ol.inv_id and cat.cat_id = it.cat_id
group by cat.cat_desc;


--7.
alter table propertyforrent add adjustedrent number(7,2);
update propertyforrent p set p.adjustedrent=(case when (select count(viewing.propertyno) 
                                                    from viewing
                                                    where viewing.propertyno=p.propertyno 
                                                    group by viewing.propertyno) >1
                                            then p.rent else p.rent*0.95 end);
select * from propertyforrent;

--8.
---(a)
alter table client add ID number;
update client c set c.ID=1 where clientno='CR76';
update client c set c.ID=2 where clientno='CR56';
update client c set c.ID=3 where clientno='CR74';
update client c set c.ID=4 where clientno='CR62';

---(b)
create sequence seq_id1
start with 5
increment by 1
minvalue 0
nomaxvalue
nocycle
cache 5;

---(c)
insert into client values('CR23', 'Irene', 'Bae', '123-4566-7890', 'House', 1004, 'rvirene@gmail.com', seq_id1.NEXTVAL);
insert into client values('CR27', 'Joy', 'Park', '098-7657-4321', 'House', 1024, 'rvjoy@gmail.com', seq_id1.NEXTVAL);

---(d)
alter sequence seq_id1 increment by 6;

---(e)
insert into client values('CR33', 'Yeri', 'Kim', '041-4679-4305', 'House', 1027, 'rvyeri@gmail.com', seq_id1.NEXTVAL);

--9.
---(a)
alter table propertyforrent add (class VARCHAR2(10));
update propertyforrent p set p.class=(case when p.rent>(select avg(rent) 
                                                        from propertyforrent pro 
                                                        where pro.city = p.city 
                                                        group by city) then 'Lux'
                                      else 'Standard' end);
select propertyno, street, city, class
from propertyforrent;

---(b)
alter table staff add (new_id VARCHAR2(4));
update staff st set st.new_id=(decode(st.position, 'Supervisor', '1', 'Manager', '2', '3') || decode(st.sex, 'M', 'M', 'F', 'F') || substr(st.fname, 1, 1) || substr(st.lname, 1, 1));
select new_id, fname, lname
from staff;

--10.
select * from
(select * from
(select * from propertyforrent where type='Flat')
order by rent) where rownum<=3
union
select * from
(select * from
(select * from propertyforrent where type='House')
order by rent) where rownum<=3;

--11.
select *
from propertyforrent pro, viewing v, client c
where v.clientno=c.clientno
and v.propertyno=pro.propertyno
and pro.rent>c.maxrent;

Spool off;


--alter table propertyforrent drop column adjustedrent;
--
--alter table client drop column ID;
--delete from client where clientno='CR23';
--delete from client where clientno='CR27';
--delete from client where clientno='CR33';
--
--drop sequence seq_id1;
--
--alter table propertyforrent drop column class;
--
--alter table staff drop column new_id;
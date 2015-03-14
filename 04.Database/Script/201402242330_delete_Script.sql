
select * into #tmpCustomer from [customer] where customercode in
(
'200300411',
'200300412',
'200300419',
'200300424',
'200300430',
'200300432',
'200300433',
'200300434',
'200300436',
'200300437',
'200300440',
'200300449',
'200300450',
'200300451',
'200300452',
'200300460',
'200300464',
'200300472',
'200300477',
'200300488',
'200300491',
'200300507',
'200300508',
'200300513',
'200300515',
'200300517',
'200300518',
'200300519',
'200300538',
'200300546',
'200300556',
'200300567'
)
--select * from #tmpCustomer

--select * from [order] where customerId=1

begin 
tran

delete odd
--select * 
from dbo.OrderOutboundDetail odd
join orderdetail od on odd.orderDetailId = od.orderDetailId
join [order] o on od.OrderId = o.OrderId
where customerId in (select customerId from #tmpCustomer)

delete ivv
--select * 
from [invoice] ivv where orderId in(
select orderId
from [order] o where customerId in (select customerId from #tmpCustomer)
)

delete iv
--select * 
from [invoice] iv where customerId in (select customerId from #tmpCustomer)

delete o
--select * 
from [order] o where customerId in (select customerId from #tmpCustomer)

update customer
set balance=0
where customerId in (select customerId from #tmpCustomer)

drop table #tmpCustomer

-- commit
-- rollback
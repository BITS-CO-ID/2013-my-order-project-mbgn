
-- tổng nạp
select 
i.invoiceId, invoiceCode, customerId, status, businessCode, InvoiceRefId , id.amount 
--customerId ,
--sum(id.amount)
from invoice i
join invoiceDetail id on i.InvoiceId = id.invoiceId
where 1=1
and i.customerId=42 
and businesscode in ('201','208') and status=2
--and i.invoiceId not in (select invoiceRefId from Invoice where businessCode = '208' and status =2)
group by i.CustomerId


select 
sum(id.amount)
from invoice i
join invoiceDetail id on i.InvoiceId = id.invoiceId
join [order] o on i.OrderId = o.OrderId
where 1=1
and i.customerId=42 
and businesscode in ('201','208') 
and i.[status]=2
--and i.invoiceId not in (select invoiceRefId from Invoice where businessCode = '208' and status =2)
and o.OrderStatus in (4,6)





select 
c.CustomerId, c.CustomerCode, c.customerName, c.userCode
-- Số dư đóng băng
, (isnull((select sum(id.amount)
from invoice i
join invoiceDetail id on i.InvoiceId = id.invoiceId join [order] o on i.OrderId = o.OrderId
where 1=1
and businesscode in ('201','208') 
and i.[status]=2
and o.OrderStatus in (4,6)
and i.CustomerId =c.CustomerId
),0)) as SDDB
 -- Số dư khả dụng
,(isnull((select sum(id.Amount) from invoice i join invoiceDetail id on i.InvoiceId = id.invoiceId
where 1=1
and i.customerId=c.CustomerId
and i.InvoiceId in (select invoiceRefId from invoice where invoiceRefId is not null and status =2)
),0) 
-(isnull((select sum(id.Amount) from invoice i join invoiceDetail id on i.InvoiceId = id.invoiceId
where 1=1
and invoiceRefId is not null
and i.customerId=c.CustomerId
and i.status =2),0))) as SDKD
into #tbltemp
from customer c
where 1=1
--and c.CustomerId=16
group by c.CustomerId, c.CustomerCode, c.customerName, c.userCode



select c.customerId, c.customercode, c.customerName, c.usercode, c.balance,(SDDB+SDKD) as SDTT , SDKD, SDDB 
from customer c join #tbltemp t on c.CustomerId = t.CustomerId
where c.balance <> ((SDDB+SDKD))

begin
tran
update c
set c.balance=(SDDB+SDKD)
--select c.customerId, c.customercode, c.customerName, c.usercode, c.balance,(SDDB+SDKD) as SDTT , SDKD, SDDB 
from customer c join #tbltemp t on c.CustomerId = t.CustomerId
where c.balance <> ((SDDB+SDKD))
--commit


select *, (SDDB+SDKD) as SDTT 
from #tbltemp
drop table #tbltemp

------------------------------------------------------------------------------------------------------------------------
-- Chay lai cho chuan tien da tru cho ma 206 voi nhung giao dich co phat sinh, con chua chay dc truong hop chua phat sinh
select 
ord.OrderId
, c.CustomerCode
, ord.orderNo
, ord.OrderDate
, ord.DeliveryDate
-- Tiền đã phân bổ cho đơn hàng
,(select sum(od.amount)
from invoice o 
join invoicedetail od on o.invoiceId = od.InvoiceId
	where 1=1
		and businesscode in ('201', '208')
		and ord.orderId = o.OrderId
		and o.invoiceId not in (select invoiceRefId from invoice where invoiceRefId is not null)
		and o.status =2
) as PhanBo
,
(select sum(od.amount)
from invoice o 
join invoicedetail od on o.invoiceId = od.InvoiceId
	where 1=1
		and businesscode in ('206')
		and ord.orderId = o.OrderId
		--and o.invoiceId not in (select invoiceRefId from invoice where invoiceRefId is not null)
		and o.status =2
) as DaTru
into #tblTemp
from [order] ord
join customer c on ord.customerId = c.customerId
where ord.orderStatus=7

select * from #tblTemp where Phanbo <> DaTru
drop table #tblTemp


begin
tran

update od
set od.amount=t.PhanBo

--select o.BusinessCode, o.OrderId, od.Amount, t.*
from invoicedetail od
join invoice o on o.invoiceId = od.InvoiceId
join #tblTemp t on o.OrderId= t.OrderId
where 1=1
		--and o.OrderId=297
		and o.businesscode in ('206')
		and o.status =2
		and t.Phanbo <> t.DaTru

--commit
------------------------------------------------------------------------------------------------------------------------


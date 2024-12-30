/* Finding all invoices from customers in my home state vs out of state, and that were greater than the average invoice */ 

/* 
Selecting columns from Invoices and Customers tables 
*/
SELECT 
i.invoicedate, i.billingstate, i.total,
    UPPER(c.firstname) || ' ' || UPPER(c.lastname) as 'Full Name',
    
/* 
Adding a CASE where any invoice in CA is an "in state" sale
*/ 
CASE
WHEN i.billingstate = 'CA' then 'In State' 
    ELSE 'Out-of-State'
    END AS 'In State vs Out-of-State' 

from 
invoices as i 

/* 
Linking in the customers table to bring in full name 
*/ 
LEFT JOIN 
customers as c 
ON 
i.customerid = c.customerid 

/* 
Filtering down to total invoice greater than the average invoice value 
*/ 
WHERE 
i.total > (select avg(total) from invoices) 

ORDER BY 
i.total DESC 

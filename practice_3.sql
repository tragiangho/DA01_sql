--ex1
--ex2
select user_id,
concat(upper(left(name,1)), lower(substring(name from 2 for length(name)-1))) as name
from Users
order by user_id

Create Table blaban_train_cleaning
like blaban_train;


Insert into blaban_train_cleaning
Select * from blaban_train;

select * from blaban_train_cleaning;

describe blaban_train_cleaning;

select * from blaban_train_cleaning
where Quantity=-5;


-- total_sales = Unit_Price * Quantity * (1 - Discount_Rate) + Tax_Amount

select Tax_Amount from blaban_train_cleaning
where Tax_Amount is null;

-- quantity = (Total_Sales - Tax_Amount) / (Unit_Price * (1 - Discount_Rate))

UPDATE blaban_train_cleaning
SET Quantity = ROUND(
    (Total_Sales - Tax_Amount) / (Unit_Price * (1 - Discount_Rate))
)
WHERE Quantity = -5;

Select Quantity from blaban_train_cleaning;

-- customer age
Select * from blaban_train_cleaning
where Customer_Age is null or Customer_Age = '' or Customer_Age = 'None' or Customer_Age = 280; 

Update blaban_train_cleaning
Set Customer_Age = null
where Customer_Age is null or Customer_Age = '' or Customer_Age = 'None';


Update blaban_train_cleaning
Set Customer_Age = "Unknown"
where Customer_Age is null or Customer_Age = '' or Customer_Age = 'None';



-- topping type

Select * from blaban_train_cleaning
where Topping_Type is null or Topping_Type = '' or Topping_Type = 'None'; 

Update blaban_train_cleaning
Set Topping_type = null
where Topping_Type is null or Topping_Type = '' or Topping_Type = 'None'; 

Update blaban_train_cleaning
Set Topping_type = 'No Topping'
where Topping_Type is null; 


-- Customer gender
Select * from blaban_train_cleaning
where Customer_Gender is null or Customer_Gender = '' or Customer_Gender = 'None'; 


Update blaban_train_cleaning
set Customer_Gender = null
where Customer_Gender is null or Customer_Gender = '' or Customer_Gender = 'None'; 

Update blaban_train_cleaning
set Customer_Gender = 'Unknown'
where Customer_Gender is null; 

-- membership status

Select * from blaban_train_cleaning
where Membership_Status is null or Membership_Status = '' or Membership_Status = 'None'; 

Update blaban_train_cleaning
Set Membership_Status = null
where Membership_Status is null or Membership_Status = '' or Membership_Status = 'None'; 


Update blaban_train_cleaning
Set Membership_Status = 'No Membership'
where Membership_Status is null; 

-- public holiday 

Alter table blaban_train_cleaning
Modify Is_Public_Holiday varchar(25);

Select * from blaban_train_cleaning
where Is_Public_Holiday = '0';

Update blaban_train_cleaning
Set Is_Public_Holiday = 'Not Holiday'
where Is_Public_Holiday = '0' or  Is_Public_Holiday is null;

Update blaban_train_cleaning
Set Is_Public_Holiday = 'Holiday'
where Is_Public_Holiday = '1';

-- store rating
Alter table blaban_train_cleaning
Modify Store_Rating Double;

Update blaban_train_cleaning
set Store_rating = null
where Store_rating is null or Store_Rating = '' or Store_Rating = 'No Rating';

Update blaban_train_cleaning
set Store_rating = 'No Rating'
where Store_rating is null or Store_Rating = '' or Store_Rating = 'None';

Select * from blaban_train_cleaning
where Region is null or Region = '' or Region = 'None';


-- is weekend
Select Is_Weekend from blaban_train_cleaning
where Is_Weekend is null or Is_Weekend = '';

Alter table blaban_train_cleaning
Modify Is_Weekend text;

Update blaban_train_cleaning
set Is_Weekend = 'not weekend'
where Is_Weekend = '0';
 
 
Update blaban_train_cleaning
set Is_Weekend = 'Weekend'
where Is_Weekend = '1';

select * from blaban_train_cleaning;

Alter Table blaban_train_cleaning
Modify Date_Time datetime;


-- customer age outlier:

Select count(customer_age) from blaban_train_cleaning
where Customer_Age = 280; 

SET @median_age = (
    SELECT AVG(customer_age)
    FROM (
        SELECT customer_age,
               ROW_NUMBER() OVER (ORDER BY customer_age) AS row_num,
               COUNT(*) OVER () AS total_rows
        FROM blaban_train_cleaning
        WHERE customer_age <> 280
    ) AS ranked
    WHERE row_num IN (
        FLOOR((total_rows + 1) / 2),
        FLOOR((total_rows + 2) / 2)
    )
);

UPDATE blaban_train_cleaning
SET customer_age = @median_age
WHERE customer_age = 280 or Customer_age is null;

-- unit price outlier

Select * from blaban_train_cleaning
where Transaction_ID = 105181
;

Update blaban_train_cleaning
set Unit_Price = (Total_Sales - Tax_Amount) / (Quantity * (1 - Discount_Rate))
where Unit_Price = 9999.99;

select * from blaban_train_cleaning
where Customer_Age is null;

Update blaban_train_cleaning
Set Customer_Age = 44
Where Customer_Age is null;

Alter table blaban_train_cleaning
Modify Customer_Age INT;

Alter table blaban_train_cleaning
Modify Transaction_ID Text;

Alter table blaban_train_cleaning
Modify Customer_ID Text;

Alter table blaban_train_cleaning
Add Column Net_price Decimal(10,2);

Update blaban_train_cleaning
Set Net_price = Round((Total_Sales - Tax_Amount) * (1 - Discount_Rate),2);

Alter table blaban_train_cleaning
Add column Month_name Varchar(20);

UPDATE blaban_train_cleaning
SET Month_name = MONTHNAME(Date_Time);

Select count(Transaction_ID) from blaban_train_cleaning;

Select * from blaban_train_cleaning;


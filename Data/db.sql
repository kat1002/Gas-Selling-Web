USE [master];
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'blazo_db')
BEGIN
    ALTER DATABASE [blazo_db] SET OFFLINE WITH ROLLBACK IMMEDIATE;
    ALTER DATABASE [blazo_db] SET ONLINE;
    DROP DATABASE [blazo_db];
END
GO

CREATE DATABASE [blazo_db];
GO

USE [blazo_db];
GO

CREATE TABLE customer (
    customer_id INT PRIMARY KEY IDENTITY,
    customer_type INT,
	receiveNotif int,
	customer_img NVARCHAR(max),
    username NVARCHAR(255),
    [password] NVARCHAR(255),
    first_name NVARCHAR(255),
    last_name NVARCHAR(255),
    phone_number NVARCHAR(255),
    gmail NVARCHAR(255),
    receive_sms BIT,
    receive_email BIT,
    address_line1 NVARCHAR(255),
    address_line2 NVARCHAR(255),
    postal_code NVARCHAR(255),
    city NVARCHAR(255)
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY IDENTITY,
    customer_id INT
);

CREATE TABLE inventory_item (
    item_id INT PRIMARY KEY IDENTITY,
    inventory_id INT,
    voucher_id INT,
    amount INT
);

CREATE TABLE manager (
    manager_id INT PRIMARY KEY IDENTITY,
    role_id INT,
    username NVARCHAR(255),
    [password] NVARCHAR(255),
    email NVARCHAR(255),
    phone_number NVARCHAR(255),
    first_name NVARCHAR(255),
    last_name NVARCHAR(255)
);

CREATE TABLE [role] (
    role_id INT PRIMARY KEY IDENTITY,
    title NVARCHAR(255)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY IDENTITY,
    category_id INT,
    discount_id INT,
    reviews_rate INT,
    title NVARCHAR(255),
    description NVARCHAR(MAX),
    stock INT,
    price FLOAT,
    created_date DATE,
    modified_on DATE,
    created_by INT,
    modified_by INT,
	warranty_months INT
);

CREATE TABLE rate (
    rate_id INT PRIMARY KEY IDENTITY,
    customer_id INT,
    product_id INT,
    rate INT,
	comment NVARCHAR(MAX),
	created_on DATETIME,
	modified_on DATETIME
);

CREATE TABLE category (
    category_id INT PRIMARY KEY IDENTITY,
    title NVARCHAR(255),
    description NVARCHAR(max),
    role INT,
    created_date DATE,
    modified_on DATE,
    created_by INT,
    modified_by INT
);

CREATE TABLE [order] (
    order_id INT PRIMARY KEY IDENTITY,
    customer_id INT,
    voucher_id INT,
    total_price FLOAT,
    order_date DATE,
    payment_method INT,
    address_line1 NVARCHAR(255),
    address_line2 NVARCHAR(255),
    postal_code NVARCHAR(255),
    city NVARCHAR(255),
    phone_number NVARCHAR(255),
    created_at DATE,
	[status] tinyint
);

CREATE TABLE order_item (
    order_item_id INT PRIMARY KEY IDENTITY,
    order_id INT,
    product_id INT,
    quantity INT,
    price FLOAT
);

CREATE TABLE discount (
    discount_id INT PRIMARY KEY IDENTITY,
    product_id INT,
    title NVARCHAR(255),
    description NVARCHAR(MAX),
    discount_value FLOAT,
    created_by INT,
    modified_by INT,
    created_at DATE,
    modified_at DATE,
	expiry datetime,
	[status] bit
);

CREATE TABLE voucher (
    voucher_id INT PRIMARY KEY IDENTITY,
    voucher_code NVARCHAR(MAX),
    title NVARCHAR(MAX),
    description NVARCHAR(MAX),
	discount_type INT,
    discount_value FLOAT,
    condition float,
    quantity INT,
    created_by INT,
    modified_by INT,
    created_at DATE,
    modified_on DATE,
	expiry DATE,
	[status] BIT
);

CREATE TABLE product_image (
    image_id INT PRIMARY KEY IDENTITY,
    product_id INT,
    url NVARCHAR(255)
);


CREATE TABLE news (
    news_id INT PRIMARY KEY IDENTITY,
    banner_state INT,
	theme_image NVARCHAR(MAX),
	news_category NVARCHAR(255),
	short_description NVARCHAR(MAX),
    title NVARCHAR(255),
    body NVARCHAR(MAX),
    created_at DATE,
    modified_on DATE,
    created_by INT,
    modified_by INT
);

CREATE TABLE cart (
    cart_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    total FLOAT
);

CREATE TABLE cart_item (
    item_id INT PRIMARY KEY IDENTITY,
    cart_id INT,
    product_id INT,
    quantity INT
);

CREATE TABLE product_serialnumber (
    serialNumber_id INT PRIMARY KEY IDENTITY,
	order_item_id INT,
	product_id int,
    service_tag NVARCHAR(MAX),
);
GO

CREATE TABLE warranty (
	warranty_id INT PRIMARY KEY IDENTITY,
    serialNumber_id int,
	manager_id int,
	warranty_type int,
	guarantee_date DATE,
	[status] NVARCHAR(255),
	isDone BIT,
	warranty_image NVARCHAR(MAX),
	created_by INT,
    modified_by INT,
    created_at DATE,
    modified_at DATE,
);
GO

-- Foreign Key Constraints
ALTER TABLE product_serialnumber
ADD CONSTRAINT FK_product_serialnumber_order_item FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id);

ALTER TABLE inventory
ADD CONSTRAINT FK_inventory_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE manager
ADD CONSTRAINT FK_manager_role FOREIGN KEY (role_id) REFERENCES [role](role_id);

ALTER TABLE inventory_item
ADD CONSTRAINT FK_inventory_item_inventory FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    CONSTRAINT FK_inventory_item_voucher FOREIGN KEY (voucher_id) REFERENCES voucher(voucher_id);

ALTER TABLE product
ADD CONSTRAINT FK_product_category FOREIGN KEY (category_id) REFERENCES category(category_id),
    CONSTRAINT FK_product_discount FOREIGN KEY (discount_id) REFERENCES discount(discount_id),
    CONSTRAINT FK_product_created_by FOREIGN KEY (created_by) REFERENCES manager(manager_id),
    CONSTRAINT FK_product_modified_by FOREIGN KEY (modified_by) REFERENCES manager(manager_id);

ALTER TABLE [order]
ADD CONSTRAINT FK_order_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT FK_order_voucher FOREIGN KEY (voucher_id) REFERENCES voucher(voucher_id);

ALTER TABLE order_item
ADD CONSTRAINT FK_order_item_order FOREIGN KEY (order_id) REFERENCES [order](order_id),
    CONSTRAINT FK_order_item_product FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE rate
ADD CONSTRAINT FK_rate_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT FK_rate_product FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE discount
ADD CONSTRAINT FK_discount_product FOREIGN KEY (product_id) REFERENCES product(product_id),
    CONSTRAINT FK_discount_created_by FOREIGN KEY (created_by) REFERENCES manager(manager_id),
    CONSTRAINT FK_discount_modified_by FOREIGN KEY (modified_by) REFERENCES manager(manager_id);

ALTER TABLE voucher
ADD CONSTRAINT FK_voucher_created_by FOREIGN KEY (created_by) REFERENCES manager(manager_id),
    CONSTRAINT FK_voucher_modified_by FOREIGN KEY (modified_by) REFERENCES manager(manager_id);

ALTER TABLE product_image
ADD CONSTRAINT FK_product_image_product FOREIGN KEY (product_id) REFERENCES product(product_id);

ALTER TABLE news
ADD CONSTRAINT FK_news_created_by FOREIGN KEY (created_by) REFERENCES manager(manager_id),
    CONSTRAINT FK_news_modified_by FOREIGN KEY (modified_by) REFERENCES manager(manager_id);

ALTER TABLE cart
ADD CONSTRAINT FK_cart_user FOREIGN KEY (user_id) REFERENCES customer(customer_id);

ALTER TABLE cart_item
ADD CONSTRAINT FK_cart_item_cart FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    CONSTRAINT FK_cart_item_product FOREIGN KEY (product_id) REFERENCES product(product_id);


ALTER TABLE warranty
ADD CONSTRAINT FK_warranty_serialNumber FOREIGN KEY (serialNumber_id) REFERENCES product_serialnumber(serialNumber_id),
    CONSTRAINT FK_warranty_manager FOREIGN KEY (manager_id) REFERENCES manager(manager_id);

GO
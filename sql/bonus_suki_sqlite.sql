-- bonus_suki.db : SQLite version ของ bonus_suki_create_tables.sql (15 ตารางตามรูปเล่ม + 3 ตารางเสริมของแอป)
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS Member (
    Member_ID            VARCHAR(10)    NOT NULL,  -- รหัสสมาชิก
    Member_Name          VARCHAR(100)   NOT NULL,  -- ชื่อ-นามสกุลสมาชิก
    Member_PhoneNo       CHAR(10)       NOT NULL,  -- เบอร์โทรศัพท์สมาชิก (ห้ามซ้ำ)
    Member_Address       VARCHAR(255)   NULL,  -- ที่อยู่สมาชิก
    Point_Balance        INT            NOT NULL,  -- คะแนนสะสม
    CONSTRAINT pk_Member PRIMARY KEY (Member_ID),
    CONSTRAINT uq_Member_Member_PhoneNo UNIQUE (Member_PhoneNo)
);

CREATE TABLE IF NOT EXISTS Dining_Table (
    Table_ID             VARCHAR(10)    NOT NULL,  -- รหัสโต๊ะ
    Table_Name           VARCHAR(30)    NOT NULL,  -- หมายเลขโต๊ะ
    Table_Zone           VARCHAR(30)    NULL,  -- โซนที่ตั้งของโต๊ะ
    Table_Size           INT            NOT NULL,  -- ขนาดโต๊ะ (จำนวนที่นั่งสูงสุด)
    Table_Status         VARCHAR(20)    NOT NULL,  -- สถานะโต๊ะ (ว่าง / กำลังใช้งาน / รอเช็คบิล)
    CONSTRAINT pk_Dining_Table PRIMARY KEY (Table_ID)
);

CREATE TABLE IF NOT EXISTS Promotion (
    Promotion_ID         VARCHAR(10)    NOT NULL,  -- รหัสโปรโมชั่น
    End_Date             DATE           NOT NULL,  -- วันที่สิ้นสุดโปรโมชั่น
    Start_Date           DATE           NOT NULL,  -- วันที่เริ่มโปรโมชั่น
    Pro_Name             VARCHAR(100)   NOT NULL,  -- ชื่อโปรโมชั่น
    Detail               VARCHAR(255)   NULL,  -- รายละเอียดและเงื่อนไขโปรโมชั่น
    Number_People        INT            NOT NULL,  -- จำนวนคนตามเงื่อนไขโปรโมชั่น
    CONSTRAINT pk_Promotion PRIMARY KEY (Promotion_ID)
);

CREATE TABLE IF NOT EXISTS Product (
    Product_ID           VARCHAR(10)    NOT NULL,  -- รหัสสินค้า
    Product_Name         VARCHAR(100)   NOT NULL,  -- ชื่อสินค้า
    Amount               DECIMAL(10,2)  NOT NULL,  -- ราคาขายต่อหน่วย (บาท)
    Product_Type         VARCHAR(50)    NOT NULL,  -- ประเภทสินค้า (เช่น เมนูอาหาร, น้ำซุป, แพ็กเกจ)
    CONSTRAINT pk_Product PRIMARY KEY (Product_ID)
);

CREATE TABLE IF NOT EXISTS Stock_Item (
    Stock_Item_ID        VARCHAR(10)    NOT NULL,  -- รหัสวัตถุดิบ
    Unit                 VARCHAR(20)    NOT NULL,  -- หน่วยนับของวัตถุดิบ (เช่น กก., แพ็ค)
    Item_Name            VARCHAR(100)   NOT NULL,  -- ชื่อวัตถุดิบ
    Category             VARCHAR(50)    NULL,  -- หมวดหมู่วัตถุดิบ
    Current_Stock        DECIMAL(10,3)  NOT NULL,  -- จำนวนวัตถุดิบคงเหลือในคลัง
    Reorder_Point        DECIMAL(10,3)  NOT NULL,  -- ระดับสินค้าคงเหลือที่ต้องเริ่มสั่งซื้อใหม่
    CONSTRAINT pk_Stock_Item PRIMARY KEY (Stock_Item_ID)
);

CREATE TABLE IF NOT EXISTS Vendor (
    Vendor_ID            VARCHAR(10)    NOT NULL,  -- รหัสผู้จัดจำหน่าย
    Vendor_Name          VARCHAR(100)   NOT NULL,  -- ชื่อผู้จัดจำหน่าย
    Address              VARCHAR(255)   NULL,  -- ที่อยู่ผู้จัดจำหน่าย
    PhoneNo              VARCHAR(10)    NULL,  -- เบอร์โทรศัพท์ผู้จัดจำหน่าย
    CONSTRAINT pk_Vendor PRIMARY KEY (Vendor_ID)
);

CREATE TABLE IF NOT EXISTS Employee (
    Emp_ID               VARCHAR(10)    NOT NULL,  -- รหัสพนักงาน
    Emp_Type             VARCHAR(10)    NOT NULL,  -- ประเภทพนักงาน (Full-time / Part-time)
    Emp_Address          VARCHAR(255)   NULL,  -- ที่อยู่พนักงาน
    Emp_Name             VARCHAR(100)   NOT NULL,  -- ชื่อ-นามสกุลพนักงาน
    Emp_PhoneNo          CHAR(10)       NOT NULL,  -- เบอร์โทรศัพท์พนักงาน
    Salary_Base          DECIMAL(10,2)  NOT NULL,  -- ฐานเงินเดือนพนักงาน
    CONSTRAINT pk_Employee PRIMARY KEY (Emp_ID)
);

CREATE TABLE IF NOT EXISTS Lot_Detail (
    Lot_Number           VARCHAR(20)    NOT NULL,  -- หมายเลขล็อตสินค้า
    Exp_Date             DATE           NOT NULL,  -- วันหมดอายุของล็อตนั้น
    CONSTRAINT pk_Lot_Detail PRIMARY KEY (Lot_Number)
);

CREATE TABLE IF NOT EXISTS Payroll (
    Payroll_ID           VARCHAR(10)    NOT NULL,  -- รหัสรายการจ่ายเงินเดือน
    Pay_Date             DATE           NOT NULL,  -- วันที่จ่ายเงินเดือน
    OT                   DECIMAL(10,2)  NOT NULL,  -- ค่าล่วงเวลา
    Deduction            DECIMAL(10,2)  NOT NULL,  -- ยอดหักเงิน (ประกันสังคม ขาด ลา สาย)
    Total_Amount         DECIMAL(10,2)  NOT NULL,  -- ยอดเงินจ่ายสุทธิ (Net Pay)
    Emp_ID               VARCHAR(10)    NOT NULL,  -- รหัสพนักงานที่ได้รับเงินเดือน
    CONSTRAINT pk_Payroll PRIMARY KEY (Payroll_ID),
    CONSTRAINT fk_Payroll_Emp_ID FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID)
);

CREATE TABLE IF NOT EXISTS Bill (
    Order_ID             VARCHAR(10)    NOT NULL,  -- รหัสบิล
    Total_Price          DECIMAL(10,2)  NOT NULL,  -- ราคารวมก่อนหักส่วนลด
    Discount_Amount      DECIMAL(10,2)  NOT NULL,  -- ส่วนลดรวมของบิล
    Received_Amount      DECIMAL(10,2)  NULL,  -- จำนวนเงินที่รับจากลูกค้า
    Payment_Date         DATE           NULL,  -- วันที่ชำระเงิน
    Payment_Type         VARCHAR(20)    NULL,  -- ประเภทการชำระเงิน (เงินสด / QR Code)
    Of_Date              DATE           NOT NULL,  -- วันที่ใช้บริการโต๊ะ
    Start_Time           TIME           NOT NULL,  -- เวลาเริ่มใช้โต๊ะ
    End_Time             TIME           NULL,  -- เวลาสิ้นสุดการใช้โต๊ะ
    Amount_Member        INT            NOT NULL,  -- จำนวนผู้เข้าใช้บริการ
    Promo_DateTime       DATETIME       NULL,  -- วัน-เวลาที่ใช้โปรโมชั่นกับบิล
    Promo_Amount_Member  INT            NULL,  -- จำนวนคนที่ใช้สิทธิ์โปรโมชั่น
    Member_ID            VARCHAR(10)    NULL,  -- รหัสสมาชิกเจ้าของบิล (ค่าว่างได้ถ้าไม่ใช่สมาชิก)
    Table_ID             VARCHAR(10)    NOT NULL,  -- รหัสโต๊ะที่ใช้บริการ
    Promotion_ID         VARCHAR(10)    NULL,  -- รหัสโปรโมชั่นที่ใช้ (ค่าว่างได้)
    CONSTRAINT pk_Bill PRIMARY KEY (Order_ID),
    CONSTRAINT fk_Bill_Member_ID FOREIGN KEY (Member_ID) REFERENCES Member (Member_ID),
    CONSTRAINT fk_Bill_Table_ID FOREIGN KEY (Table_ID) REFERENCES Dining_Table (Table_ID),
    CONSTRAINT fk_Bill_Promotion_ID FOREIGN KEY (Promotion_ID) REFERENCES Promotion (Promotion_ID)
);

CREATE TABLE IF NOT EXISTS Work_Time (
    Work_Date            DATE           NOT NULL,  -- วันที่ทำงาน
    Emp_ID               VARCHAR(10)    NOT NULL,  -- รหัสพนักงานเจ้าของเวลาทำงาน
    Entry_Time           TIME           NOT NULL,  -- เวลาเข้างาน
    End_Time             TIME           NULL,  -- เวลาออกงาน
    Incentive_Amount     DECIMAL(10,2)  NULL,  -- เบี้ยขยัน
    Payroll_ID           VARCHAR(10)    NULL,  -- รหัสรายการจ่ายเงินเดือนที่รวมวันทำงานนี้
    CONSTRAINT pk_Work_Time PRIMARY KEY (Work_Date, Emp_ID),
    CONSTRAINT fk_Work_Time_Emp_ID FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID),
    CONSTRAINT fk_Work_Time_Payroll_ID FOREIGN KEY (Payroll_ID) REFERENCES Payroll (Payroll_ID)
);

CREATE TABLE IF NOT EXISTS Expense (
    Expense_ID           VARCHAR(10)    NOT NULL,  -- รหัสค่าใช้จ่าย
    Expense_Date         DATE           NOT NULL,  -- วันที่เกิดค่าใช้จ่าย
    Receipt_Image        VARCHAR(255)   NULL,  -- ตำแหน่งไฟล์รูปใบเสร็จ (path/URL)
    Expense_Type         VARCHAR(30)    NOT NULL,  -- ประเภทค่าใช้จ่าย (คงที่/ผันแปร)
    Expense_Amount       DECIMAL(10,2)  NOT NULL,  -- จำนวนเงินค่าใช้จ่าย
    Expense_Category     VARCHAR(50)    NOT NULL,  -- หมวดหมู่ค่าใช้จ่าย (ค่าน้ำ-ไฟ, ค่าเช่า ฯลฯ)
    Description          VARCHAR(255)   NULL,  -- รายละเอียดเพิ่มเติม
    Emp_ID               VARCHAR(10)    NOT NULL,  -- รหัสพนักงานที่บันทึกค่าใช้จ่าย
    CONSTRAINT pk_Expense PRIMARY KEY (Expense_ID),
    CONSTRAINT fk_Expense_Emp_ID FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID)
);

CREATE TABLE IF NOT EXISTS Bill_Product (
    Order_ID             VARCHAR(10)    NOT NULL,  -- รหัสบิล
    Product_ID           VARCHAR(10)    NOT NULL,  -- รหัสสินค้าที่สั่ง
    Use_DateTime         DATETIME       NOT NULL,  -- วัน-เวลาที่สั่งสินค้า
    Unit                 INT            NOT NULL,  -- จำนวนหน่วยที่สั่ง (จาน, ถ้วย, หม้อ)
    CONSTRAINT pk_Bill_Product PRIMARY KEY (Order_ID, Product_ID),
    CONSTRAINT fk_Bill_Product_Order_ID FOREIGN KEY (Order_ID) REFERENCES Bill (Order_ID),
    CONSTRAINT fk_Bill_Product_Product_ID FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID)
);

CREATE TABLE IF NOT EXISTS BOM (
    Product_ID           VARCHAR(10)    NOT NULL,  -- รหัสสินค้า
    Stock_Item_ID        VARCHAR(10)    NOT NULL,  -- รหัสวัตถุดิบ
    Quantity             DECIMAL(10,3)  NOT NULL,  -- ปริมาณวัตถุดิบที่ใช้ต่อสินค้า 1 หน่วย
    CONSTRAINT pk_BOM PRIMARY KEY (Product_ID, Stock_Item_ID),
    CONSTRAINT fk_BOM_Product_ID FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID),
    CONSTRAINT fk_BOM_Stock_Item_ID FOREIGN KEY (Stock_Item_ID) REFERENCES Stock_Item (Stock_Item_ID)
);

CREATE TABLE IF NOT EXISTS Import (
    Stock_Item_ID        VARCHAR(10)    NOT NULL,  -- รหัสวัตถุดิบ
    Vendor_ID            VARCHAR(10)    NOT NULL,  -- รหัสผู้จัดจำหน่าย
    Emp_ID               VARCHAR(10)    NOT NULL,  -- รหัสพนักงานที่รับของเข้าคลัง
    Import_DateTime      DATETIME       NOT NULL,  -- วัน-เวลาที่รับของเข้าคลัง
    Number               DECIMAL(10,3)  NOT NULL,  -- จำนวนที่นำเข้า
    Cost_Price           DECIMAL(10,2)  NOT NULL,  -- ราคาต้นทุนต่อหน่วย
    Lot_Number           VARCHAR(20)    NOT NULL,  -- หมายเลขล็อตสินค้า
    CONSTRAINT pk_Import PRIMARY KEY (Stock_Item_ID, Vendor_ID, Emp_ID),
    CONSTRAINT fk_Import_Stock_Item_ID FOREIGN KEY (Stock_Item_ID) REFERENCES Stock_Item (Stock_Item_ID),
    CONSTRAINT fk_Import_Vendor_ID FOREIGN KEY (Vendor_ID) REFERENCES Vendor (Vendor_ID),
    CONSTRAINT fk_Import_Emp_ID FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID),
    CONSTRAINT fk_Import_Lot_Number FOREIGN KEY (Lot_Number) REFERENCES Lot_Detail (Lot_Number)
);

-- ===== ตารางเสริมของแอป (ไม่มีในรูปเล่ม DB ต้องแจ้งทีมก่อนใช้) =====
CREATE TABLE IF NOT EXISTS User_Account (
    User_ID              VARCHAR(10)    NOT NULL,  -- รหัสบัญชีผู้ใช้ เช่น U001
    Username             VARCHAR(30)    NOT NULL,  -- ชื่อล็อกอิน (ห้ามซ้ำ)
    Password             VARCHAR(100)   NOT NULL,  -- รหัสผ่าน
    Role                 VARCHAR(20)    NOT NULL,  -- ผู้จัดการ / พนักงาน
    Emp_ID               VARCHAR(10)    NOT NULL,  -- พนักงานเจ้าของบัญชี
    CONSTRAINT pk_User_Account PRIMARY KEY (User_ID),
    CONSTRAINT uq_User_Account_Username UNIQUE (Username),
    CONSTRAINT uq_User_Account_Emp_ID UNIQUE (Emp_ID),
    CONSTRAINT ck_User_Account_Role CHECK (Role IN ('ผู้จัดการ', 'พนักงาน')),
    CONSTRAINT fk_User_Account_Emp_ID FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID)
);

CREATE TABLE IF NOT EXISTS Check_Stock (
    Check_ID             VARCHAR(10)    NOT NULL,  -- รหัสรอบตรวจนับ เช่น C001
    Check_DateTime       DATETIME       NOT NULL,  -- วัน-เวลาที่ตรวจนับ
    Emp_ID               VARCHAR(10)    NOT NULL,  -- พนักงานที่ตรวจนับ
    CONSTRAINT pk_Check_Stock PRIMARY KEY (Check_ID),
    CONSTRAINT fk_Check_Stock_Emp_ID FOREIGN KEY (Emp_ID) REFERENCES Employee (Emp_ID)
);

CREATE TABLE IF NOT EXISTS Check_Stock_Detail (
    Check_ID             VARCHAR(10)    NOT NULL,  -- รอบตรวจนับ
    Stock_Item_ID        VARCHAR(10)    NOT NULL,  -- วัตถุดิบที่นับ
    System_Qty           DECIMAL(10,3)  NOT NULL,  -- จำนวนในระบบก่อนนับ (Current_Stock ตอนนั้น)
    Counted_Qty          DECIMAL(10,3)  NOT NULL,  -- จำนวนที่นับได้จริง
    CONSTRAINT pk_Check_Stock_Detail PRIMARY KEY (Check_ID, Stock_Item_ID),
    CONSTRAINT fk_Check_Stock_Detail_Check_ID FOREIGN KEY (Check_ID) REFERENCES Check_Stock (Check_ID),
    CONSTRAINT fk_Check_Stock_Detail_Stock_Item_ID FOREIGN KEY (Stock_Item_ID) REFERENCES Stock_Item (Stock_Item_ID)
);

-- บัญชีทดสอบ (รหัสผ่านตัวอย่างสำหรับฝึก เปลี่ยนก่อนส่งงาน)
INSERT OR IGNORE INTO User_Account (User_ID, Username, Password, Role, Emp_ID) VALUES
    ('U001', 'manager', '1234', 'ผู้จัดการ', 'E001'),
    ('U002', 'staff',   '1234', 'พนักงาน',  'E002');


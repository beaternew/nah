-- ============================================================
-- Bonus Suki database : CREATE TABLE (MySQL / MariaDB)
-- Data Type ตาม Data Dictionary หัวข้อ 10 ในรูปเล่ม (15 ตาราง)
-- ============================================================

CREATE DATABASE IF NOT EXISTS bonus_suki CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bonus_suki;

CREATE TABLE `Member` (
    `Member_ID`            VARCHAR(10)    NOT NULL COMMENT 'รหัสสมาชิก',
    `Member_Name`          VARCHAR(100)   NOT NULL COMMENT 'ชื่อ-นามสกุลสมาชิก',
    `Member_PhoneNo`       CHAR(10)       NOT NULL COMMENT 'เบอร์โทรศัพท์สมาชิก (ห้ามซ้ำ)',
    `Member_Address`       VARCHAR(255)   NULL     COMMENT 'ที่อยู่สมาชิก',
    `Point_Balance`        INT            NOT NULL COMMENT 'คะแนนสะสม',
    CONSTRAINT `pk_Member` PRIMARY KEY (`Member_ID`),
    CONSTRAINT `uq_Member_Member_PhoneNo` UNIQUE (`Member_PhoneNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Dining_Table` (
    `Table_ID`             VARCHAR(10)    NOT NULL COMMENT 'รหัสโต๊ะ',
    `Table_Name`           VARCHAR(30)    NOT NULL COMMENT 'หมายเลขโต๊ะ',
    `Table_Zone`           VARCHAR(30)    NULL     COMMENT 'โซนที่ตั้งของโต๊ะ',
    `Table_Size`           INT            NOT NULL COMMENT 'ขนาดโต๊ะ (จำนวนที่นั่งสูงสุด)',
    `Table_Status`         VARCHAR(20)    NOT NULL COMMENT 'สถานะโต๊ะ (ว่าง / กำลังใช้งาน / รอเช็คบิล)',
    CONSTRAINT `pk_Dining_Table` PRIMARY KEY (`Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Promotion` (
    `Promotion_ID`         VARCHAR(10)    NOT NULL COMMENT 'รหัสโปรโมชั่น',
    `End_Date`             DATE           NOT NULL COMMENT 'วันที่สิ้นสุดโปรโมชั่น',
    `Start_Date`           DATE           NOT NULL COMMENT 'วันที่เริ่มโปรโมชั่น',
    `Pro_Name`             VARCHAR(100)   NOT NULL COMMENT 'ชื่อโปรโมชั่น',
    `Detail`               VARCHAR(255)   NULL     COMMENT 'รายละเอียดและเงื่อนไขโปรโมชั่น',
    `Number_People`        INT            NOT NULL COMMENT 'จำนวนคนตามเงื่อนไขโปรโมชั่น',
    CONSTRAINT `pk_Promotion` PRIMARY KEY (`Promotion_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Product` (
    `Product_ID`           VARCHAR(10)    NOT NULL COMMENT 'รหัสสินค้า',
    `Product_Name`         VARCHAR(100)   NOT NULL COMMENT 'ชื่อสินค้า',
    `Amount`               DECIMAL(10,2)  NOT NULL COMMENT 'ราคาขายต่อหน่วย (บาท)',
    `Product_Type`         VARCHAR(50)    NOT NULL COMMENT 'ประเภทสินค้า (เช่น เมนูอาหาร, น้ำซุป, แพ็กเกจ)',
    CONSTRAINT `pk_Product` PRIMARY KEY (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Stock_Item` (
    `Stock_Item_ID`        VARCHAR(10)    NOT NULL COMMENT 'รหัสวัตถุดิบ',
    `Unit`                 VARCHAR(20)    NOT NULL COMMENT 'หน่วยนับของวัตถุดิบ (เช่น กก., แพ็ค)',
    `Item_Name`            VARCHAR(100)   NOT NULL COMMENT 'ชื่อวัตถุดิบ',
    `Category`             VARCHAR(50)    NULL     COMMENT 'หมวดหมู่วัตถุดิบ',
    `Current_Stock`        DECIMAL(10,3)  NOT NULL COMMENT 'จำนวนวัตถุดิบคงเหลือในคลัง',
    `Reorder_Point`        DECIMAL(10,3)  NOT NULL COMMENT 'ระดับสินค้าคงเหลือที่ต้องเริ่มสั่งซื้อใหม่',
    CONSTRAINT `pk_Stock_Item` PRIMARY KEY (`Stock_Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Vendor` (
    `Vendor_ID`            VARCHAR(10)    NOT NULL COMMENT 'รหัสผู้จัดจำหน่าย',
    `Vendor_Name`          VARCHAR(100)   NOT NULL COMMENT 'ชื่อผู้จัดจำหน่าย',
    `Address`              VARCHAR(255)   NULL     COMMENT 'ที่อยู่ผู้จัดจำหน่าย',
    `PhoneNo`              VARCHAR(10)    NULL     COMMENT 'เบอร์โทรศัพท์ผู้จัดจำหน่าย',
    CONSTRAINT `pk_Vendor` PRIMARY KEY (`Vendor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Employee` (
    `Emp_ID`               VARCHAR(10)    NOT NULL COMMENT 'รหัสพนักงาน',
    `Emp_Type`             VARCHAR(10)    NOT NULL COMMENT 'ประเภทพนักงาน (Full-time / Part-time)',
    `Emp_Address`          VARCHAR(255)   NULL     COMMENT 'ที่อยู่พนักงาน',
    `Emp_Name`             VARCHAR(100)   NOT NULL COMMENT 'ชื่อ-นามสกุลพนักงาน',
    `Emp_PhoneNo`          CHAR(10)       NOT NULL COMMENT 'เบอร์โทรศัพท์พนักงาน',
    `Salary_Base`          DECIMAL(10,2)  NOT NULL COMMENT 'ฐานเงินเดือนพนักงาน',
    CONSTRAINT `pk_Employee` PRIMARY KEY (`Emp_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Lot_Detail` (
    `Lot_Number`           VARCHAR(20)    NOT NULL COMMENT 'หมายเลขล็อตสินค้า',
    `Exp_Date`             DATE           NOT NULL COMMENT 'วันหมดอายุของล็อตนั้น',
    CONSTRAINT `pk_Lot_Detail` PRIMARY KEY (`Lot_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Payroll` (
    `Payroll_ID`           VARCHAR(10)    NOT NULL COMMENT 'รหัสรายการจ่ายเงินเดือน',
    `Pay_Date`             DATE           NOT NULL COMMENT 'วันที่จ่ายเงินเดือน',
    `OT`                   DECIMAL(10,2)  NOT NULL COMMENT 'ค่าล่วงเวลา',
    `Deduction`            DECIMAL(10,2)  NOT NULL COMMENT 'ยอดหักเงิน (ประกันสังคม ขาด ลา สาย)',
    `Total_Amount`         DECIMAL(10,2)  NOT NULL COMMENT 'ยอดเงินจ่ายสุทธิ (Net Pay)',
    `Emp_ID`               VARCHAR(10)    NOT NULL COMMENT 'รหัสพนักงานที่ได้รับเงินเดือน',
    CONSTRAINT `pk_Payroll` PRIMARY KEY (`Payroll_ID`),
    CONSTRAINT `fk_Payroll_Emp_ID` FOREIGN KEY (`Emp_ID`) REFERENCES `Employee` (`Emp_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Bill` (
    `Order_ID`             VARCHAR(10)    NOT NULL COMMENT 'รหัสบิล',
    `Total_Price`          DECIMAL(10,2)  NOT NULL COMMENT 'ราคารวมก่อนหักส่วนลด',
    `Discount_Amount`      DECIMAL(10,2)  NOT NULL COMMENT 'ส่วนลดรวมของบิล',
    `Received_Amount`      DECIMAL(10,2)  NULL     COMMENT 'จำนวนเงินที่รับจากลูกค้า',
    `Payment_Date`         DATE           NULL     COMMENT 'วันที่ชำระเงิน',
    `Payment_Type`         VARCHAR(20)    NULL     COMMENT 'ประเภทการชำระเงิน (เงินสด / QR Code)',
    `Of_Date`              DATE           NOT NULL COMMENT 'วันที่ใช้บริการโต๊ะ',
    `Start_Time`           TIME           NOT NULL COMMENT 'เวลาเริ่มใช้โต๊ะ',
    `End_Time`             TIME           NULL     COMMENT 'เวลาสิ้นสุดการใช้โต๊ะ',
    `Amount_Member`        INT            NOT NULL COMMENT 'จำนวนผู้เข้าใช้บริการ',
    `Promo_DateTime`       DATETIME       NULL     COMMENT 'วัน-เวลาที่ใช้โปรโมชั่นกับบิล',
    `Promo_Amount_Member`  INT            NULL     COMMENT 'จำนวนคนที่ใช้สิทธิ์โปรโมชั่น',
    `Member_ID`            VARCHAR(10)    NULL     COMMENT 'รหัสสมาชิกเจ้าของบิล (ค่าว่างได้ถ้าไม่ใช่สมาชิก)',
    `Table_ID`             VARCHAR(10)    NOT NULL COMMENT 'รหัสโต๊ะที่ใช้บริการ',
    `Promotion_ID`         VARCHAR(10)    NULL     COMMENT 'รหัสโปรโมชั่นที่ใช้ (ค่าว่างได้)',
    CONSTRAINT `pk_Bill` PRIMARY KEY (`Order_ID`),
    CONSTRAINT `fk_Bill_Member_ID` FOREIGN KEY (`Member_ID`) REFERENCES `Member` (`Member_ID`),
    CONSTRAINT `fk_Bill_Table_ID` FOREIGN KEY (`Table_ID`) REFERENCES `Dining_Table` (`Table_ID`),
    CONSTRAINT `fk_Bill_Promotion_ID` FOREIGN KEY (`Promotion_ID`) REFERENCES `Promotion` (`Promotion_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Work_Time` (
    `Work_Date`            DATE           NOT NULL COMMENT 'วันที่ทำงาน',
    `Emp_ID`               VARCHAR(10)    NOT NULL COMMENT 'รหัสพนักงานเจ้าของเวลาทำงาน',
    `Entry_Time`           TIME           NOT NULL COMMENT 'เวลาเข้างาน',
    `End_Time`             TIME           NULL     COMMENT 'เวลาออกงาน',
    `Incentive_Amount`     DECIMAL(10,2)  NULL     COMMENT 'เบี้ยขยัน',
    `Payroll_ID`           VARCHAR(10)    NULL     COMMENT 'รหัสรายการจ่ายเงินเดือนที่รวมวันทำงานนี้',
    CONSTRAINT `pk_Work_Time` PRIMARY KEY (`Work_Date`, `Emp_ID`),
    CONSTRAINT `fk_Work_Time_Emp_ID` FOREIGN KEY (`Emp_ID`) REFERENCES `Employee` (`Emp_ID`),
    CONSTRAINT `fk_Work_Time_Payroll_ID` FOREIGN KEY (`Payroll_ID`) REFERENCES `Payroll` (`Payroll_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Expense` (
    `Expense_ID`           VARCHAR(10)    NOT NULL COMMENT 'รหัสค่าใช้จ่าย',
    `Expense_Date`         DATE           NOT NULL COMMENT 'วันที่เกิดค่าใช้จ่าย',
    `Receipt_Image`        VARCHAR(255)   NULL     COMMENT 'ตำแหน่งไฟล์รูปใบเสร็จ (path/URL)',
    `Expense_Type`         VARCHAR(30)    NOT NULL COMMENT 'ประเภทค่าใช้จ่าย (คงที่/ผันแปร)',
    `Expense_Amount`       DECIMAL(10,2)  NOT NULL COMMENT 'จำนวนเงินค่าใช้จ่าย',
    `Expense_Category`     VARCHAR(50)    NOT NULL COMMENT 'หมวดหมู่ค่าใช้จ่าย (ค่าน้ำ-ไฟ, ค่าเช่า ฯลฯ)',
    `Description`          VARCHAR(255)   NULL     COMMENT 'รายละเอียดเพิ่มเติม',
    `Emp_ID`               VARCHAR(10)    NOT NULL COMMENT 'รหัสพนักงานที่บันทึกค่าใช้จ่าย',
    CONSTRAINT `pk_Expense` PRIMARY KEY (`Expense_ID`),
    CONSTRAINT `fk_Expense_Emp_ID` FOREIGN KEY (`Emp_ID`) REFERENCES `Employee` (`Emp_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Bill_Product` (
    `Order_ID`             VARCHAR(10)    NOT NULL COMMENT 'รหัสบิล',
    `Product_ID`           VARCHAR(10)    NOT NULL COMMENT 'รหัสสินค้าที่สั่ง',
    `Use_DateTime`         DATETIME       NOT NULL COMMENT 'วัน-เวลาที่สั่งสินค้า',
    `Unit`                 INT            NOT NULL COMMENT 'จำนวนหน่วยที่สั่ง (จาน, ถ้วย, หม้อ)',
    CONSTRAINT `pk_Bill_Product` PRIMARY KEY (`Order_ID`, `Product_ID`),
    CONSTRAINT `fk_Bill_Product_Order_ID` FOREIGN KEY (`Order_ID`) REFERENCES `Bill` (`Order_ID`),
    CONSTRAINT `fk_Bill_Product_Product_ID` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `BOM` (
    `Product_ID`           VARCHAR(10)    NOT NULL COMMENT 'รหัสสินค้า',
    `Stock_Item_ID`        VARCHAR(10)    NOT NULL COMMENT 'รหัสวัตถุดิบ',
    `Quantity`             DECIMAL(10,3)  NOT NULL COMMENT 'ปริมาณวัตถุดิบที่ใช้ต่อสินค้า 1 หน่วย',
    CONSTRAINT `pk_BOM` PRIMARY KEY (`Product_ID`, `Stock_Item_ID`),
    CONSTRAINT `fk_BOM_Product_ID` FOREIGN KEY (`Product_ID`) REFERENCES `Product` (`Product_ID`),
    CONSTRAINT `fk_BOM_Stock_Item_ID` FOREIGN KEY (`Stock_Item_ID`) REFERENCES `Stock_Item` (`Stock_Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Import` (
    `Stock_Item_ID`        VARCHAR(10)    NOT NULL COMMENT 'รหัสวัตถุดิบ',
    `Vendor_ID`            VARCHAR(10)    NOT NULL COMMENT 'รหัสผู้จัดจำหน่าย',
    `Emp_ID`               VARCHAR(10)    NOT NULL COMMENT 'รหัสพนักงานที่รับของเข้าคลัง',
    `Import_DateTime`      DATETIME       NOT NULL COMMENT 'วัน-เวลาที่รับของเข้าคลัง',
    `Number`               DECIMAL(10,3)  NOT NULL COMMENT 'จำนวนที่นำเข้า',
    `Cost_Price`           DECIMAL(10,2)  NOT NULL COMMENT 'ราคาต้นทุนต่อหน่วย',
    `Lot_Number`           VARCHAR(20)    NOT NULL COMMENT 'หมายเลขล็อตสินค้า',
    CONSTRAINT `pk_Import` PRIMARY KEY (`Stock_Item_ID`, `Vendor_ID`, `Emp_ID`),
    CONSTRAINT `fk_Import_Stock_Item_ID` FOREIGN KEY (`Stock_Item_ID`) REFERENCES `Stock_Item` (`Stock_Item_ID`),
    CONSTRAINT `fk_Import_Vendor_ID` FOREIGN KEY (`Vendor_ID`) REFERENCES `Vendor` (`Vendor_ID`),
    CONSTRAINT `fk_Import_Emp_ID` FOREIGN KEY (`Emp_ID`) REFERENCES `Employee` (`Emp_ID`),
    CONSTRAINT `fk_Import_Lot_Number` FOREIGN KEY (`Lot_Number`) REFERENCES `Lot_Detail` (`Lot_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LIBRARY MANAGEMENT SYSTEM - ADVANCED JAVA

Technology:
JSP + Servlet + JDBC + MySQL + Maven
Designed for NetBeans 8.2 / JDK 8 / GlassFish or another Servlet 4 compatible server.

SETUP:
1. Create/import this Maven project in NetBeans.
2. Start MySQL.
3. Open database.sql in MySQL Workbench/phpMyAdmin and run it.
4. Open:
   src/main/java/com/advancedjava/util/DBConnection.java
5. Change DB_USER and DB_PASSWORD if your MySQL credentials are different.
6. Clean and Build the project.
7. Run the project on GlassFish.
8. Open the application URL shown by NetBeans.

PROJECT FLOW:
JSP -> Servlet -> DAO -> JDBC -> MySQL
MySQL -> DAO -> Servlet -> JSP

FEATURES:
- Dashboard
- Add book
- Search book
- Edit book
- Delete book
- Available/Issued summary
- CSV export
- Print

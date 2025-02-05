<h2 align="center">
Oracle Command and Usage Documentation
</h2>


#### 📰 Oracle Installation

https://help.ubuntu.com/community/Oracle%20Instant%20Client

1. Go to tmp directory
```bash
cd /tmp
```

2. Download rpm file
```bash
sudo wget https://download.oracle.com/otn_software/linux/instantclient/1923000/oracle-instantclient19.23-basic-19.23.0.0.0-1.x86_64.rpm
```

3. Install alien package
```bash
sudo apt-get install alien
```

4. Install oracle-instantclient
```bash
sudo alien -i oracle-instantclient19.23-basic-19.23.0.0.0-1.x86_64.rpm
```

5. Download sqlplus
```bash
wget https://download.oracle.com/otn_software/linux/instantclient/1923000/oracle-instantclient19.23-sqlplus-19.23.0.0.0-1.x86_64.rpm
```

6. Install sqlplus
```bash
sudo alien -i oracle-instantclient19.23-sqlplus-19.23.0.0.0-1.x86_64.rpm
```

7. Verify sqlplus
```bash
sqlplus
```

8. Install libaio1 package
```bash
sudo apt-get install libaio1
```

9. Again verify sqlplus
```bash
sqlplus
```

10. Set LD_LIBRARY_PATH
```bash
export LD_LIBRARY_PATH=/usr/lib/oracle/19.23/client64/lib/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
```

11. Add oracle library path
```bash
sudo vi /etc/ld.so.conf.d/oracle.conf && sudo chmod o+r /etc/ld.so.conf.d/oracle.conf
```
and add the oracle library path as the first line. For example,
/usr/lib/oracle/19.23/client64/lib/

12. ldconfig
```bash
sudo ldconfig
```

13. Again verify sqlplus
```bash
sqlplus
```

14. Test oracle schema
```bash
sqlplus jblgoaml/jbLgoaml2021@172.30.30.13:1521/orcl
```


#### 📰 Oracle Docker Installation

install following `oracle-compose.yaml` oracle docker compose file
```bash
version: '3.8'

services:
  oracle:
    image: container-registry.oracle.com/database/enterprise:latest  # Oracle Database Enterprise Edition 21c
    container_name: oracle
    environment:
      - ORACLE_PWD=top_secret  # Sets the password for the SYS, SYSTEM, and PDBADMIN users
    ports:
      - 1521:1521  # Maps the host port 1521 to the container port 1521 for Oracle's TNS listener
```

installation command
```bash
sudo docker compose -f oracle-compose.yaml up -d
```

Access to oracle
```bash
docker exec -it oracle bash
```

Connect to Oracle Database
First, connect to your Oracle database using SQLPlus, SQL Developer, or any other tool you prefer. For example, using SQLPlus:
```bash
sqlplus sys/password@hostname:port/SERVICE_NAME as sysdba


sqlplus SYSTEM/Jbl@4567@localhost:1521/ORCLCDB
```

Connect ot Oracle Database with oracle db
```bash
Username: SYSTEM
Password: Jbl@4567
Role: SYSDBA
Hostname: 172.23.190.52
Port: 1521
Service Name: ORCLCDB
```

#### New Schema

Step 1: Create a New User (Schema)
In Oracle, a schema is essentially a user that owns the database objects like tables, views, etc. So, to create a schema, you need to create a new user.

Connect to Oracle as the SYSTEM user.

Create a new user that will act as the schema owner. Replace schema_name and password with your desired schema name and password.

```sql
CREATE USER schema_name IDENTIFIED BY password;
```
Grant the necessary privileges to the new user:

```sql
GRANT CONNECT, RESOURCE TO eshop;
```

```sql
ALTER SESSION SET CURRENT_SCHEMA = eshop;
```

```sql
ALTER USER eshop QUOTA UNLIMITED ON users;
```

Access New Schema:
```bash
Username: eshop
Password: Jbl@4567
Role: default
Hostname: 172.23.190.23
Port: 1521
Service Name: orclpdb1
```


The CONNECT privilege allows the user to connect to the database, and RESOURCE allows the user to create tables and other objects.

Step 2: Create Tables in the Schema
Switch to the new schema (user) in your SQL Developer interface. You can either reconnect using the new schema's credentials or use the following command:

Create the first table. For example, creating an employees table:
```sql
CREATE TABLE customer (
    customer_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    buy_date DATE,
    product VARCHAR2(50),
    price NUMBER(10, 2),
    PRIMARY KEY (customer_id)
);
```
Create the second table. For example, creating a departments table:

```sql
CREATE TABLE products (
    product_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    product_name VARCHAR2(100),
    seller_id NUMBER,
    PRIMARY KEY (product_id),
    FOREIGN KEY (seller_id) REFERENCES customer(customer_id)
);
```

Step 3: Verify the Tables
After creating the tables, you can verify them:

Query the user_tables view to see the list of tables:
```sql
SELECT table_name FROM user_tables;
```
Describe the tables to see their structure:
```sql
DESC customer;
DESC products;
```

#### Root Container
```sql
SQL> show user
USER is "SYS"
SQL> alter session set container=CDB$ROOT;

Session altered.

SQL> show con_name

CON_NAME
------------------------------
CDB$ROOT
```




Install oracle client on centos

1. First download oracle client package
https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html


2. Unzip oracle
```bash
sudo unzip instantclient-basic-linux.x64-19.19.0.0.0dbru.el9.zip

ls
# check after uzip this file be extract
instantclient_19_19
```

3. Set PATH
```bash
export LD_LIBRARY_PATH=/opt/oracle/instantclient_19_19:$LD_LIBRARY_PATH

echo $LD_LIBRARY_PATH

sqlplus DEBEZIUM/DEBEZIUM@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=172.8.9.28)(Port=1687))(CONNECT_DATA=(SID=jblldb)))
```
# MariaDB

Because I always forget these.

## Users

```
select user,host from mysql.user;
show grants for $USER;

create database IF NOT EXISTS somedb;
create user someuser IDENTIFIED BY 'password';
grant ALL ON somedb.* to someuser;

alter user someuser IDENTIFIED BY 'new_password';
drop user someuser;

grant all on *.* to superuser with grant option;
```

Things to note:

- `'user.with.dot'`
- `user@localhost` for local users
- `user@'192.168.0.*'` for subnets
- Common privileges
  - `ALL [PRIVILEGES]`
  - `DELETE`
  - `INDEX`
  - `INSERT`
  - `LOCK TABLES`
  - `SELECT`
  - `UPDATE`
  - `USAGE`
  - `CREATE TEMPORARY TABLES`
- Less common Privileges
  - `ALTER`
  - `ALTER ROUTINE`
  - `CREATE`
  - `CREATE ROUTINE`
  - `CREATE VIEW`
  - `DROP`
  - `TRIGGER`
- Static Privileges
  - `CREATE ROLE`
  - `CREATE TABLESPACE`
  - `CREATE USER`
  - `DROP ROLE`
  - `EVENT`
  - `EXECUTE`
  - `FILE`
  - `GRANT OPTION`
  - `PROCESS`
  - `PROXY`
  - `REFERENCES`
  - `RELOAD`
  - `REPLICATION CLIENT`
  - `REPLICATION SLAVE`
  - `SHOW DATABASES`
  - `SHOW VIEW`
  - `SHUTDOWN`
  - `SUPER`
- There are also dynamic privileges.  Read the documentation for them.


## Examples

```
MariaDB [(none)]> show grants for netdata@localhost;
+---------------------------------------------+
| Grants for netdata@localhost                |
+---------------------------------------------+
| GRANT USAGE ON *.* TO `netdata`@`localhost` |
+---------------------------------------------+
1 row in set (0.000 sec)

MariaDB [(none)]> show grants for typo3;
+------------------------------------------------------------------------------------------------------+
| Grants for typo3@%                                                                                   |
+------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `typo3`@`%` IDENTIFIED BY PASSWORD '*REDACTED*' |
| GRANT ALL PRIVILEGES ON `typo3`.* TO `typo3`@`%`                                                     |
+------------------------------------------------------------------------------------------------------+
2 rows in set (0.000 sec)
```


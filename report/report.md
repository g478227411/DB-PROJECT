




== SQL 语句

=== 创建表

```sql
CREATE TABLE `chat`.`account` ( `user_id` CHAR(16) NOT NULL , `password` CHAR(32) BINARY NOT NULL , `user_name` CHAR(16) NOT NULL , `sex` ENUM('male','female','other','unknown') NOT NULL , `birth_year` SMALLINT NOT NULL , `birth_month` TINYINT NOT NULL , PRIMARY KEY (`user_id`)) ENGINE = InnoDB;
```
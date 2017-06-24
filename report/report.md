




## SQL 语句

### 创建表

```sql
CREATE TABLE `chat`.`account` ( `user_id` CHAR(16) NOT NULL , `password` CHAR(32) BINARY NOT NULL , `user_name` CHAR(16) NOT NULL , `sex` ENUM('male','female','other','unknown') NOT NULL , `birth_year` SMALLINT NOT NULL , `birth_month` TINYINT NOT NULL , PRIMARY KEY (`user_id`)) ENGINE = InnoDB;
```

```sql
CREATE TABLE `chat`.`friends` ( `user_id` CHAR(16) NOT NULL , `friend_id` CHAR(16) NOT NULL , PRIMARY KEY (`user_id`, `friend_id`)) ENGINE = InnoDB;
```

```sql
CREATE TABLE `chat`.`statement` ( `statement_id` INT NOT NULL AUTO_INCREMENT , `user_id` CHAR(16) NOT NULL , `release_time` DATETIME NOT NULL , `content` TEXT NOT NULL , PRIMARY KEY (`statement_id`)) ENGINE = InnoDB;
```

```sql
CREATE TABLE `chat`.`comment` ( `comment_id` INT NOT NULL AUTO_INCREMENT , `statement_id` INT NOT NULL , `user_id` CHAR(16) NOT NULL , `release_time` DATETIME NOT NULL , `content` TEXT NOT NULL , PRIMARY KEY (`comment_id`)) ENGINE = InnoDB;
```
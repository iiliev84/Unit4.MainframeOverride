-- Table Overview
mainframe_override=# \d
                List of relations
 Schema |        Name         | Type  |  Owner
--------+---------------------+-------+----------
 public | emptystack_accounts | table | iiliev84
 public | forum_accounts      | table | iiliev84
 public | forum_posts         | table | iiliev84
(3 rows)

-- forum_posts
mainframe_override=# \d forum_posts
                        Table "public.forum_posts"
 Column  |              Type              | Collation | Nullable | Default
---------+--------------------------------+-----------+----------+---------
 id      | text                           |           | not null |
 title   | text                           |           | not null |
 content | text                           |           | not null |
 date    | timestamp(3) without time zone |           | not null |
 author  | text                           |           | not null |
Indexes:
    "forum_posts_pkey" PRIMARY KEY, btree (id)

-- emptystack_accounts
mainframe_override=# \d emptystack_accounts
         Table "public.emptystack_accounts"
   Column   | Type | Collation | Nullable | Default
------------+------+-----------+----------+---------
 username   | text |           | not null |
 password   | text |           | not null |
 first_name | text |           | not null |
 last_name  | text |           | not null |
Indexes:
    "emptystack_accounts_pkey" PRIMARY KEY, btree (username)
    "emptystack_accounts_username_key" UNIQUE, btree (username)

-- forum_accounts
mainframe_override=# \d forum_accounts
           Table "public.forum_accounts"
   Column   | Type | Collation | Nullable | Default
------------+------+-----------+----------+---------
 username   | text |           | not null |
 first_name | text |           | not null |
 last_name  | text |           | not null |
Indexes:
    "forum_accounts_pkey" PRIMARY KEY, btree (username)
    "forum_accounts_username_key" UNIQUE, btree (username)

--Find the forum post and the user that was made in April 2048 and the mention about EmptyStack and dad.
mainframe_override=# SELECT author FROM forum_posts WHERE date BETWEEN '2048-04-01' AND '2048-04-30' AND content LIKE '%EmptyStack%';
      author
-------------------
 steep-mechanic-65
 smart-money-44
(2 rows)

-- Two users found mentioning EmptyStack, need to see what post is also mentioning dad.
mainframe_override=# SELECT * FROM forum_posts WHERE date BETWEEN '2048-04-01' AND '2048-04-30' AND content LIKE '%EmptyStack%';
  id   |                            title                             |
     content                                                                                               |          date           |      author
-------+--------------------------------------------------------------+-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------+-------------------------+-------------------       
 pkNp7 | Argentum cubitum patrocinor totus utroque deleo temperantia. | Aureus depono constans nisi sophismata pax teneo animadverto. Quis timor cunctatio unus 
accendo nisi aeneus vado censura. Thorax arx illum adaugeo tempus cras. EmptyStack                         | 2048-04-02 12:50:36.588 | steep-mechanic-65        
 nbZY_ | Get rich fast                                                | You should all invest in EmptyStack Solutions soon or you'll regret it. My dad works the
re and he's got some serious inside intel. Their self-driving taxis are the future and the future is here. | 2048-04-08 00:00:00     | smart-money-44
(2 rows)

-- Found that the user is smart-money-44, need to find the last name
mainframe_override=# SELECT last_name FROM forum_accounts WHERE username = 'smart-money-44';
 last_name
-----------
 Steele
(1 row)

-- Found that the last name is Steele, need to find all other accounts with the same last name
mainframe_override=# SELECT * FROM forum_accounts WHERE last_name = 'Steele';
    username     | first_name | last_name
-----------------+------------+-----------
 sharp-engine-57 | Andrew     | Steele
 stinky-tofu-98  | Kevin      | Steele
 smart-money-44  | Brad       | Steele
(3 rows)

-- Found all other accounts with the same last name Steele, need to find all accounts in emptystack_accounts with the same last name
mainframe_override=# SELECT * FROM emptystack_accounts  WHERE last_name = 'Steele';
    username    |  password   | first_name | last_name
----------------+-------------+------------+-----------
 triple-cart-38 | password456 | Andrew     | Steele
 lance-main-11  | password789 | Lance      | Steele
(2 rows)

-- Andrew Steele is the active participant on the forum with the following credentials:
--username: triple-cart-38  password: password456

-- Need to use the credentials to access node mainframe
$ node mainframe
Username: triple-cart-38
Password: password456
Welcome, triple-cart-38!
Loading messages and projects...
Your data has been loaded to emptystack.sql. Have a nice day!

-- Reloaded the table
iiliev84=# \c mainframe_override
You are now connected to database "mainframe_override" as user "iiliev84".
mainframe_override=# \d
                List of relations
 Schema |        Name         | Type  |  Owner
--------+---------------------+-------+----------
 public | emptystack_accounts | table | iiliev84
 public | emptystack_messages | table | iiliev84
 public | emptystack_projects | table | iiliev84
 public | forum_accounts      | table | iiliev84
 public | forum_posts         | table | iiliev84
(5 rows)

-- emptystack_messages
mainframe_override=# \d emptystack_messages
       Table "public.emptystack_messages"
 Column  | Type | Collation | Nullable | Default
---------+------+-----------+----------+---------
 id      | text |           | not null |
 from    | text |           | not null |
 to      | text |           | not null |
 subject | text |           | not null |
 body    | text |           | not null |
Indexes:
    "emptystack_messages_pkey" PRIMARY KEY, btree (id)

--emptystack_projects
mainframe_override=# \d emptystack_projects
       Table "public.emptystack_projects"
 Column | Type | Collation | Nullable | Default
--------+------+-----------+----------+---------
 id     | text |           | not null |
 code   | text |           | not null |
Indexes:
    "emptystack_projects_pkey" PRIMARY KEY, btree (id)

-- Need to find the message in emptystack_messages that mentions self-driving taxis
mainframe_override=# SELECT * FROM emptystack_messages WHERE subject ILIKE '%taxi%';
  id   |     from     |       to       |   subject    |                            body
-------+--------------+----------------+--------------+------------------------------------------------------------
 LidWj | your-boss-99 | triple-cart-38 | Project TAXI | Deploy Project TAXI by end of week. We need this out ASAP.
(1 row)

-- Need to get the credentials for the admin account from emptystack_accounts of user your-boss-99
mainframe_override=# SELECT * FROM emptystack_accounts WHERE username = 'your-boss-99';
   username   |    password    | first_name | last_name
--------------+----------------+------------+-----------
 your-boss-99 | notagaincarter | Skylar     | Singer
(1 row)

-- Need to get the ID of the project from emptystack_projects
mainframe_override=# SELECT * FROM emptystack_projects WHERE code ILIKE '%taxi%';
    id    | code
----------+------
 DczE0v2b | TAXI
(1 row)

-- Need to stop the project: node mainframe -stop by using project id DczE0v2b
$ node mainframe -stop
WARNING: admin access required. Unauthorized access will be logged.
Username: your-boss-99
Password: notagaincarter
Welcome, your-boss-99.
Project ID: DczE0v2b
Initiating project shutdown sequence...
5...
4...
3...
2...
1...
Project shutdown complete.

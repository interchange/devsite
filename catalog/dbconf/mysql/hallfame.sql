Database  hallfame  hallfame.txt __SQLDSN__
ifdef SQLUSER
Database  hallfame  USER         __SQLUSER__
endif
ifdef SQLPASS
Database  hallfame  PASS         __SQLPASS__
endif
Database  hallfame  AUTO_NUMBER  00001
Database  hallfame  DEFAULT_TYPE  varchar(128)
Database  hallfame  COLUMN_DEF   "code=int unsigned NOT NULL PRIMARY KEY"
Database  hallfame  NUMERIC       code
Database  hallfame  COLUMN_DEF   "commentary=text"
Database  hallfame  COLUMN_DEF   "rank=tinyint unsigned NOT NULL default 50"
Database  hallfame  NUMERIC       rank
Database  hallfame  COLUMN_DEF   "add_date=DATETIME"
Database  hallfame  COLUMN_DEF   "last_working=DATETIME"
Database  hallfame  COLUMN_DEF   "cat=varchar(64)"

# Y = yes, good to use
# T = temporarily down; exclude from lists but check again later
# R = new submission to be reviewed
# N = do not use anymore
Database  hallfame  COLUMN_DEF   "active=enum('Y','T','R','N') default 'R'"


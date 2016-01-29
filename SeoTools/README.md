# README

# create databases

CD into project directory and run the following in the command line:
    $ psql -d postgres -U <username> -f scripts/create_db.sql

# create tables
    $ sequel -m migrations postgres://<username>:<password>@localhost/seo_development
    $ sequel -m migrations postgres://<username>:<password>@localhost/seo_test

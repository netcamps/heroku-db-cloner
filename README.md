A rake task to clone a production Heroku database to your local Rails development database.

Copy the `heroku_snapshot.rake` rakefile into the `/lib/tasks` folder and run `rake clone:herokudb`

It will:

1) Drop your current development database

2) Create a new clean development database

3) Take a snapshot of your production Heroku database (expires the oldest backup)

4) Download the snapshot to `latest.dump`

5) Import the snapshot into the development database

6) Remove the downloaded snapshot

Future plans including making this into a Gem and configurable options for the database.

Peace!

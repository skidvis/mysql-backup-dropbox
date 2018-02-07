# mysql-backup-dropbox

Backup MySQL to Dropbox (supports periodic backups & mutli files)

## Basic Usage

```
$ docker run \
  --name mysql_backup \
  -d \
  --restart=always \
  --log-opt max-size=1m \
  --log-opt max-file=5 \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD=root \
  -e MYSQL_HOST=mysql \
  -e DROPBOX_ACCESS_TOKEN=YOUR_TOKEN \
  -e SCHEDULE=@daily \
  suin/mysql-backup-dropbox
```

## Environment variables

- `MYSQLDUMP_OPTIONS` mysqldump options (default: --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384)
- `MYSQL_HOST` the mysql host *required*
- `MYSQL_PORT` the mysql port (default: 3306)
- `MYSQL_USER` the mysql user *required*
- `MYSQL_PASSWORD` the mysql password *required*
- `DROPBOX_PREFIX` path prefix in your Dropbox (default: empty)
- `DROPBOX_ACCESS_TOKEN` your Dropbox API access token *required*
- `SCHEDULE` backup schedule time, see explainatons below

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

## How to get Dropbox API token

Visit [the Dropbox app creation page](https://www.dropbox.com/developers/apps/create), and fill following fields in there.

1. Choose an API ... Dropbox API
2. Choose the type of access you need ... App folder
3. Name your app ... Your favorite name. This will be a folder name.

![](https://cdn.suin.io/542/1.png)

Once an application have created, you should press "Generate" button to generate your access token:

![](https://cdn.suin.io/542/2.png)

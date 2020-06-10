tommy-b-10/mongodump
===================

Docker image with `mongodump`, `cron`.

### Environment variables

| Env var               | Description | Default                 |
|-----------------------|-------------|-------------------------|
| MONGO_URI             | Mongo URI.  | `mongodb://mongo:27017` |
| CRON_SCHEDULE         | Cron schedule. Leave empty to disable cron job. | `''` |
| MONGO_NAME            | Mongo Name  | `mongo`                 |
| MONGO_URI_2           | Mongo 2 URI | `''`                      |
| MONGO_NAME_2          | Mongo 2 Name| `''`                      |
| MONGO_URI_3           | Mongo 3 URI | `''`                      |
| MONGO_NAME_3          | Mongo 3 Name| `''`                      |
| MONGO_URI_4           | Mongo 4 URI | `''`                      |
| MONGO_NAME_4          | Mongo 4 Name| `''`                      |

### Example

Run container with cron job (once a day at 1am):

      docker run -d \
        -v /path/to/target/folder:/backup \
        -e 'MONGO_URI=mongodb://mongo:27017' \
        -e 'CRON_SCHEDULE=0 1 * * *' \
        -e 'MONGO_NAME=tomsapp-db' \
        tommy-b-10/mongodump:4.2

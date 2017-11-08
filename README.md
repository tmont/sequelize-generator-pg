# sequelize-generator-pg
Generate [Sequelize](https://github.com/sequelize/sequelize) models
from an existing PostgreSQL database.

This is mostly for personal use but it's pretty neat so here it is.
It will generate models and associations as long as you use foreign
keys correctly. For many-to-many, it requires a composite primary
key foreign key-ing to the two join tables. Take a look at 
the `post_category` table in the [example blog schema](./example/blog.sql)
for inspiration.

I've used the raw output for several production applications, but it
might require some modification for other more complex needs. It's
still a decent baseline, though, if you want to just generate it once
and then extend/modify the output to fit what you want.

## Installation
```
npm install sequelize-generator-pg
```

## Usage
This is a CLI executable. You can only run it from the command line.
It can generate Typescript or JavaScript. Take a look in the ./example
directory for what it will generate.

### Example
```
node_modules/.bin/sequelize-generator-pg \
	--models-dir example/models \
	--relations-file example/relations \
	-h example.com \
	-U username \
	-p password \
	-d database \
	--typescript \
	--schema schema \
	--include-foreign-keys \
	--camel-case
```

### Help
```
USAGE
  sequelize-pg-generator --host hostname --username username --dbname dbname --models-dir dir
    --relations-file file [--port port] [--password password] [--schema schema] 
    [--verbose] [--typescript] [--help] [--version] [--include-foreign-keys]

OPTIONS
  Postgres connection options:
    --dbname|-d dbname       The name of the database
    --host|-h hostname       The hostname of the database
    --password|-p password   The PostgreSQL password
    --port|-P port           The port the PostgreSQL server runs on
    --schema schema          The schema to model (public)
    --username|-U username   The username to connect to PostgreSQL
    
  Output options:
    --models-dir dir         Output generated models in this directory
    --relations-file file    Output relations to this file
    --typescript             Generate TypeScript instead of JavaScript
    --indent str             String to use for indentation (TAB)
    --include-foreign-keys   Include foreign key ID fields in table attributes
    --camel-case             Convert field names to camel case
  
  Other options:
    --help                   Show this help message
    --verbose|-v|-vv         Output debugging messages to stderr
    --version                Show the version of this program
```


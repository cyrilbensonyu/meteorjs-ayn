# Ask Your Neighbor

## Run the project

**Make sure you have all of the pre-requisites below installed before running the project!**

### With IntelliJ

Use the run configuration that comes with this project

### Manually

You need to include the following environment variables:

* MONGO_URL=mongodb://localhost:27017/askYourNeighbor
* ROOT_URL=http://localhost:3000

Optional:

* METEOR_DEBUG_BUILD=1
* METEOR_DEBUG_SQL=1

Start the application with

`meteor --settings settings.json`

## Installation

### Pre-Requisites

The following software, utilities and libraries are required to run this project.

#### Meteor 

Meteor is available via install script:

* `curl https://install.meteor.com/ | sh`

#### MongoDB

MongoDB is available on OSX via Homebrew:

* `brew update`
* `brew install mongodb`

or manually:

* `curl -O https://fastdl.mongodb.org/osx/mongodb-osx-x86_64-3.2.11.tgz`
* `tar -zxvf mongodb-osx-x86_64-3.2.11.tgz`
* `mkdir -p mongodb`
* `cp -R -n mongodb-osx-x86_64-3.2.11/ mongodb`
* `export PATH=<mongodb-install-directory>/bin:$PATH` where `<mongodb-install-directory>` is the path where you actually installed MongoDB

For starting MongoDB for the first time: 

* `mkdir -p /data/db`

#### Xcode 7.2 or higher

For installation please see [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/)

#### Android Studio

For installation please see [http://developer.android.com/sdk/index.html](http://developer.android.com/sdk/index.html)

#### NodeJS and NPM

`curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash`
`nvm install --lts`

#### Coffeescript

`npm install -g coffee-script`

### Dependencies

Style dependencies are included in the project, to install script depencies run

`meteor npm install`

in the root folder of the application.
# meteorjs-ayn

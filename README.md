<h1 align="center">d8b3</h1>
<p align="center">An <a href="http://npmjs.org" target="_blank">NPM</a> package used to auto deploy a Bootstrap 3 Sub-theme to a Drupal 8 site.</p>

<p align="center">
  <a href="https://www.npmjs.com/d8b3" target="_blank">
    <img src="https://img.shields.io/npm/v/d8b3?style=for-the-badge" alt="NPM Version" />
  </a>
  <a href="https://www.npmjs.com/d8b3" target="_blank">
    <img src="https://img.shields.io/npm/l/d8b3?style=for-the-badge" alt="Package License" />
  </a>
  <a href="https://www.npmjs.com/d8b3" target="_blank">
    <img src="https://img.shields.io/npm/dm/d8b3?style=for-the-badge" alt="NPM Downloads" />
  </a>
</p>

<p align="center">
  <a href="https://github.com/andrewdetorres/d8b3" target="_blank">
    <img src="https://img.shields.io/github/last-commit/andrewdetorres/d8b3?style=for-the-badge" alt="Last Commit" />
  </a>
  <a href="https://www.npmjs.com/d8b3" target="_blank">
    <img src="https://img.shields.io/github/contributors/andrewdetorres/d8b3" alt="Github Contributors" />
  </a>
</p>

This is a bash script built to speed up the deployment for a Bootstrap 3 sub-theme deployment on a Drupal 8 instance.
The project has been developed to help a friend with their needs but is open for all to enjoy and contribute to.
Please feel free to raise an issue if you have any ideas to improve the AutoSubtheme script.

# d8b3 Usage

##### Installation
Install d8b3 as globally using the following command:
```
npm install -g d8b3
```

##### Usage
Navigate to the root of your drupal 8 site (e.g /var/www/html/[sitename]/drupal) and run the following command:
```
d8b3
```

Answer the series of questions and your sub-theme will be created.

# File Structure
On successfull execution of the d8b3 command. You should have the following file structure.

```
web
└───themes
│   │
│   └───contrib
│   │   └───bootstrap
│   └───custom
│       └───d8b3_bootstrap_subtheme
```

# Prerequisites

##### Drupal
Please ensure that you are running the latest stable version of [Drupal 8](https://www.drupal.org/project/drupal/releases)

##### wget
Please ensure that you are running a version of [wget](https://www.gnu.org/software/wget/) 1.20.3 or higher

##### Installing wget

Please use the following commands below to install wget depending on your OS of choice.

MacOs install wget
```
brew install wget
```
Linux install wget
```
apt-get install wget
```

### Bootstrap Version

The current version of this script is using ```https://ftp.drupal.org/files/projects/bootstrap-8.x-3.21.tar.gz``` for its Bootstrap 3 version.

# Authors
 - Andrew De Torres - [@andrewdetorres](https://github.com/andrewdetorres).

# Contributors

Thanks to the following contributors for their support.
 - Reece Benson - [@reecebenson](https://github.com/reecebenson).

See also the list of [contributors](https://github.com/andrewdetorres/d8b3/graphs/contributors) who participated in this project.

# License
This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/andrewdetorres/d8b3/blob/master/LICENSE.md) file for details
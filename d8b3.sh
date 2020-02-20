#
# Colors
#
RED='\033[0;31m' #Red
GR='\033[1;32m' #GREEN
LC='\033[0;36m' #Light Cyan
NC='\033[0m' # No Color

#
# Script intro
#
echo -e "${GR}
/////////////////////////////////////////////////////////////////////////${LC}
                         _    ___    _       ____
                        | |  / _ \  | |     |___ \
                      __| | | (_) | | |__     __) |
                     / _  |  > _ <  | '_ \   |__ <
                    | (_| | | (_) | | |_) |  ___) |
                     \__,_|  \___/  |_.__/  |____/ ${GR}

/////////////////////////////////////////////////////////////////////////
    Welcome to d8b3, an automated script used to set up Bootstrap 3
   for Drupal 8 Instances. The script currently uses bootstrap 8.x-3.21.
      Please visit ${RED}https://www.drupal.org/project/bootstrap${GR} to
             download the most recent release.
        Please ensure that you run this script from the site root,
            for example ${RED}/var/www/html/[SITE_NAME]/drupal.

/////////////////////////////////////////////////////////////////////////${NC}
"

unpackBootstrap() {
  # CHANGE BOOTSTRAP VERSION HERE
  wget https://ftp.drupal.org/files/projects/bootstrap-8.x-3.21.tar.gz;
  tar -xvzf bootstrap-8.x-3.21.tar.gz;
  rm -rf bootstrap-8.x-3.21.tar.gz;
}

buildStarterkit() {
  mv $SUBTHEME/THEMENAME.libraries.yml $SUBTHEME/$SUBTHEME_TITLE.libraries.yml;
  mv $SUBTHEME/THEMENAME.starterkit.yml $SUBTHEME/$SUBTHEME_TITLE.info.yml;
  mv $SUBTHEME/THEMENAME.theme $SUBTHEME/$SUBTHEME_TITLE.theme;
  mv $SUBTHEME/config/schema/THEMENAME.schema.yml $SUBTHEME/config/schema/$SUBTHEME_TITLE.schema.yml;
  cd $SUBTHEME;
  find ./ -type f -exec sed -i '' -e "s/THEMETITLE/$SUBTHEME_TITLE/g" {} \;
  find ./ -type f -exec sed -i '' -e "s/THEMENAME/$SUBTHEME_TITLE/g" {} \;
  cd ../../../..;
}

# Themes Directory.
SUBTHEME_TITLE=default_bootstrap_subtheme;

read -r -p "Please Enter your subtheme name: " SUBTHEME_TITLE;
echo;

CONTRIB="web/themes/contrib"
CUSTOM="web/themes/custom"
STARTERKIT="web/themes/contrib/bootstrap/starterkits/THEMENAME"
SUBTHEME="web/themes/custom/$SUBTHEME_TITLE"

# Check for contrib
if [ -d "$CONTRIB" ]; then
  # Make directory and unpack bootstrap
  cd $CONTRIB;
  unpackBootstrap;
else
  # Make directory and unpack bootstrap
  mkdir $CONTRIB;
  cd $CONTRIB;
  ls -l
  unpackBootstrap;
fi

# Move back to root directory
cd ../../..

# Check for custom
if [ -d "$CUSTOM" ]; then
  # Make directory and unpack bootstrap
  cp -R $STARTERKIT $CUSTOM;
  mv $STARTERKIT $SUBTHEME;
  buildStarterkit;
else
  # Make directory and unpack bootstrap
  mkdir $CUSTOM;
  cp -R $STARTERKIT $CUSTOM;
  mv $CUSTOM/THEMENAME $SUBTHEME;
  buildStarterkit;
fi

echo -e "${GR}
/////////////////////////////////////////////////////////////////////////

                      Installation now completed.

/////////////////////////////////////////////////////////////////////////${NC}
"
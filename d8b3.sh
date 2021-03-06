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
printf "${NC}
/////////////////////////////////////////////////////////////////////////
                         _    ___    _      _____
                        | |  / _ \  | |    |___  |
                      __| | | (_) | | |__    __) |
                     / _  |  > _ <  | '_ \  |__ <
                    | (_| | | (_) | | |_) | ___) |
                     \__,_|  \___/  |_.__/ |_____/

/////////////////////////////////////////////////////////////////////////

     Welcome to d8b3, an automated script used to set up Bootstrap 3
   for Drupal 8 Instances. The script currently uses bootstrap 8.x-3.21.
      Please visit ${GR}https://www.drupal.org/project/bootstrap${NC} to
                    download the most recent release.
        Please ensure that you run this script from the site root,
            for example ${GR}/var/www/html/[SITE_NAME]/drupal.${NC}

/////////////////////////////////////////////////////////////////////////
"

didError=false
doesExist() {
    printf "> $1..."
    if ! [ -x "$(command -v $1)" ]; then
        # Parameter 2 is an optional dependency
        if [ "$2" = true ]; then
            printf "${RED}WARNING${NC}\n"
        else
            printf "${RED}FAIL${NC}\n"
            didError=true
        fi
        return 0
    else
        printf "${GR}OK${NC}\n"
        return 1
    fi
}

unpackBootstrap() {
  # Download Bootstrap 3 for Drupal 8
  wget https://ftp.drupal.org/files/projects/bootstrap-8.x-3.21.tar.gz;

  # Extract file and remove tar.gz
  tar -xvzf bootstrap-8.x-3.21.tar.gz;
  rm -rf bootstrap-8.x-3.21.tar.gz;
}

# Used to check if a file has been successfully renamed
fileMoveSuccess() {
  if [ -f "$1" ]; then
    printf "${GR}File move $1 successful${NC}\n";
  else
    printf "${RED}File move unsuccessful${NC}\n";
    exit 1;
  fi
}

buildStarterkit() {
  # Move files and check success or failure
  mv $SUBTHEME/THEMENAME.libraries.yml $SUBTHEME/$SUBTHEME_TITLE.libraries.yml;
  fileMoveSuccess $SUBTHEME/$SUBTHEME_TITLE.libraries.yml;

  mv $SUBTHEME/THEMENAME.starterkit.yml $SUBTHEME/$SUBTHEME_TITLE.info.yml;
  fileMoveSuccess $SUBTHEME/$SUBTHEME_TITLE.info.yml;

  mv $SUBTHEME/THEMENAME.theme $SUBTHEME/$SUBTHEME_TITLE.theme;
  fileMoveSuccess $SUBTHEME/$SUBTHEME_TITLE.theme;

  mv $SUBTHEME/config/schema/THEMENAME.schema.yml $SUBTHEME/config/schema/$SUBTHEME_TITLE.schema.yml;
  fileMoveSuccess $SUBTHEME/config/schema/$SUBTHEME_TITLE.schema.yml;

  # Move back to subtheme and find/replace instances of THEMETITLE and THEMENAME
  cd $SUBTHEME;
  find ./ -type f -exec sed -i '' -e "s/THEMETITLE/$SUBTHEME_TITLE/g" {} \;
  find ./ -type f -exec sed -i '' -e "s/THEMENAME/$SUBTHEME_TITLE/g" {} \;
  cd ../../../..;
}

# Prerequisites check for wget
printf "\n${NC}Checking prerequisites...\n"
doesExist 'wget'
if [ "$didError" = true ]; then
    printf "${NC}Error:\n${RED}- Please make sure to install the above failed requirements.${NC}\n\n"
    exit 1
else
    printf "${GR}Requirements fulfilled!${NC}\n\n"
fi

# Themes Directory.
SUBTHEME_TITLE=d8b3_default_bootstrap_subtheme;

# Sed lang to treat all ASCII characters as themselves
LANG=C

read -r -p "Please Enter your sub-theme name: " SUBTHEME_TITLE;
echo;

CONTRIB="web/themes/contrib"
CUSTOM="web/themes/custom"
STARTERKIT="web/themes/contrib/bootstrap/starterkits/THEMENAME"
SUBTHEME="web/themes/custom/$SUBTHEME_TITLE"

# Check if sub-theme already exists
if [ -d "$SUBTHEME" ]; then
  printf "${RED}It appears a sub-theme with the title has already been created\n\n${NC}"
  printf "Please run the command ${GR}d8b3${NC} again and chose a different name\n\n"
  printf "Alternatively, please visit ${GR}https://npmjs.com/package/d8b3${NC} for more information.\n\n";
  exit 1;
else 
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
fi

if [ -f "$SUBTHEME/config/schema/$SUBTHEME_TITLE.schema.yml" ]; then
  printf "${GR}
  /////////////////////////////////////////////////////////////////////////

                        Installation now completed.

  /////////////////////////////////////////////////////////////////////////${NC}
  "
else 
  printf "${RED}
  /////////////////////////////////////////////////////////////////////////

                        Sub-theme installation unsuccessful.

  /////////////////////////////////////////////////////////////////////////${NC}
  "
fi

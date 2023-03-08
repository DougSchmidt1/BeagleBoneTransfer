#!binbash
if (hostname)  grep -iq “beaglebone-ai”; then
echo “hostname already set to ‘beaglebone-ai’ continuing”
else
echo “setting hostname to ‘beaglebone-ai’ then rebooting”
sudo hostnamectl set-hostname beaglebone-ai
sudo sed -i.bak ‘sbeaglebonebeaglebone-aig’ etchosts
sudo shutdown -r now
fi

if [ -e swapfile ]; then
echo “Found swapfile, not creating.”
else
sudo fallocate -l 1G swapfile
sudo chmod 600 swapfile
sudo mkswap swapfile
sudo swapon swapfile
sudo sh -c “echo -e ‘nswapfile swap swap defaults 0 0n’ etcfstab”
echo “swapfile created.”
fi

#Set timeszone to EST
#To list timezones timedatectl list-timezones
sudo timedatectl set-timezone AmericaNew_York

#Update and Upgrade
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

#INSTALL THE DEPENDENCIES

#Build tools and useful commands
sudo apt-get install -y build-essential cmake vim curl software-properties-common nmap htop iftop tree

#Media IO
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev

#Video IOp
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev libdigest-sha-perl

#Parallelism and linear algebra libraries
sudo apt-get install -y libtbb-dev libeigen3-dev

#Python
sudo apt-get install -y python3-dev python3-tk python3-numpy python3-pip
pip3 install --upgrade pip
pip3 install scikit-build
pip3 install opencv-python

#Adafruit BBIO Library
pip3 install Adafruit_BBIO

#v4l2 Library
pip3 install v4l2
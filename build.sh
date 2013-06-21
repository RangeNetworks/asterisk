#!/bin/bash

VERSION=11.4.0

sayAndDo () {
	echo $@
	eval $@
	if [ $? -ne 0 ]
	then
		echo "ERROR: command failed!"
		exit 1
	fi
}

installIfMissing () {
	dpkg -s $@ > /dev/null
	if [ $? -ne 0 ]; then
		echo " - oops, missing $@, installing"
		sudo apt-get install $@
	else
		echo " - $@ ok"
	fi
	echo
}

if [ ! -f asterisk-$VERSION.tar.gz ]
then
	sayAndDo wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-$VERSION.tar.gz
fi

if [ -d asterisk-$VERSION ]
then
	sayAndDo rm -rf asterisk-$VERSION
fi

sayAndDo tar zxf asterisk-$VERSION.tar.gz
sayAndDo cp menuselect.makeopts asterisk-$VERSION
sayAndDo mkdir asterisk-$VERSION/debian
sayAndDo cp debian/* asterisk-$VERSION/debian/
sayAndDo cd asterisk-$VERSION
sayAndDo dpkg-buildpackage

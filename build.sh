#!/bin/bash

VERSION=13.7.2

sayAndDo () {
	echo $@
	eval $@
	if [ $? -ne 0 ]
	then
		echo "ERROR: command failed!"
		exit 1
	fi
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
sayAndDo mkdir asterisk-$VERSION/debian
sayAndDo cp -R debian/* asterisk-$VERSION/debian/
sayAndDo cd asterisk-$VERSION
sayAndDo dpkg-buildpackage -us -uc

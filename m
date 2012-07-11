Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:51752 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518Ab2GKNmv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 Jul 2012 09:42:51 -0400
Message-ID: <4FFD82D8.6090301@bernhard-voelker.de>
Date: Wed, 11 Jul 2012 15:42:48 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: autogen.sh failing because of missing misc-utils/uuidd* files
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

since commit v2.21-820-g11935cd, autogen.sh fails:

$ git clean -xfdq
$ ./autogen.sh

Generate build-system by:
   autopoint:  /usr/bin/autopoint (GNU gettext-tools) 0.18.1
   aclocal:    aclocal (GNU automake) 1.11.1
   autoconf:   autoconf (GNU Autoconf) 2.68
   autoheader: autoheader (GNU Autoconf) 2.68
   automake:   automake (GNU automake) 1.11.1
   libtoolize: libtoolize (GNU libtool) 2.4
Copying file ABOUT-NLS
...
configure.ac:9: installing `config/missing'
configure.ac:1320: required file `misc-utils/uuidd.8.in' not found
configure.ac:1320: required file `misc-utils/uuidd.rc.in' not found
configure.ac:1320: required file `misc-utils/uuidd.socket.in' not found

These files somed to be deleted ...
What's wrong?

Have a nice day,
Berny

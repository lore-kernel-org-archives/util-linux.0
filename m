Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59085 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862AbaFCNww (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Jun 2014 09:52:52 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LngRb-1WJrAa1EUh-00hwyD for
 <util-linux@vger.kernel.org>; Tue, 03 Jun 2014 15:52:51 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: build-sys: how to install pylibmount after libmount?
Date: Tue, 3 Jun 2014 15:52:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201406031552.50670.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This should be easy to reproduce if you don't have a global installed 
libmount.

$ sudo mkdir /usr/lib64/away
$ sudo mv /usr/lib64/libmount.* /usr/lib64/away

$ ./configure --disable-use-tty-group \
	--prefix=/tmp/dest \
	--with-python \
	--without-systemd \
	--enable-pylibmount \
	--enable-libmount \
	--enable-libblkid
$ make
$ sed -i 's/\(link_all_deplibs\)=.*/\1=no/' ./libtool
$ rm -rf /tmp/dest
$ make install
 /usr/bin/mkdir -p '/tmp/dest/lib64/python2.7/site-packages/libmount'
 /bin/sh ./libtool   --mode=install /usr/bin/install -c   
pylibmount.la '/tmp/dest/lib64/python2.7/site-packages/libmount'
libtool: install: warning: relinking `pylibmount.la'
libtool: install: 
(cd /tmp/util-linux; /bin/sh /tmp/util-linux/libtool  --silent --tag 
CC --mode=relink 
gcc -std=gnu99 -fsigned-char -fno-common -Wall -Werror=sequence-point -Wextra -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wno-missing-field-initializers -Wredundant-decls -Wsign-compare -Wtype-limits -Wuninitialized -Wunused-but-set-parameter -Wunused-but-set-variable -Wunused-parameter -Wunused-result -Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes -I/usr/include/python2.7 -I./libmount/src -fno-strict-aliasing -g -O2 -avoid-version -module -shared -export-dynamic -o 
pylibmount.la -rpath /tmp/dest/lib64/python2.7/site-packages/libmount 
libmount/python/pylibmount_la-pylibmount.lo 
libmount/python/pylibmount_la-fs.lo 
libmount/python/pylibmount_la-tab.lo 
libmount/python/pylibmount_la-context.lo libmount.la -lpython2.7 )
/usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld: 
cannot find -lmount
collect2: error: ld returned 1 exit status
libtool: install: error: relink `pylibmount.la' with the above command 
before installing it
make[3]: *** [install-pylibmountexecLTLIBRARIES] Error 1
make[3]: Leaving directory `/tmp/util-linux'
make[2]: *** [install-am] Error 2
make[2]: Leaving directory `/tmp/util-linux'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/tmp/util-linux'
make: *** [install] Error 2


Unfortunately some systems set per default
  link_all_deplibs=no
instead of "unknown" in ./libtool. Don't know whether this is a bug in 
libtool or automake macros. But we could work around this if we would 
make sure to install pylibmount always after libmount.

This is how it looks in Makefile.in:
install-exec-am: install-binPROGRAMS install-dist_usrbin_execSCRIPTS \
        install-pylibmountexecLTLIBRARIES \
        install-pylibmountexecSCRIPTS install-sbinPROGRAMS \
        install-usrbin_execPROGRAMS install-usrlib_execLTLIBRARIES \
        install-usrsbin_execPROGRAMS
        @$(NORMAL_INSTALL)
        $(MAKE) $(AM_MAKEFLAGS) install-exec-hook

How could we force to put
  install-pylibmountexecLTLIBRARIES
after
  install-usrlib_execLTLIBRARIES

Or could we force somehow to disable that relinking?

cu,
Rudi


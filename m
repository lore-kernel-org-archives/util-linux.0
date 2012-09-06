Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33030 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075Ab2IFRfF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 6 Sep 2012 13:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1T9fyq-0001ry-0C
	for util-linux@vger.kernel.org; Thu, 06 Sep 2012 19:35:04 +0200
Received: from 103.85-200-56.bkkb.no ([85.200.56.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 06 Sep 2012 19:35:03 +0200
Received: from christer.solskogen by 103.85-200-56.bkkb.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 06 Sep 2012 19:35:03 +0200
To: util-linux@vger.kernel.org
From: Christer Solskogen <christer.solskogen@gmail.com>
Subject: cross compiling util-linux
Date: Thu, 06 Sep 2012 19:30:36 +0200
Message-ID: <k2amjt$fh0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi!

I'm having a bit trouble cross compiling util-linux. Due to where is 
thinks it finds libpam.la. For all I know that might be a problem that 
Linux-PAM has, but if anyone could point me in the right direction I 
would be very happy :-)

[solskogen@cheer util-linux.x86_64-centix-linux-gnu]$ make
make  all-recursive
make[1]: Entering directory 
`/storage/home/solskogen/obj/_build/util-linux.x86_64-centix-linux-gnu'
Making all in po
make[2]: Entering directory 
`/storage/home/solskogen/obj/_build/util-linux.x86_64-centix-linux-gnu/po'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory 
`/storage/home/solskogen/obj/_build/util-linux.x86_64-centix-linux-gnu/po'
make[2]: Entering directory 
`/storage/home/solskogen/obj/_build/util-linux.x86_64-centix-linux-gnu'
   CCLD   libblkid.la
copying selected object files to avoid basename conflicts...
   CCLD   libmount.la
   CCLD   login
libtool: link: cannot find the library `/lib64/libpam.la' or unhandled 
argument `/lib64/libpam.la'
make[2]: *** [login] Error 1
make[2]: Leaving directory 
`/storage/home/solskogen/obj/_build/util-linux.x86_64-centix-linux-gnu'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory 
`/storage/home/solskogen/obj/_build/util-linux.x86_64-centix-linux-gnu'
make: *** [all] Error 2

configure was run like this: -prefix=/usr 
--build=x86_64-unknown-linux-gnu --host=x86_64-centix-linux-gnu 
--with-sysroot=/home/solskogen/obj/root.x86_64-centix-linux-gnu

I have succesfully compiled the linux kernel, binutils, gcc, glibc etc. 
with the cross compiler so I'm pretty sure that nothing is wrong with my 
toolchain.


-- 
chs


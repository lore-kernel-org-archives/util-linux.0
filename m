Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50015 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbbLJWYN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Dec 2015 17:24:13 -0500
MIME-Version: 1.0
Message-ID: <trinity-01dc6d15-b86a-49f7-bd1c-6b0c22554b9d-1449786251438@3capp-gmx-bs27>
From: Yoss@gmx.net
To: util-linux@vger.kernel.org
Subject: bug in "mount --bind" for hashed tree indexed directories
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Dec 2015 23:24:11 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

summary:
'mount --bind oldfile newfile'  doesn't implement some changes in "newfile" if "oldfile" is situated in a hashed tree indexed directory (attribute I).

Example:
> lsattr /
 ----------I--e- /etc

> touch /etc/testa
> touch /tmp/testa
> mount --bind /etc/testa /tmp/testa
> vi /etc/testa (add some characters)
> ls -al /etc/testa
> ls -al /tmp/testa

Only the file /etc/testa contains the added characters. 


Tested Environments:

CentOS 7: 
Linux server 3.10.0-229.14.1.el7.x86_64 #1 SMP Tue Sep 15 15:05:51 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
Name        : util-linux
Version     : 2.23.2
Release     : 22.el7_1.1

RedHat 6:
Linux server 2.6.32-573.8.1.el6.x86_64 #1 SMP Fri Sep 25 19:24:22 EDT 2015 x86_64 x86_64 x86_64 GNU/Linux
Name        : util-linux-ng                Relocations: (not relocatable)
Version     : 2.17.2                            Vendor: Red Hat, Inc.
Release     : 12.18.el6                     Build Date: Mon 11 Aug 2014 01:03:25 PM CEST


Additional notes:
The problem seem to be more complex, because if a 'echo "test" >> /etc/testa' is used, it works. But after a change with vi, echo doesn't works too. Practical background is the use of mount --bind in a bind (named) chroot environment. A change of /etc/named.conf will not result in an update of /var/named/chroot/etc/named.conf. 

Regards
Stefan

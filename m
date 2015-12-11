Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:57562 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649AbbLKIgZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Dec 2015 03:36:25 -0500
MIME-Version: 1.0
Message-ID: <trinity-61d890c9-e0f2-425b-afb9-8ff7c6afe0d4-1449822982970@3capp-gmx-bs02>
From: kuehne.stefan@gmx.de
To: util-linux@vger.kernel.org
Subject: Re: bug in "mount --bind" for hashed tree indexed directories
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Dec 2015 09:36:23 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks for the fast answer.
You're right, this isn't a problem of mount. Maybe it would be helpful to add a hint in the list of mounted device (output of mount), when the mount is not "active" anymore (because of a moved file).

It's the special combination of tools I use which caused this trouble.
The "mount"-configuration is part of the named-chroot package in Redhat/CentOS. Webmin as administration tool works like vi (create tmp-files and move them).  
If you add a new zone via Webmin, only /etc/named.conf will be updated, not /var/named/chroot/etc/named.conf. If you then restart the service, it works, because the chroot environment will be destroyed and recreated. But a "rndc reload" doesn't work anymore because it uses the unchanged /var/named/chroot/etc/named.conf.

When you aware of the problem, it's no problem to work around. Since /etc/named is also a mount in chroot, the zone configuration can be separated in a file in this directory and then webmin works fine.

Thanks for your help, Rudi!


>On Thursday 10 December 2015, Yoss@gmx.net wrote:
>
>> Additional notes:
>> The problem seem to be more complex, because if a 'echo "test" >>
>> /etc/testa' is used, it works. But after a change with vi, echo
>> doesn't works too. Practical background is the use of mount --bind in
>> a bind (named) chroot environment. A change of /etc/named.conf will
>> not result in an update of /var/named/chroot/etc/named.conf.
>
>Why don't you use a hardlink?
>$ cp -al /etc/named.conf /var/named/chroot/etc/named.conf
>
>Then vim will automatically change it's behavior and saves changes 
>in-place.
>
>cu,
>Rudi

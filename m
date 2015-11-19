Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:34763 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbbKSSIS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Nov 2015 13:08:18 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1ZzTcw-0004yF-JV
	for util-linux@vger.kernel.org; Thu, 19 Nov 2015 19:08:10 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2015 19:08:10 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2015 19:08:10 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: RFC: usermount - a secure mount for unpriviledged users
Date: Thu, 19 Nov 2015 19:07:53 +0100
Message-ID: <n2l35p$5hm$1@ger.gmane.org>
References: <n2ibqp$ui6$1@ger.gmane.org> <20151119110511.GB4955@ws.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
In-Reply-To: <20151119110511.GB4955@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote on 11/19/2015 12:05 PM:
> On Wed, Nov 18, 2015 at 06:17:12PM +0100, U.Mutlu wrote:
>> Currently no responsible admin can grant permission to the mount pgm
>> to his users, because of the dangers inherent with bind-mounting etc.
>
> man mount, "The non-superuser mounts." section.
>
>      Karel

The man page says:
  The non-superuser mounts.
  Normally, only the superuser can mount filesystems. However, when fstab
  contains the user option on a line, anybody can mount the corresponding 
filesystem.

Ok, let's try this out:

/etc/fstab:
...
/home/userx/tmp/myfs1.img /home/userx/tmp/mymnt1 auto user,noauto 0 0
/home/userx/tmp/myfs2.img /home/userx/tmp/mymnt2 auto user,noauto 0 0

userx@mach:~/tmp$ ls -l
-rw-r--r-- 1 userx userx 10485760 Nov 19 02:11 myfs1.img
-rw-r--r-- 1 userx userx 10485760 Nov 17 07:20 myfs2.img
drwxr-xr-x 2 userx userx     4096 Nov 19 18:38 mymnt1
drwxr-xr-x 2 userx userx     4096 Nov 19 18:38 mymnt2

userx@mach:~/tmp$ mount /home/userx/tmp/myfs1.img /home/userx/tmp/mymnt1
mount: only root can do that

So, then why is this not working?




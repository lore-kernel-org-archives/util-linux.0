Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:57150 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab3J3QXG convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 12:23:06 -0400
Date: Wed, 30 Oct 2013 17:23:03 +0100 (CET)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Message-ID: <345614206.235496.1383150183769.open-xchange@email.1und1.de>
In-Reply-To: <52712CF0.9070603@ubuntu.com>
References: <527122AF.90003@ubuntu.com> <1530541679.232932.1383147597747.open-xchange@email.1und1.de> <52712CF0.9070603@ubuntu.com>
Subject: Re: Bind mounts record fstype of none
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> On October 30, 2013 at 4:59 PM Phillip Susi <psusi@ubuntu.com> wrote:
> > On 10/30/2013 11:39 AM, Bernhard Voelker wrote:
> > yes, df(1) is from coreutils. ;-)
> >
> > However, latest df(1) will skip such bind mounts per default - but
> > now because of some 'bind' information (which is not available

typo: s/now/not/, of course.

> > anyway), but just because it skips "duplicates" based on the
> > device numbers. For the same device number, it will output that
> > with the shortest mount point name. You have to use -a to see all.
>
> So is mount wrong for recording the filesystem type as 'none' or not?

Where do you see 'none'?

$ df /home
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sdb        10321208 1233056   8563864  13% /home

$ mkdir /tmp/home

$ mount -o bind /home /tmp/home

$ df -a | grep home
/dev/sdb        10321208 1233056   8563864  13% /home
/dev/sdb        10321208 1233056   8563864  13% /tmp/home

$ mount | grep home
/dev/sdb on /home type ext4 (rw,relatime,data=ordered)
/dev/sdb on /tmp/home type ext4 (rw,relatime,data=ordered)

$ grep home /proc/mounts /proc/self/mountinfo /proc/self/mounts
/proc/mounts:/dev/sdb /home ext4 rw,relatime,data=ordered 0 0
/proc/mounts:/dev/sdb /tmp/home ext4 rw,relatime,data=ordered 0 0
/proc/self/mountinfo:40 21 8:16 / /home rw,relatime shared:24 - ext4 /dev/sdb
rw,data=ordered
/proc/self/mountinfo:109 21 8:16 / /tmp/home rw,relatime shared:24 - ext4
/dev/sdb rw,data=ordered
/proc/self/mounts:/dev/sdb /home ext4 rw,relatime,data=ordered 0 0
/proc/self/mounts:/dev/sdb /tmp/home ext4 rw,relatime,data=ordered 0 0

[That was on kernel 3.7.10 of openSUSE-12.3,
mount/df built from {util-linux,coreutils}.git]

Have a nice day,
Berny

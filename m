Return-Path: util-linux-owner@vger.kernel.org
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:1284 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751251Ab1EaJdx (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 31 May 2011 05:33:53 -0400
Message-ID: <4DE4B565.6040504@draigBrady.com>
Date: Tue, 31 May 2011 10:31:17 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: James Youngman <jay@gnu.org>
CC: Philipp Thomas <pth@suse.de>, bug-gnulib@gnu.org,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Using /proc/mounts in mountlist.c for linux
References: <20110405123650.GW22289@paradies.suse.de> <BANLkTin=pcsJ-b2y=GN3BpXsx8p+zgnJWA@mail.gmail.com>
In-Reply-To: <BANLkTin=pcsJ-b2y=GN3BpXsx8p+zgnJWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 31/05/11 01:14, James Youngman wrote:
> On Tue, Apr 5, 2011 at 1:36 PM, Philipp Thomas <pth@suse.de> wrote:
>> GNU find will not recognize file systems of type autofs on newer Linux
>> kernels as autofs entries are only listed in /proc/mounts and mountlist.c
>> includes glibc mntent.h which takes the _PATH_MOUNTED from paths.h and that
>> is /etc/mtab.
>>
>> After a longer discussion, we (SUSE) chose to patch mountlist.c in findutils
>> to use proc/mounts instead of /etc/mtab which fixed ou problem.
>>
>> Would gnulib accept the attached patch to mountlist.c?
> 
> I don't know if this patch was accepted, but it shouldn't be.   The
> problem is that /proc/mounts has incomplete data for /.   This will
> break gnulib's mountlist, at least with the current form of the patch,
> because mountlist will have an incorrect idea of the type of the root
> filesystem.   Here's an example showing the problem:
> 
> ~$ cat tryit.sh
> #! /bin/sh
> f() {
>     echo "$1"
>     ( ls -l /etc/mtab; find / -maxdepth 0 -printf '%p %F\n' ) |
>     sed -e 's_^_    _'
> }
> 
> set -e
> cd /etc
> f "regular /etc/mtab"
> 
> mv mtab mtab.old; ln -s ../proc/mounts mtab
> f "with /proc/mounts"
> rm mtab; mv mtab.old mtab
> ~$ sudo sh tryit.sh
> regular /etc/mtab
>     -rw-r--r-- 1 root root 1869 May 30 23:53 /etc/mtab
>     / ext3
> with /proc/mounts
>     lrwxrwxrwx 1 root root 14 May 31 01:12 /etc/mtab -> ../proc/mounts
>     / rootfs

Well I didn't merge it, but for more generic reasons.
It seemed like a bit of a layering violation to me,
and I was unsure that other users of gnulib may need
access to /etc/mtab specific stuff (on older systems).

Here is related output on my Fedora 15 system
which does link /etc/mtab -> /proc/mounts

$ df /
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sdb2             13102208   3210896   9758244  25% /
$ df -t rootfs
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                13102208   3210896   9758244  25% /
$ find / -maxdepth 0 -printf "%p %F\n"
/ rootfs

cheers,
Pádraig.

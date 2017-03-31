Return-Path: sweet_f_a@gmx.de
Subject: Re: find device of a known mountpoint
To: Karel Zak <kzak@redhat.com>
References: <5f3534af-06b5-9c76-f5e3-9c1d489e570c@gmx.de>
 <20170331091925.mpwmxxk4da4lsegr@ws.net.home>
Cc: util-linux@vger.kernel.org
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <cabd1dc9-8eff-8000-ed3b-39c0463ae376@gmx.de>
Date: Fri, 31 Mar 2017 12:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170331091925.mpwmxxk4da4lsegr@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>



On 03/31/2017 11:19 AM, Karel Zak wrote:
> On Fri, Mar 31, 2017 at 11:00:24AM +0200, Rüdiger Meier wrote:
>> $ truncate -s100M /tmp/img
>> $ losetup /dev/loop0  /tmp/img
>> $ mkfs.ext2  /dev/loop0
>>
>> $ mkdir /tmp/mnt
>> $ ln -s /tmp  /tmp/xyz/symlink
>>
>> $ mount /dev/loop0 /tmp/xyz/symlink/mnt
>> $ mount | grep loop
>> /dev/loop0 on /tmp/mnt type ext2 ...
>>
>>
>> I need a command which outputs "/dev/loop0" when "/tmp/xyz/symlink/mnt" is
>> given.
>
>   $ findmnt -no SOURCE /tmp/xyz/symlink/mnt
>   /dev/loop0

Thank's. Now I remember that you have told me that already one day. :)

>
> Note that for bind mounts there is nothing like primary (original)
> and secondary mountpoints. It's two ways to the same filesystem.

Yep in this case the problem was only duplicate mountpoints when you 
mount something on a subdir a shared bind mount. I'll send a petch for 
one libmount test. I really hate that systemd defaults to shared ...

cu,
Rudi

Return-Path: P@draigBrady.com
Message-ID: <52A8444F.2040904@draigBrady.com>
Date: Wed, 11 Dec 2013 10:54:07 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>,
        Sten Heinze <shze@gmx.de>, util-linux@vger.kernel.org
Subject: Re: Automatic SSD trim script
References: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30> <20131206104944.GE16891@x2.net.home> <alpine.LFD.2.00.1312091438300.2143@localhost.localdomain> <20131210154442.GC8419@x2.net.home>
In-Reply-To: <20131210154442.GC8419@x2.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 12/10/2013 03:44 PM, Karel Zak wrote:
> On Mon, Dec 09, 2013 at 02:43:32PM +0100, Lukáš Czerner wrote:
>>> All we need is to link fstrim with libmount and lib/sysfs.c, add a new
>>> option --all and check non-zero /sys/block/<name>/queue/discard_granularity
>>> (or so).
>>
>> Yes and yes. This is the ultimate solution. Simply being able to run
>> fstrim --all to discard free space on all the mounted supported file
>> systems is great idea. In that case we do not need any scripts at
>> all.
> 
>  Implemented. Sten, maybe you can try fstrim --all from git tree 
>  in your crontab.

Very nice:
https://git.kernel.org/cgit/utils/util-linux/util-linux.git/commit/?id=36c370c

One foible was it was called multiple times for my /home
Now my /home is mounted a couple of times on my system (why I don't know):

├─/home                         /dev/sdb1           ext4                  rw,relatime,seclabel,user_xattr,barrier=1,data=ordered
│ └─/home                       /dev/sdb1           ext4                  rw,relatime,seclabel,user_xattr,barrier=1,data=ordered

If this was common it might be worth avoiding processing the same entry multiple times.

thanks!
Pádraig

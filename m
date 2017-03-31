Return-Path: sweet_f_a@gmx.de
Subject: Re: find device of a known mountpoint
To: Karel Zak <kzak@redhat.com>
References: <5f3534af-06b5-9c76-f5e3-9c1d489e570c@gmx.de>
 <20170331091925.mpwmxxk4da4lsegr@ws.net.home>
 <cabd1dc9-8eff-8000-ed3b-39c0463ae376@gmx.de>
Cc: util-linux@vger.kernel.org
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <de1756bf-3e8f-f2db-60ae-179067ff35f4@gmx.de>
Date: Fri, 31 Mar 2017 12:41:22 +0200
MIME-Version: 1.0
In-Reply-To: <cabd1dc9-8eff-8000-ed3b-39c0463ae376@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 03/31/2017 12:03 PM, Rüdiger Meier wrote:
>
>
> On 03/31/2017 11:19 AM, Karel Zak wrote:
>> On Fri, Mar 31, 2017 at 11:00:24AM +0200, Rüdiger Meier wrote:
>>> $ truncate -s100M /tmp/img
>>> $ losetup /dev/loop0  /tmp/img
>>> $ mkfs.ext2  /dev/loop0
>>>
>>> $ mkdir /tmp/mnt
>>> $ ln -s /tmp  /tmp/xyz/symlink
>>>
>>> $ mount /dev/loop0 /tmp/xyz/symlink/mnt
>>> $ mount | grep loop
>>> /dev/loop0 on /tmp/mnt type ext2 ...
>>>
>>>
>>> I need a command which outputs "/dev/loop0" when
>>> "/tmp/xyz/symlink/mnt" is
>>> given.
>>
>>   $ findmnt -no SOURCE /tmp/xyz/symlink/mnt
>>   /dev/loop0
>
> Thank's. Now I remember that you have told me that already one day. :)

BTW is there also a way to get "findmnt -n -o SOURCE" working if the
argument is not a mount point but a regular file on another mount
point? (In opposite of my initial question.)

I don't like that all these questions here are answered using "df".
http://unix.stackexchange.com/questions/90252/how-to-get-mount-point-of-filesystem-containing-given-file

http://unix.stackexchange.com/questions/128471/determine-what-device-a-directory-is-located-on


cu,
Rudi

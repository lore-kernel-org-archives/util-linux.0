Return-Path: linux-fsdevel-owner@vger.kernel.org
MIME-Version: 1.0
In-Reply-To: <558857AF.40707@ubuntu.com>
References: <55876C53.7030505@ubuntu.com>
	<20150622082008.GH1992@ws.net.home>
	<201506221455.46930.ruediger.meier@ga-group.nl>
	<20150622141551.GK1992@ws.net.home>
	<558857AF.40707@ubuntu.com>
Date: Tue, 23 Jun 2015 17:44:10 +0800
Message-ID: <CAGnHSEmF0f7oj3EZdL1g9-YSjNyWsmY12C+6f6kJMBDhu_FpBA@mail.gmail.com>
Subject: Re: mount existing tmpfs mounts a new tmpfs
From: Tom Yan <tom.ty89@gmail.com>
To: Phil Susi <psusi@ubuntu.com>
Cc: Karel Zak <kzak@redhat.com>, Ruediger Meier <ruediger.meier@ga-group.nl>,
        util-linux <util-linux@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Isn't it just the same case as when you mount something else to a
mountpoint being used? Like if /dev/sda1 is already mounted to /boot,
and it has an entry in fstab, then you probably can't `mount /dev/sda1
/boot` or `mount /boot`, but you can still mount sda2 or so to /boot.
And since each tmpfs is like a new filesystem, so isn't it pretty
consistent?

Though I have no idea why wouldn't in Debian tell you it's not in
fstab. Who knows what patches have they applied.

On 23 June 2015 at 02:45, Phil Susi <psusi@ubuntu.com> wrote:
> Ccing linux-fsdevel.  To catch up if you are just tuning in, the original
> problem is that "mount /run" mounts a new instance of tmpfs over top of the
> existing one, hiding the existing files, rather than reporting that it is
> already mounted.  The question is, is this a bug in mount, or the kernel?
>
> On 6/22/2015 10:15 AM, Karel Zak wrote:
>>
>> # strace -e mount mount /boot
>> mount("/dev/sda2", "/boot", "ext4", MS_MGC_VAL, NULL) = -1 EBUSY
>> (Device or resource busy)
>
>
> Why on earth is the kernel still returning EBUSY here?  It *does* support
> mounting the same block device multiple times these days so it should not be
> doing this.  It looks like it has some check to see if that device is
> already mounted somewhere in the current filesystem namespace and returns
> EBUSY if it is, otherwise, just bind mounts the existing mount if it is
> mounted in a different filesystem namespace. Not only does this check seem
> pointless, but it simply makes no sense at all for any filesystem that isn't
> backed by a block device, such as tmpfs, procfs, network filesystems, etc.
>
>>> $ mount /tmp/proc/
>>> mount: proc is already mounted or /tmp/proc busy
>>>         proc is already mounted on /proc
>>>         proc is already mounted on /tmp/proc
>>
>>
>> strace -e mount mount -t proc none /proc
>> mount("none", "/proc", "proc", MS_MGC_VAL, NULL) = -1 EBUSY (Device or
>> resource busy)
>
>
> Now *what* is this nonsense?  You can mount proc any time, anywhere you want
> to.  This EBUSY seems to be a special case hack that you only get if you try
> to mount procfs inside procfs.  You can mount any other fs over top of
> /proc, and you can mount /proc over top of any other fs. Why the one off
> check for mounting proc on top of proc?  And is tmpfs and any other virtual
> filesystem supposed to do this same check?
>
> What if you really *want* to mount a new tmpfs over the old one?  The kernel
> shouldn't be denying that request ( really, same goes for proc ).  It
> therefore, should be the responsibility of mount ( single argument form ) to
> notice when you have requested mounting of an already mounted filesystem
> listed in /fstab, and it certainly should not be treating /etc/mtab as if it
> were /etc/fstab and trying to mount the same thing a second time; the single
> argument form of mount should only consult fstab, not mtab too.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in

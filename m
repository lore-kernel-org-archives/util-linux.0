Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52243 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab1CVIOF convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 22 Mar 2011 04:14:05 -0400
Received: by qwk3 with SMTP id 3so4831235qwk.19
        for <util-linux-ng@vger.kernel.org>; Tue, 22 Mar 2011 01:14:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimmV34u+t9zDJ44AiAncU1PeSv9Rsn+qkvgeKVS@mail.gmail.com>
References: <AANLkTimmV34u+t9zDJ44AiAncU1PeSv9Rsn+qkvgeKVS@mail.gmail.com>
Date: Tue, 22 Mar 2011 09:14:02 +0100
Message-ID: <AANLkTin=YpCvgKveEj357_RXCbg5T3YnYEAroJXJWWY5@mail.gmail.com>
Subject: Re: mounting FreeBSD partition in Linux (Fedora 14)
From: J B <jb.1234abcd@gmail.com>
To: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 17, 2011 at 10:03 PM, J B <jb.1234abcd@gmail.com> wrote:
> Part 3.
> ...

Part 4.

Summary of the thread:

It is apparent that Linux, besides some minor bugs detected here, handles
*BSD file systems in an awkward way.
I say *BSD, as I assume that the FreeBSD test results probably appply to
OpenBSD and NetBSD as well due to similarity in their partition/slices
structure of their installations.

The issue is clear.
Linux kernel assigning device names to *BSD slices following those already
taken by Linux may cause serious problems when disk space is shared by both
OSs, e.g.
   # fdisk -l /dev/sda
   ...
   /dev/sda1              63         81920159    40960048+   7  HPFS/NTFS
   /dev/sda2   *    81920160   111222719    14651280   a5  FreeBSD
   ...
   /dev/sda9       216715023   246017519    14651248+  83  Linux

   # dmesg | grep bsd
   [    1.550749]  sda2: <bsd: sda10 sda11 sda12 sda13 sda14 >

------------------------------------------------------------------------------------------------------
From: Mikkel <mikkel <at> infinity-ltd.com>

It looks like the FreeBSD partition is being treated like an
extended partition, and the slices as logical partitions.

One thing to keep in mind is that the use of UUID or at least
partition labels are the preferred way to make sure the same
partition is mounted in the same place. It is too easy to change
drive letter designations by changing the boot drive in the BIOS, or
swapping cables to the drives. For that matter, by BIOS lets me set
the device order by drive, regardless of what SATA port the drive is
plugged into. When you get into USB connected storage, it gets even
more confusing when trying to use drive letter/partition to set the
mount point.

Mikkel

-------
On 03/18/2011 01:36 PM, JB wrote:
> ...
> These are the problems:
> 1. Linux has two widely used partition table display/manipulation entries:
>    fdisk
>    cfdisk
>    and there are more of them.
>    If none of them show all partitions (inclusive *BSD slices) as in
>    an example above, then these entries are fooling users and sysadmins.
>    This is lunacy and can be costly. Believe it or not but users rely on
>    truthfullness and clarity (nothing shall be hidden) when it comes to
>    the one and only one source of a particular info, based on which they make
>    decisions.

This is a problem with the specific tools. They do not stop you when
you try and mix a DOS partition table and a BSD disklabel on the
same drive. The problem is that BSD is letting you mix the partition
tables on the same drive. You have to remember that fdisk and cfdisk
are old tools that were written in the days when an admin was
supposed to know what he was doing, and the tools will allow him to
shoot himself in the foot if that is what he wants. The newer tools
like parted make this harder, but you can still do it. You might
want to read the man pages on the limitations of fdisk and cfdisk.

>    What if they decide they need an additional partition and look at fdisk
>    for the next available (they do not see hidden *BSD slices) ?
>    Is that not dangerous ?

Sure. That is a problem with using the old tools. You are not
supposed to mix DOS and BSD type partition table on the same drive,
but if that is what you want to do, they will let you. You will also
run into the same problem if you have Windows on the drive, and add
a logical drive. Linux handles this, as they use the same method
when dealing with a DOS partition table.

> 2. I have shown that *BSD slice /dev/≤name> can be temporarily mounted (and
>    serve as a source of data) and at the same time the same /dev/≤name> can
>    be used to create a new Linux partition.
>    Is that not dangerous ?

Definitly - you should not try and mix a DOS partition table with a
BSD disk label partition table. They are not compatible. Do not try
to use tools that do exactly what you tell them to do, and let you
decide if that is the correct thing to do if you do not want to run
into the problem.

> 3. I have shown that *BSD slice /dev/≤name> can be permanently mounted thru
>    /etc/fstab (and serve as a source of data) and at the same time the same
>    /dev/≤name> can be used to create a new Linux partition.
>    After that, due to mismatch of superblock/bad magic number that *BSD mount
>    will be refused.
>    Is that not dangerous ?
>    If that /dev/≤name> were used to create a new stand-alone UFS partition
>    (or anything for that matter that would match UFS superblock/bad magic
>    number), perhaps the fstab-base auto mount would be successful, serving who
>    knows what data.
>    Is that not dangerous ?
>
Yes, it is. Linux should refuse to mount a drive with a mix of DOS
type and BSD type partitions on the same drive, or at least mount it
read/only. Then again, BSD should refuse to create partitions on a
drive that already has a DOS type partition table.

While you are checking things out, see how Linux handles a drive
with a proper BSD partition table (drivelabel). I suspect that fdisk
will report things properly, and it will get mounted correctly under
Linux.

My take on this is that fdisk on *BSD does not stop you from
shooting yourself in the foot by creating a partition table like
this, and fdisk under Linux does not stop you from shooting yourself
in the foot again. This is why you need root access to do these
things - you are supposed to know what you are doing, and not do
things like this. But if you have a reason for doing them, the
system will let you.

Did you know that you can use the entire drive, without a partition
table, as a file system? If you want to run "mke2fs /dev/sda" as
root, it will let you. If you want to run "tar -cf /dev/sdb /home"
as root, and you have a sdb, it will use the entire drive as a tar
archive. And it will do it even if you have a partition table, and
mounted file systems on it. (It will not do it if you have /dev/sdb
mounted, but it will if you have /dev/sdb1 mounted.)

I have not tried it, but I suspect you can do the same thing under
*BSD. It should work on ANY UNIX-type system as long as you are the
super-user, what ever they call him.

Mikkel
------------------------------------------------------------------------------------------------------

I forgot to mention one more problem:
4. The /dev/≤name> assigned to Linux partition/*BSD slices have a "floating"
   nature as they are *appended* to Linux partitions.
   As a result they will be changed back and forth according to the latest
   changes affecting the tail of Linux partitions layout, effective with each
   system reboot.
   This also blows up the fstab-based auto mounts of *BSD slices/Linux
   partitions.
   Is that not dangerous ?

Yes, the power of super-user should be clear to any body who has the password.
The "let-them-shoot-themselves-in-the-foot" or "no hand-holding" philosophy
has justification where work of senses and professional skills should be in
the forefront.

But, there are others who think the system (sometimes very high-end, expensive,
and important) would be better off if dangerous actions were verified
(e.g. cross-checked) and at least warned of, if not prohibited, because
mistakes could be too costly to all involved.

I think making fdisk and cfdisk list these *BSD slices/Linux partitions would
be the minimum requirement; this would remove the accusation about them being
hidden from view.
Then, yes, let the users be responsible for their own actions.

JB

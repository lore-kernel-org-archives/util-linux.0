Return-Path: lkml@tlinx.org
Message-ID: <53E4ECD1.7080103@tlinx.org>
Date: Fri, 08 Aug 2014 08:29:21 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Specifying a generic and per-fs mount line in /etc/fstab as well as no-canonicalize.
References: <53E2B27C.9020305@tlinx.org> <20140808084446.GC17719@x2.net.home>
In-Reply-To: <20140808084446.GC17719@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Aug 06, 2014 at 03:55:56PM -0700, Linda A. Walsh wrote:
>> It's a display choice for *user-convenience* that was made over
>> years of feedback.
>>
>> Why not allow the same paradigm in /etc/fstab and allow nocanonicalize as
>> an option with mounts in /etc/fstab?
>
>  You can use symlinks in fstab, but mount(8) canonicalizes the path
>  before mount(2) syscall, because: 
>
>  * kernel canonicalizes the path as well and we (userspace) want to
>    be compatible with kernel to make it possible to compare paths in
>    mtab (or another in userspace cached files) with /proc/mounts
----
    Shells translate symlinks into physical paths before they talk to the
kernel.  There is no difference on this point.  The symlink management 
is all
done at the user level and is the "friendly" interface given to users. 
>
>  * you can think about mount table as about cache, how do you want
>    keep the mount table up to date if you remove or change the link?
>
>      mount /dev/foo /symlink
>      rm /symlink
          I'm not suggesting any changes to how mounts deal with file
system symlinks. I'm using file symlinks and the shells presenting
the logical interface to the user while presenting the physical
interface to the kernel as an example in good user-engineering that's
been developed over years.  

Similarly, letting the user call a device by the official lvm name, that may
be a symlink to some canonical name is a similar mechanism that is
**already supported** by the current mount.  It's just that you require
the mounts to be entered manually.

I simply asked for a way to specify "non-canonical" in fstab as one can
on the mount line. 


>  * it's also performance improvement to have canonical paths in the
>    mount table when you want search in the table
    Computer time is cheap compared to human time.  Keeping things more
sane for humans make more sense in terms of time and money than computers
who can handle names in GUID form among other human-difficult forms.


>
> I don't plan to do anything with mount(8) output.
I didn't ask you to do anything with the mount output.

I asked to support the same switch "non-canonical" that is already
implemented on the command line as mount-op.   The code is already
in there to do everything I am asking for.  I'm just asking for the
same option in fstab as on the command line.

>  If you want more
> customized output then use findmnt(8)
---
Not what I wanted.  I just want mount to show what is in fstab.  It used 
to do
that -- that was the standard -- I'm trying to make it easy to keep things
the same, and only add access to the command-line switch in the mntops.  The
code to handle the name display -- one way or the other is already there.

Return-Path: lkml@tlinx.org
Message-ID: <5B89C74D.8030701@tlinx.org>
Date: Fri, 31 Aug 2018 15:55:09 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: RFD: --enable-bindir-path ?
References: <5B82E969.6090409@tlinx.org> <20180830084556.ubvu5e5qhzih5fng@ws.net.home>
In-Reply-To: <20180830084556.ubvu5e5qhzih5fng@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Sun, Aug 26, 2018 at 10:54:49AM -0700, L A Walsh wrote:
>   
>> Was wondering about the addition of an "enable-bindir-path" which would only
>> use
>> paths with /bin instead of /usr/bin for setups where /usr/bin -> /bin (like
>> cygwin who mounts /bin and /lib on /usr/bin and /usr/lib -- using mounts
>> instead of symlinks).  The've had that since the beginning with nothing
>> being
>> installed in /usr/bin or /usr/lib.
>>     
>
> So for this use-case /usr should be ignored at all, right? What about PATH
> setting? Is it also without /usr? What about man pages, docs?
>   
----
    The use case for enable-usrdir-path is for cases where /bin->/usr/bin
/lib->/usr/lib, /lib64->/usr/lib, sbin->/usr/sbin,

conversely, the opposite would be where bin are in /bin and /usr/bin is
a symlink to /bin, and same for the libdirs and sbin.

    There is nothing in switch description about /doc, or /man being mounted
on /usr/<equiv>, so why would one move those around? 
> I have nothing against this feature, but question is if it's important
> enough to implement and support it ;-)
>   
---
    Well the sbin dirs are separate in cygwin, but /usr/bin is copy /bin
same for the lib dir.  It's really not that much to implement.  Only thing
it means is that if /usr is a separate partition, then during boot,
all your files in /bin, lib, lib64/ sbin...will be on the root, while and
boot can continue.  While if all the libs+binaries are /usr, it's hard to
mount.  So the use case is ensuring the system will boot?
>   
>> Was also wondering why that wasn't chosen as a default for merging, since
>> /bin and /lib are almost always on the root file system so they are always
>> there, versus /usr/{bin,lib{,64}} which may need to be mounted before it can
>> be used...if it can't be mounted, having things in /bin & /lib pointed
>> to /usr won't work so well.
>>     
>
> I think originally /usr was also on the same FS as /{bin,lib,...}.
>   
----
    Depends on what you mean by "originally", but back before linux,
originally there was no /usr, it came later for /usr files and home
dirs.  On it were application binaries for users, but binaries that were
not required for boot.


> Anyway, now this no issue as we use initram images where is all
> stuff that is necessary to assemble usable hierarchy of filesystems
> (including RAIDs, NFS moutpoints, etc.)
>
>     Karel
>   
----
    Who is this 'we' kimosami? ;^)

    Not me, nor anyone following the systemd recommendations for boot
speed.  My kernel is on a disk partition named 'boot' and it transfers
control to the 'root' partition that brings up HW, disks and network.
After that the rest of the system is brought up.

    Everything worked well until libs needed for 'mount' started appearing
on /usr.  If you had everything on a ram disk that was needed for boot,
but then the libs for some of the programs were out on the hard disk,
the ram disk would have a hard time proceeding as well. 

I don't have a different or separate /usr/{{s,}bin,lib{,64}} on a ram 
disk as
exists on my my hard disk, and /usr is usually too large for a
ram disk image.  So now how would one know when another part
of some boot program had been split off and put out on the disk /usr/lib?
Hopefully not by waiting until  it fails because at that point
it's a bit too late.

Does that answer your questions?

Cheers!
-Linda

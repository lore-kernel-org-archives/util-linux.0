Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33320 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbFVSqN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 14:46:13 -0400
Message-ID: <558857AF.40707@ubuntu.com>
Date: Mon, 22 Jun 2015 14:45:03 -0400
From: Phil Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Ruediger Meier <ruediger.meier@ga-group.nl>
CC: util-linux <util-linux@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: mount existing tmpfs mounts a new tmpfs
References: <55876C53.7030505@ubuntu.com> <20150622082008.GH1992@ws.net.home> <201506221455.46930.ruediger.meier@ga-group.nl> <20150622141551.GK1992@ws.net.home>
In-Reply-To: <20150622141551.GK1992@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ccing linux-fsdevel.  To catch up if you are just tuning in, the 
original problem is that "mount /run" mounts a new instance of tmpfs 
over top of the existing one, hiding the existing files, rather than 
reporting that it is already mounted.  The question is, is this a bug in 
mount, or the kernel?

On 6/22/2015 10:15 AM, Karel Zak wrote:
> # strace -e mount mount /boot
> mount("/dev/sda2", "/boot", "ext4", MS_MGC_VAL, NULL) = -1 EBUSY
> (Device or resource busy)

Why on earth is the kernel still returning EBUSY here?  It *does* 
support mounting the same block device multiple times these days so it 
should not be doing this.  It looks like it has some check to see if 
that device is already mounted somewhere in the current filesystem 
namespace and returns EBUSY if it is, otherwise, just bind mounts the 
existing mount if it is mounted in a different filesystem namespace. 
Not only does this check seem pointless, but it simply makes no sense at 
all for any filesystem that isn't backed by a block device, such as 
tmpfs, procfs, network filesystems, etc.

>> $ mount /tmp/proc/
>> mount: proc is already mounted or /tmp/proc busy
>>         proc is already mounted on /proc
>>         proc is already mounted on /tmp/proc
>
> strace -e mount mount -t proc none /proc
> mount("none", "/proc", "proc", MS_MGC_VAL, NULL) = -1 EBUSY (Device or
> resource busy)

Now *what* is this nonsense?  You can mount proc any time, anywhere you 
want to.  This EBUSY seems to be a special case hack that you only get 
if you try to mount procfs inside procfs.  You can mount any other fs 
over top of /proc, and you can mount /proc over top of any other fs. 
Why the one off check for mounting proc on top of proc?  And is tmpfs 
and any other virtual filesystem supposed to do this same check?

What if you really *want* to mount a new tmpfs over the old one?  The 
kernel shouldn't be denying that request ( really, same goes for proc ). 
  It therefore, should be the responsibility of mount ( single argument 
form ) to notice when you have requested mounting of an already mounted 
filesystem listed in /fstab, and it certainly should not be treating 
/etc/mtab as if it were /etc/fstab and trying to mount the same thing a 
second time; the single argument form of mount should only consult 
fstab, not mtab too.

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in

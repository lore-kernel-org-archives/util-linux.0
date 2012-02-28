Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45319 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab2B1N7X (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Feb 2012 08:59:23 -0500
Date: Tue, 28 Feb 2012 14:59:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: util-linux@vger.kernel.org
Subject: Re: What about a premount/postumount option for mount?
Message-ID: <20120228135918.GB22034@x2.net.home>
References: <20120211123016.GA15097@citd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120211123016.GA15097@citd.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 11, 2012 at 01:30:16PM +0100, Matthias Schniedermeyer wrote:
> For the umount thing, i think i could use inotify and wait for the 
> "umount"-event as inotify fortunately doesn't prevent umount, but that 

 See:
 http://karelzak.blogspot.com/2011/12/monitor-list-of-currently-mounted.html

> works a little against the spirit of autofs, as it only would work once 
> (at least in the case of setup by udev).
> 
> All "solutions" taste a little strange for me, the udev-solution mainly 
> because i would have a dm-crypt "laying" around which may or may not be

 It's usually bad idea to call mount (or so) from udev rules (and it's
 often topic in udev mailing list).

> used and the automatic tear-down after umount because what if it just 
> timed out and i want it to use again would only work with an exec-type 
> map where i could to the setup. Only doing the teardown of the dm-crypt 
> after the device is unplugged does not sound right to me either, because 
> i don't know if that is safe. My question if unplugging a device, with a 
> dm-crypt device in existence, is safe was met with silence.
> 
> All crutches would not be needed if there was a "premount" and "postumount" 
> option/command in mount that could do something "just before mount" and 
> "just after umount". Either "per mount" or "always".
> 
> I guess the easiest solution would be if mount would check for 
> /sbin/mount.premount and execute that before the mount took place, with 
> all the commandline parameters passed to the program and the same after 
> umount with /sbin/mount.postumount or something like that.

 I hope that next week we (I and dm-crypt maintainer) will publish our
 libblkasm (block device assemble library) draft. The goal is to have
 a shared library that will on demand assemble requested block device
 (dm-raid, mdraid, iscsi, loopdev, ...). The subsystem specific stuff
 will be in plug-ins (e.g. blkasm-crypt.so).

 The plan is to use the library from fsck or mount (or so..).

> This solution would also make for e.g. "loop-aes" more easily usable, 
> currently one has to use a patched version of mount/losetup. With a 

 Do you know that the latest cryptsetup is able to map loop-aes images
 by dm-crypt?

> premount/postumount-command/option it would be possible to use an unpatched 
> mount-binary and do the loop-aes setup/teardown "somewhere else", which 
> would at least alleviate the need for a patched mount command for the 
> usecases where there is no interactivity (e.g. with a "cleartextkey" or 
> a gpg-key when a usable gpg-agent is running).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from zeniv.linux.org.uk ([195.92.253.2]:48002 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3LLVxb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 Dec 2013 16:53:31 -0500
Date: Thu, 12 Dec 2013 21:53:25 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Karel Zak <kzak@redhat.com>, Phillip Susi <psusi@ubuntu.com>,
        util-linux@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: read only bind mount ignores ready only
Message-ID: <20131212215325.GE10323@ZenIV.linux.org.uk>
References: <52A878C5.6050505@ubuntu.com>
 <20131212120544.GJ16572@x2.net.home>
 <CAJfpegvWeEb7Dtk8CMxLO4DB-xSLQMxLxccUPReU0GeQ=9d5MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJfpegvWeEb7Dtk8CMxLO4DB-xSLQMxLxccUPReU0GeQ=9d5MA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 12, 2013 at 08:42:54PM +0100, Miklos Szeredi wrote:

> I really hate the current mount(2) API. It's a gigantic hack, and it's
> nearing the end of its life anyway due to flags running out.

You and me and just about anyone who'd ever looked at that mess ;-/

> So instead of adding more hacks, I think it would be better to think
> about adding a couple of syscalls that have clearly defined semantics.

It's not just flags, unfortunately.  Another problem stems from the
fact that the normal case used to be "mount the filesystem from this
block device on this directory", with additional flag added in v5
to indicate whether we want it rw or ro (v1 to v4 had everything rw).

On any modern Unix, Linux included, that does not fit the reality.
First of all, the main property of filesystem is not a block device -
it's filesystem type.  I.e. the real type of mount(2) (the normal
case, after you shed all the cruft with remount, bind, etc.) is
int (mountpoint, fs type, arguments specific for that fs type).
What's more, type-specific arguments really are almost entirely up
to fs driver.  "The block device of given filesystem" is not a well-defined
thing - it makes no sense for any network filesystem, for something like
procfs, for something that lives in userland, or uses more than one block
device, or lives on mtd device, etc.

Furthermore, even for types that do live on a single block device we need
more than just that device.  Even back in 1974 (v5), they had to add
a flag for rw vs. ro mounts.  For a while it looked like it would be
possible to keep it as bitmap (and the things were getting even more
muddled by mixing the flags fs itself doesn't care about into the
same thing - e.g. nosuid/nodev/noexec went there as well).  Alas, the
things got even nastier with NFS and its ilk - there had been too much
extra data to hope to pack it into a bitmap (timeout, etc.).

One approach had been
	type, mountpoint, flags, type-dependent pointer to struct
with flags still being a mix of "fs itself doesn't give a damn" ones
with ones that are very much for fs use (sync vs. async, for starters).
Pointer to device name had been hidden inside that struct in cases when
fs types needed one.  The really messy part of that approach is a binary
structure passed along, complete with alignment differences, size of
pointer headache, marshalling for case of userland filesystems, etc.
Moreover, mount(8) had to know the layouts of all these structures -
after all, it has to build one from the text you've got in fstab.  In
practice that meant separate binaries for different fs types - mount_nfs,
mount_xfs, etc., called by mount(8).  That's more or less what *BSD had
done.  Much later FreeBSD tried to go for array of pairs, passed as
an iovec (see nmount(2)).  At least nobody has been deranged enough to
pass XML...

	Linux started with v7-like (even pre-v5-like; there was no ro/rw flag)
variant, proceed to type x device name x opaque other data and shortly after
(in 0.97) to type x device name x flags x opaque other data.  With opaque data
being sometimes a string options, sometimes a binary structure.  Led to all
kinds of interesting headache for 32bit vs. 64bit userland later on; these
days it has mostly converged to device name x flags x opaque option string -
there are some exceptions, the worst offender being ncpfs.

	Note that device name is *also* opaque - it's interpreted by fs
type.  The parts of kernel outside of specific fs have no idea what to
do with that thing; quite a few filesystems simply ignore it (common
userland conventions include "none" or fs type name itself), some treat it
as a pathname of block device, some interpret it as a mix of server name and
path on server, etc.  As far as the rest of the kernel (starting with VFS)
is concerned, device name is a part of opaque triple passed along to fs driver.

	Another ugly thing is that e.g. ncpfs needs a non-trivial dialog
with server and it's implemented thus:
	mount(2) is given enough information to connect to server and mount
something.  Server is not willing to give any fs contents yet, though, so
all we see is an empty directory.
	mount(8) opens that directory and uses ioctl(2) to talk to server
	eventually that dialog with the server convinced it that we are to
be allowed to mount the sucker.  At that point the contents suddenly appears
in the previously empty directory.  No way for somebody looking at that
empty directory to tell if it's genuinely empty fs imported from the server
or just a half-authenticated one (you can see that ncpfs is mounted there,
but that's it).

	Frankly, I wonder if we are trying to pack too much into one
syscall - not just in terms of overloading it (that much is obvious),
but in terms of trying to cram a sequence of syscalls into one.  If
we end up introducing new API(s) for mount(), it's probably worth
considering something like this:
	* open a connection to fs type driver, get a descriptor
	* use normal IO syscalls (usually just write(2)) on that
descriptor to tell fs type driver what do we want.  If any kind of
authentication is needed, that's the time for doing it
	* attach the thing identified by that descriptor to mountpoint

I have an old writeup somewhere (several variants of it, actually) on possible
replacement APIs; I'll try to dig it out and post it.

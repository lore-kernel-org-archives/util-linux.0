Return-Path: util-linux-owner@vger.kernel.org
Received: from nm22-vm7.bullet.mail.ird.yahoo.com ([212.82.109.226]:46122 "HELO
	nm22-vm7.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964989Ab2CFWu2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Mar 2012 17:50:28 -0500
Message-ID: <1331073821.1882.16.camel@kyoto.localdomain>
Subject: mount -f regression in v2.21's new-mount
From: Matt Burgess <matthew@linuxfromscratch.org>
To: util-linux <util-linux@vger.kernel.org>
Date: Tue, 06 Mar 2012 22:43:41 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

First off, apologies in advance for the probably useless bug report that
follows!  I'm only reporting it here because it *appears* to be a
regression but I can't reproduce it under a minimised test-case.

Linux From Scratch's bootscripts mount a tmpfs at /run using the rather
trivial 'mount -n /run'.  The corresponding fstab entry is:

# file system  mount-point  type   options   dump  fsck order
tmpfs          /run         tmpfs  defaults  0     0

A little later on in the boot sequence, it then does a 'mount -f /run'
in order to do update /etc/mtab.

Now, when I build 2.21 with a plain './configure' run, everything works
as expected.  However, when I build 2.21 with './configure
--enable-new-mount', the 2nd call to 'mount' appears to actually perform
the mount, as opposed to simply updating /etc/mtab, thereby meaning that
files/directories we expect to be there are no longer visible.

As mentioned above, I tried to reproduce this with a minimal test-case
executed after boot, but the following *always* works correctly with
both old and new (libmount-based) mount:

mkdir /tmp/run
mount -n /tmp/run
touch /tmp/run/test
ls -l /tmp/run/test
mount -f /tmp/run
ls -l /tmp/run/test

If the test case was successful at reproducing the fault, I'd expect the
1st 'ls' command to show 1 file, and the 2nd to show 0 files.

Any ideas on either where this bug may be, or how I may go about trying
to reproduce/debug it further would be gratefully received.

Thanks,

Matt.


Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169Ab2CGHth (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Mar 2012 02:49:37 -0500
Date: Wed, 7 Mar 2012 08:49:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Matt Burgess <matthew@linuxfromscratch.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount -f regression in v2.21's new-mount
Message-ID: <20120307074933.GE8389@x2.net.home>
References: <1331073821.1882.16.camel@kyoto.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331073821.1882.16.camel@kyoto.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 06, 2012 at 10:43:41PM +0000, Matt Burgess wrote:
> Hi,
> 
> First off, apologies in advance for the probably useless bug report that
> follows!  I'm only reporting it here because it *appears* to be a
> regression but I can't reproduce it under a minimised test-case.
> 
> Linux From Scratch's bootscripts mount a tmpfs at /run using the rather
> trivial 'mount -n /run'.  The corresponding fstab entry is:
> 
> # file system  mount-point  type   options   dump  fsck order
> tmpfs          /run         tmpfs  defaults  0     0
> 
> A little later on in the boot sequence, it then does a 'mount -f /run'
> in order to do update /etc/mtab.
> 
> Now, when I build 2.21 with a plain './configure' run, everything works
> as expected.  However, when I build 2.21 with './configure
> --enable-new-mount', the 2nd call to 'mount' appears to actually perform
> the mount, as opposed to simply updating /etc/mtab, thereby meaning that
> files/directories we expect to be there are no longer visible.
> 
> As mentioned above, I tried to reproduce this with a minimal test-case
> executed after boot, but the following *always* works correctly with
> both old and new (libmount-based) mount:
> 
> mkdir /tmp/run
> mount -n /tmp/run
> touch /tmp/run/test
> ls -l /tmp/run/test
> mount -f /tmp/run
> ls -l /tmp/run/test
> 
> If the test case was successful at reproducing the fault, I'd expect the
> 1st 'ls' command to show 1 file, and the 2nd to show 0 files.
> 
> Any ideas on either where this bug may be, or how I may go about trying
> to reproduce/debug it further would be gratefully received.

 Try to modify your init scripts:

    LIBMOUNT_DEBUG=0xffff mount -f /run 2> /root/mount-run.debug

 we will see more details in the log.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

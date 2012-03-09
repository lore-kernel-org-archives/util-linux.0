Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458Ab2CIM33 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Mar 2012 07:29:29 -0500
Date: Fri, 9 Mar 2012 13:29:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Matthew Burgess <matthew@linuxfromscratch.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: mount -f regression in v2.21's new-mount
Message-ID: <20120309122926.GH17711@x2.net.home>
References: <20120309105304.GF17711@x2.net.home>
 <5fde29ffbccb41cf5eb3a286c2f7e954@quantum.linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5fde29ffbccb41cf5eb3a286c2f7e954@quantum.linuxfromscratch.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 09, 2012 at 04:30:02AM -0700, Matthew Burgess wrote:
> On Fri, 9 Mar 2012 11:53:04 +0100, Karel Zak <kzak@redhat.com> wrote:
> > On Thu, Mar 08, 2012 at 08:25:00PM +0000, Matt Burgess wrote:
> >> I've attached LIBMOUNT_DEBUG output from the 'mount -a' call that our
> >> bootscript does.  Note how mount correctly detects that /proc, /sys
> > 
> >  No, it calls mount(2) syscall for /proc. The problem is that the
> >  detection code expects /proc/self/mountinfo (used on systems with
> >  mtab -> /proc/mounts symlink), but your system uses regular mtab.
> > 
> >  I'll fix it. Thanks.

 Fixed, try git pull.

> Thanks!  Is there a consensus opinion on whether users should be
> using a regular mtab or a symlink to /proc/self/mountinfo?

 - disadvantage is that some userspace utils (e.g. df(1) are not able
   to de-duplicate list of mounted filesystem (bind mounts))

 + advantage is that there is only one list of mounted filesystems
   with always valid mount options (on systems with mtab is not problem
   to have 'rw' in mtab for read-only NFS, etc.), no problems with
   namespaces, not writable files in /etc, no mtab lock, etc.

 The symlink is required for systemd.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

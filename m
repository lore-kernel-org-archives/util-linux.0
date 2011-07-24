Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:59794 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752503Ab1GXWqa (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 24 Jul 2011 18:46:30 -0400
Subject: Re: Can't remount loopback ext4 without /etc/mtab
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: "Ted Ts'o" <tytso@mit.edu>
Cc: Daniel Drake <dsd@laptop.org>, util-linux@vger.kernel.org
In-Reply-To: <20110724195713.GH3469@thunk.org>
References: <CAGq3pz7FctJcUsO-1FmFmV=EW0N=n_ZYBCHGcyXQMr1CJ24zRA@mail.gmail.com>
	 <20110724195713.GH3469@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 18:46:21 -0400
Message-ID: <1311547581.3367.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 2011-07-24 at 15:57 -0400, Ted Ts'o wrote:
> On Sun, Jul 24, 2011 at 07:09:47PM +0100, Daniel Drake wrote:
> > 
> > When the error occurs, dmesg says:
> > [ 5495.860391] EXT4-fs (loop0): Unrecognized mount option "seclabel"
> > or missing value
> > 
> > Here is the corresponding entry from /proc/mounts:
> > /dev/loop0 /home/dsd/tmpdisk/mountpt ext4
> > rw,seclabel,relatime,barrier=1,data=ordered 0 0
> > 
> > Is this a util-linux bug? Or an ext4 issue?
> 
> Or a selinux thing; "seclabel" seems to be SELinux's fault:
> 

It would seem so, I can't reproduce this issue on a "normal", non
SELinux box.

> % git grep LABELSUPP_STR
> security/selinux/hooks.c:       {Opt_labelsupport, LABELSUPP_STR},
> security/selinux/hooks.c:                       seq_puts(m, LABELSUPP_STR);
> security/selinux/hooks.c:               match_prefix(LABELSUPP_STR, sizeof(LABEL
> security/selinux/include/security.h:#define LABELSUPP_STR "seclabel"
> 
> Personally, I find my life has been much happier since I gave up on
> SELinux as being too complicated to be secure.

+1!!

- Davidlohr


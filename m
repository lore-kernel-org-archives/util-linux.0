Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab1GYJGc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Jul 2011 05:06:32 -0400
Date: Mon, 25 Jul 2011 11:06:24 +0200
From: Karel Zak <kzak@redhat.com>
To: "Ted Ts'o" <tytso@mit.edu>
Cc: Daniel Drake <dsd@laptop.org>, util-linux@vger.kernel.org
Subject: Re: Can't remount loopback ext4 without /etc/mtab
Message-ID: <20110725090624.GU22568@nb.net.home>
References: <CAGq3pz7FctJcUsO-1FmFmV=EW0N=n_ZYBCHGcyXQMr1CJ24zRA@mail.gmail.com> <20110724195713.GH3469@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110724195713.GH3469@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 24, 2011 at 03:57:13PM -0400, Ted Ts'o wrote:
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

 mount(8) "bug"

 The kernel does not accept any SELinux specific mount options for
 MS_REMOUNT. We already have exception for this in mount(8) ... and I
 hate it, but our SELunux kernel guys are happy with this strange
 behavior:

 https://bugzilla.redhat.com/show_bug.cgi?id=563267#c9
 
> Personally, I find my life has been much happier since I gave up on
> SELinux as being too complicated to be secure.

 +1 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

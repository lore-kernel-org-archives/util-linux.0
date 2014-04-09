Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:52175 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933458AbaDISkA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Apr 2014 14:40:00 -0400
Date: Wed, 9 Apr 2014 14:39:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Message-ID: <20140409183954.GB778@thunk.org>
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org>
 <20140409110251.GT22126@x2.net.home>
 <20140409140240.GA26270@x4>
 <201404091748.07452.sweet_f_a@gmx.de>
 <20140409155557.GF26270@x4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140409155557.GF26270@x4>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 09, 2014 at 05:55:57PM +0200, Markus Trippelsdorf wrote:
> > > The fixed interval is problematic. There are SSD devices out there
> > > that suffer (their flash cells die out faster) when they get trimmed
> > > too often. A good rule of thumb is to trim once you have written the
> > > same amount as you have free space on your device. Obviously, that
> > > interval varies for every user (e.g. it's one week in my case).
> > 
> > Is "mount -o discard" instead of fstrim interval more or less bad 
> > regarding lifetime?

For those SSD's that have a problem, "mount -o discard" is a disaster.
Some turn into bricks, others will have a degraded flash cells, many
will cause extremely degraded performance for other processes.

What I usually tell people as far as who ask me for advice is that
once a week is usually sufficient, especially for most desktop and
server systems.  If you are running an extreme workload which is doing
a huge number of random writes, then sure, running fstrim more
frequently, or even using "mount -o discard" might make a lot more
sense --- especially if you are using PCIe attached flash.  But in
those cases, the system administrator might not want be willing to
tolerate the random latencies in performance that might show up when
fstrim is running (for pretty much all SATA and SAS attached SSD's out
there, they don't yet support queued trim, so each trim command
requires draining the NCQ queue, which is why sending trim commands,
whether via "mount -o discard" or via fstrim will incur a performance
penalty to whatever else might be trying to use the disk at the time).

I'll note BTW that even using "fstrim" could potentially brick an
especially inexpensive/trashy SSD, although the vendor for whose drive
had been most commonly accused of promulgating those to the world is
out of business (although there are probably plenty of those SSD's
still in use in various community distros' audiences.)

Cheers,

						- Ted

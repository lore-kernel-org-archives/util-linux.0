Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:62184 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934514AbaDJJRM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Apr 2014 05:17:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Thu, 10 Apr 2014 11:17:04 +0200
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        Markus Trippelsdorf <markus@trippelsdorf.de>,
        util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <20140409183954.GB778@thunk.org> <20140410080514.GA26252@x2.net.home>
In-Reply-To: <20140410080514.GA26252@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201404101117.05565.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 10 April 2014, Karel Zak wrote:
> On Wed, Apr 09, 2014 at 02:39:54PM -0400, Theodore Ts'o wrote:
> > On Wed, Apr 09, 2014 at 05:55:57PM +0200, Markus Trippelsdorf wrote:
> > > > > The fixed interval is problematic. There are SSD devices out
> > > > > there that suffer (their flash cells die out faster) when
> > > > > they get trimmed too often. A good rule of thumb is to trim
> > > > > once you have written the same amount as you have free space
> > > > > on your device. Obviously, that interval varies for every
> > > > > user (e.g. it's one week in my case).
> > > >
> > > > Is "mount -o discard" instead of fstrim interval more or less
> > > > bad regarding lifetime?
> >
> > For those SSD's that have a problem, "mount -o discard" is a
> > disaster. Some turn into bricks, others will have a degraded flash
> > cells, many will cause extremely degraded performance for other
> > processes.
> >
> > What I usually tell people as far as who ask me for advice is that
> > once a week is usually sufficient, especially for most desktop and
> > server systems.  If you are running an extreme workload which is
> > doing a huge number of random writes, then sure, running fstrim
> > more frequently, or even using "mount -o discard" might make a lot
> > more sense --- especially if you are using PCIe attached flash. 
> > But in those cases, the system administrator might not want be
> > willing to tolerate the random latencies in performance that might
> > show up when fstrim is running (for pretty much all SATA and SAS
> > attached SSD's out there, they don't yet support queued trim, so
> > each trim command requires draining the NCQ queue, which is why
> > sending trim commands, whether via "mount -o discard" or via fstrim
> > will incur a performance penalty to whatever else might be trying
> > to use the disk at the time).
> >
> > I'll note BTW that even using "fstrim" could potentially brick an
> > especially inexpensive/trashy SSD, although the vendor for whose
> > drive had been most commonly accused of promulgating those to the
> > world is out of business (although there are probably plenty of
> > those SSD's still in use in various community distros' audiences.)
>
>  Thanks for the advices.
>
>  I have modified the systemd fstrim.timer (daily -> weekly) and added
>  some notes to the man page.

Thanks, maybe we could add another minor change to "fstrim -a" itself. 
If possible it would be IMO useful to skip bind mounts to avoid 
trimming the same filesystem several times in a row like this:

$ grep "tmp" /etc/fstab
/dev/vg0/tmpdirs     /mnt/tmpdirs   ext4       acl,user_xattr     1 2
/mnt/tmpdirs/tmp     /tmp           none       bind               0 0
/mnt/tmpdirs/var/tmp /var/tmp       none       bind               0 0

$ ./fstrim -av
/tmp: 392 KiB (401408 bytes) trimmed
/var/tmp: 0 B (0 bytes) trimmed
/mnt/tmpdirs: 0 B (0 bytes) trimmed

Skipping bind mounts should still trim all mounted filesytems.

cu,
Rudi


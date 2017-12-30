Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:37224 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdL3NUt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 30 Dec 2017 08:20:49 -0500
Date: Sat, 30 Dec 2017 08:20:45 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <rain@vojtechvladyka.cz>
Subject: Re: fsck command line API
Message-ID: <20171230132045.GA3366@thunk.org>
References: <20171227101429.bisgfv5wumxcqiqp@pali>
 <20171229120242.lnp7dsp5wuyqrasr@ws.net.home>
 <20171229183754.GC11757@thunk.org>
 <20171230120352.s64unqtl4dwypxnl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171230120352.s64unqtl4dwypxnl@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 30, 2017 at 01:03:52PM +0100, Pali Rohár wrote:
> 
> Hi! Thank you for detailed information. I have just one more question,
> what should filesystem specific fsck do if is started by -a or -p (or
> with -y) during boot and filesystem structures indicates that last time
> it was successfully (clean) unmounted? Should it scan whole disk and
> check all data (files/directories/structures) for consistency? Or should
> trust for "clean" state and stop? And if stop, how to tell that
> filesystem fsck to really scan whole disk? For example scanning 2TB disk
> is really time consuming, specially at boot time.

What e2fsck (fsck.extN) does is check to see if the file system has
the "errors/corruptions were detected by the kernel" bit set.  If so,
it will do a full check.  Otherwise, if time-based or mount-based
criteria is enabled, and exceeded, then e2fsck will do a full check.
Otherwise, it will stop.

The other thing e2fsck for ext4 file systems will do is to replay the
journal.  This is useful because fsck will run fsck in parallel, while
mount -a mounts file systems serially.  So running the journal in
parallel when you have multiple disk spindles can be a big win.  This
may be less of a big deal these days since systemd will run mounts in
parallel.

As far as time-based or mount-based full checks (see tune2fs for
discussion on this topic), we don't enable this by default any more in
e2fsprogs.  That's precisely because doing full check for 10 TB disk
takes and 60TB RAID arrays takes a long time.  The idea of doing mount
based checks goes back to the BSD days, because disks and memory are
really crappy, and so checking to find problems before they become
catastrophic data loss events made sense.  These days for big disks,
the cost/benefit ratio doesn't work out as well.

Also, if you have snapshot support in your file system, you can simply
create a snapshot, and run the fsck on the snapshot.  An example of
how to do this can be found here:

https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/contrib/e2croncheck

Cheers,

					- Ted

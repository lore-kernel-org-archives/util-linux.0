Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754776AbdKOQbJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Nov 2017 11:31:09 -0500
Date: Wed, 15 Nov 2017 17:31:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Douglas Jacobsen <dmjacobsen@lbl.gov>
Cc: util-linux@vger.kernel.org
Subject: Re: mnt_is_readonly() call to utimensat() has serious performance
 consequences
Message-ID: <20171115163105.rcm3b7shublarmap@ws.net.home>
References: <e1932cb6-9c28-5cfd-29d2-78d39ade41b2@lbl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <e1932cb6-9c28-5cfd-29d2-78d39ade41b2@lbl.gov>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 15, 2017 at 08:21:51AM -0700, Douglas Jacobsen wrote:
> Some time ago we traced a large scale booting issue back to the utimensat()
> call that mnt_is_readonly() makes when mounting a read-write, but
> root-squashed parallel filesystem.
> 
> This is caused by many clients mounting nearly simultaneously, failing the
> access() call earlier (because the FS is root-squashed) and then calling
> utimensat() at about the same time.  Because it attempts to write to the
> mount point, the remote filesystem manager serializes the passage through
> utimensat().
> 
> The filesystem is already mounted at this point and it appears that the
> utimensat() call is really only used to append a "ro" to the apparent mount
> flags for /etc/mtab, it seems that this is a high cost to make this
> determination.
> 
> It seems this was discussed in this thread previously:
> https://marc.info/?l=util-linux-ng&m=148405286532392&w=2
> <https://marc.info/?l=util-linux-ng&m=148405286532392&w=2>
> 
> However, I think it would be preferable to not be required to have a
> custom-build of util-linux to avoid this problem.

The custom build is not required, the mtab is disabled by default. You
have to explicitly build with --enable-libmount-support-mtab to enable
this expensive code.

> Is this secondary check
> with utimensat() really necessary?  Perhaps an alternative to removing it
> would be to have a check to see if /etc/mtab is writable before aggressively
> collecting data that may not be able to be outputted to it, for example, in
> the case that /etc/mtab is a symlink to /proc/mounts this logic could be
> skipped.  Skimming through the libmount code, perhaps adding a check
> against mnt_context_mtab_writable() here:

Good point. I'll improve it tomorrow. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

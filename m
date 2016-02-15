Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:59021 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbcBOLy2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Feb 2016 06:54:28 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: tests: strange redirection
Date: Mon, 15 Feb 2016 12:54:22 +0100
Cc: util-linux@vger.kernel.org
References: <56BCE1F6.9000805@suse.cz>
In-Reply-To: <56BCE1F6.9000805@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <201602151254.22589.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 11 February 2016, Stanislav Brabec wrote:
> I just found
> 2>&1 >> $TS_OUTPUT
> in many tests.
>
> I am not sure, whether it does what is expected:
>
> 2>&1 >> $TS_OUTPUT
> which does:
> Redirect stdout to $TS_OUTPUT and redirect stderr to stdout.
>
> I guess that it is most probably intended to be:
> >> $TS_OUTPUT 2>&1
>
> which does:
> Redirect stdout and stderr to $TS_OUTPUT.
>
> Here is a global fix:
> cd tests/ts
> sed -i 's:2>\&1 >> \$TS_OUTPUT:>> $TS_OUTPUT 2>\&1:g' $(fgrep -rl
> '2>&1 >> $TS_OUTPUT' .)
>
> I ran a check, and it seems, that there could be some minor issues
> in:
>
> MD raid1 (whole-disks)
> mount-by-uuid
> mount-flags
> x-mount.mkdir
> fstab-label
> fstab-uuid
>
> The current version of redirection can cause false positive result of
> the test.

I remember that one day I was also about to fix that redirections. But 
after thinking about this for a while I've left it as it is. 
Unfortunately I don't remember why :)

Could be that sometimes we will get harmless warnings which should be 
ignored. Also a minor advantage was that our mount tests could survive 
running with LIBMOUNT_DEBUG=all.

Anyways, checking stderr too is IMO a good idea.

BTW I would even like to add checking return values of any used commands 
(not only for mount tests) like we did in 45eb5b29 for blkdiscard for 
example.

cu,
Rudi

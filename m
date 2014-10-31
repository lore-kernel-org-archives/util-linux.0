Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932130AbaJaJrf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 31 Oct 2014 05:47:35 -0400
Date: Fri, 31 Oct 2014 10:47:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] pull: couple corrections and bash completion fixes
Message-ID: <20141031094724.GT10134@x2.net.home>
References: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 26, 2014 at 10:07:05PM +0000, Sami Kerola wrote:
> # swapoff -U bf6237f4-db89-4761-a1a3-275cfc68b114 
> swapoff: cannot find the device for bf6237f4-db89-4761-a1a3-275cfc68b114
> # swapoff -L xyzzy 
> swapoff: cannot find the device for xyzzy
> 
> The problem seems to come from swapoff.c function do_swapoff() call to
> mnt_resolve_spec() that performs uuid and label matching only against
> block devices.  Unfortunately this was as far I got with an attempt to
> fix the issue.  Either someone else is quicker with the fix, or I'll have
> a look of this sometime after next 5 days.

Hmm... that's necessary to add fallback to swapoff if
mnt_resolve_spec() returns nothing and probe by libblkid all S_ISREG()
sources from get_swaps().

> Sami Kerola (4):
>   sfdisk: return deterministic value from sfdisk_deinit()
>   fstrim: initialize path variable
>   bash-completion: stop being clever when listing block devices
>   bash-completion: use swapon label and uuid listing support

 All applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

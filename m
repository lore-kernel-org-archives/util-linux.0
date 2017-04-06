Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753901AbdDFK2m (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 06:28:42 -0400
Date: Thu, 6 Apr 2017 12:28:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fix gpt for 32bit systems
Message-ID: <20170406102838.l6hz22ky3rtgdrew@ws.net.home>
References: <1491386189-8163-1-git-send-email-sweet_f_a@gmx.de>
 <201704051314.07435.sweet_f_a@gmx.de>
 <20170405165022.fniqgeng46ec4auf@ws.net.home>
 <201704051958.00857.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201704051958.00857.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 05, 2017 at 07:58:00PM +0200, Ruediger Meier wrote:
> > +	ssz = read(cxt->dev_fd, ret, sz);
> 
> The read(2) Linux manpage says: "If count is greater than SSIZE_MAX 
> (signed!), the result is unspecified."
> 
> So maybe we should limit gpt_sizeof_ents() regarding SSIZE_MAX rather 
> than SIZE_MAX. I guess that even smwaller sizes would not be possible 
> to load into memory.

OK, I have added SSIZE_MAX check before the read.

> I'm also not sure that such big-reads (without using read() in a loop) 
> are portable at all.

The area on disk is pretty small, and we read the entries array after
header checksum verification. So, the read(2) should no be affected by
corrupted disk and if someone has 44+ millions partitions then a random
read(2) issue is probably the smallest issue in his live... (we can
use read_all() from include/all-io.h, but I think it's overkill).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

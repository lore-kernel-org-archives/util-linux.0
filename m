Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965047AbdIZROk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 Sep 2017 13:14:40 -0400
Date: Tue, 26 Sep 2017 19:14:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] losetup: Add support for logical block size
Message-ID: <20170926171429.rgrwclkzokpo7363@ws.net.home>
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
 <20170926145712.qvfd4fta6u24x565@ws.net.home>
 <d7fb6e59-c7cd-2a58-ce0a-064e1398fd8b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d7fb6e59-c7cd-2a58-ce0a-064e1398fd8b@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 26, 2017 at 05:25:00PM +0200, Stanislav Brabec wrote:
> Karel Zak wrote:
> > On Tue, Sep 26, 2017 at 04:14:51PM +0200, Stanislav Brabec wrote:
> 
> >> References:
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/block/loop.c?id=89e4fdecb51cf5535867026274bc97de9480ade5
> > 
> > This kernel change has been reverted (1e6ec9ea89d30739b9447c1860fcb07fc29f3aef) after
> > discussion on LKML.
> 
> No, it was not. The reverted one is the previous implementation from
> Hannes Reinecke. It introduced new flag LO_FLAGS_BLOCKSIZE.

Ah, I've thought Omar postponed all the stuff for later. I see it in Linus'
tree now. Sorry.

> This losetup patch already uses the new implementation with the new
> ioctl(,LOOP_SET_BLOCK_SIZE,), including syntax changes caused by the new
> implementation. (The old implementation did not make possible "losetup
> --logical-blocksize=4096 /dev/loop0", the new one does.)

Yes, I've seen the patches in LKML, it's definitely better that the original
attempt.

I guess it's important enough and non-invasive that we can add the patch to
-rc2.

> Just an additional off topic note:
> I reserved 4 characters for the blocksize. I am not sure, whether it is
> sufficient, or whether kernel allows much larger logical blocks. (But
> actually, the real column width is determined by width of string
> "BLOCKSIZE").

The column width is hint only, libsmartcols should be smart enough to accept
longer strings there.

Thanks (and again sorry)! 

	Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

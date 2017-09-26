Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031076AbdIZO5V (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 Sep 2017 10:57:21 -0400
Date: Tue, 26 Sep 2017 16:57:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] losetup: Add support for logical block size
Message-ID: <20170926145712.qvfd4fta6u24x565@ws.net.home>
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 26, 2017 at 04:14:51PM +0200, Stanislav Brabec wrote:
> Kernel since 4.14 supports setting of logical block size[1]. It allows to
> create loop devices that report logical block size different from 512.
> 
> Add support for this feature to losetup.
> 
> References:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/block/loop.c?id=89e4fdecb51cf5535867026274bc97de9480ade5

This kernel change has been reverted (1e6ec9ea89d30739b9447c1860fcb07fc29f3aef) after
discussion on LKML.

	Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

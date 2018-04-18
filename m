Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752927AbeDRIWX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 18 Apr 2018 04:22:23 -0400
Date: Wed, 18 Apr 2018 10:22:19 +0200
From: Karel Zak <kzak@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: fix mnt_table_is_fs_mounted() for NFS bind
 mounts.
Message-ID: <20180418082219.yfq2pwq7qlztgn3x@ws.net.home>
References: <87po2xqjfp.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87po2xqjfp.fsf@notabene.neil.brown.name>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 18, 2018 at 01:31:38PM +1000, NeilBrown wrote:
> For nfs mounts, the fourth field is always "/", and the subdirectory
> part is appended to the "special" (aka "device") field.  This is
> consistent with historical NFS usage which always includes a path in
> the fs_spec field.

Interesting.

>  libmount/src/tab.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Applied with a minor change, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

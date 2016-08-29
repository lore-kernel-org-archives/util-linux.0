Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932745AbcH2Lrb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 29 Aug 2016 07:47:31 -0400
Date: Mon, 29 Aug 2016 13:36:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Avoid OOB access on illegal ZFS superblocks
Message-ID: <20160829113642.yt5bhtjjf775p3fm@ws.net.home>
References: <20160828191559.GA3110@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160828191559.GA3110@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 28, 2016 at 09:15:59PM +0200, Tobias Stoeckmann wrote:
>  libblkid/src/superblocks/zfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

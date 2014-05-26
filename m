Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbaEZKGW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 06:06:22 -0400
Date: Mon, 26 May 2014 12:06:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Stanislav Brabec <sbrabec@suse.cz>,
        Miklos Szeredi <mszeredi@suse.cz>
Subject: Re: [PATCH] libblkid: detect squashfs 3 vs 4
Message-ID: <20140526100612.GD2968@x2.net.home>
References: <1400581413-17456-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400581413-17456-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 20, 2014 at 10:23:33AM +0000, Ruediger Meier wrote:
>  libblkid/src/superblocks/squashfs.c    | 63 ++++++++++++++++++++++++++--------
>  libblkid/src/superblocks/superblocks.c |  1 +
>  libblkid/src/superblocks/superblocks.h |  1 +
>  3 files changed, 50 insertions(+), 15 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

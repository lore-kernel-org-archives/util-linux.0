Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752469AbeB1NIc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Feb 2018 08:08:32 -0500
Date: Wed, 28 Feb 2018 14:08:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Steve Kenton <skenton@ou.edu>, Jan Kara <jack@suse.cz>
Cc: util-linux@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 1/1] Update mount options for UDF
Message-ID: <20180228130828.j3wbez6pzzzeknuc@ws.net.home>
References: <20180227184407.5945-1-skenton@ou.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180227184407.5945-1-skenton@ou.edu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 27, 2018 at 12:44:07PM -0600, Steve Kenton wrote:
> Signed-off-by: Steve Kenton <skenton@ou.edu>
> Acked-by: Jan Kara <jack@suse.cz>
> ---
>  sys-utils/mount.8 | 89 +++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 67 insertions(+), 22 deletions(-)

Applied, thanks.

Jan, what about to create udf(5) man page? We already have fs-specific
man pages (e.g. ext4, tmpfs, nfs, btrfs, ...). It's usually maintained
within fs-specific tools (e.g. ext4 -> e2fsprogs) or together with
standard man-pages (CC: to Michael).

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

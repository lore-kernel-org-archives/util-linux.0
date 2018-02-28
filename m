Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:39608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbeB1NcV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Feb 2018 08:32:21 -0500
Date: Wed, 28 Feb 2018 14:32:20 +0100
From: Jan Kara <jack@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: Steve Kenton <skenton@ou.edu>, Jan Kara <jack@suse.cz>,
        util-linux@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/1] Update mount options for UDF
Message-ID: <20180228133220.3rmkcqnk6giry4bk@quack2.suse.cz>
References: <20180227184407.5945-1-skenton@ou.edu>
 <20180228130828.j3wbez6pzzzeknuc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228130828.j3wbez6pzzzeknuc@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed 28-02-18 14:08:28, Karel Zak wrote:
> On Tue, Feb 27, 2018 at 12:44:07PM -0600, Steve Kenton wrote:
> > Signed-off-by: Steve Kenton <skenton@ou.edu>
> > Acked-by: Jan Kara <jack@suse.cz>
> > ---
> >  sys-utils/mount.8 | 89 +++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 67 insertions(+), 22 deletions(-)
> 
> Applied, thanks.
> 
> Jan, what about to create udf(5) man page? We already have fs-specific
> man pages (e.g. ext4, tmpfs, nfs, btrfs, ...). It's usually maintained
> within fs-specific tools (e.g. ext4 -> e2fsprogs) or together with
> standard man-pages (CC: to Michael).

I'm fine with that. Pali is actually the maintainer of udf-tools so if he
is willing to take the manpage there, it's probably the best place.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

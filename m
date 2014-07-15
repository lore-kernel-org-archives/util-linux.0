Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758738AbaGOL2v (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 07:28:51 -0400
Date: Tue, 15 Jul 2014 13:28:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] cfdisk: restore the license that was lost in January
Message-ID: <20140715112846.GU30288@x2.net.home>
References: <1405371216-7774-1-git-send-email-bensberg@justemail.net>
 <1405371216-7774-3-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405371216-7774-3-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 14, 2014 at 10:53:36PM +0200, Benno Schulenberg wrote:
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  disk-utils/cfdisk.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
> index fb089f5..544e87a 100644
> --- a/disk-utils/cfdisk.c
> +++ b/disk-utils/cfdisk.c
> @@ -1,3 +1,17 @@
> +/*
> + * cfdisk.c - Display or manipulate a disk partition table.
> + *
> + *     Copyright (C) 2014 Karel Zak <kzak@redhat.com>
> + *     Copyright (C) 1994 Kevin E. Martin (martin@cs.unc.edu)

 Well, not sure if it's correct to blame Kevin for the new fdisk if
 all the new code is from scratch :-) ... but yes, all the details and
 ideas are the same with Kevin's version.

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

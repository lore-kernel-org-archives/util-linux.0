Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933688AbeAXOll (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 09:41:41 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Tobias Stc3b6ckmann <tobias@stoeckmann.org>
Subject: Re: [PATCH 2/7] fsck.cramfs: fix crash when superblock size is too small
Date: Wed, 24 Jan 2018 15:41:38 +0100
Cc: util-linux@vger.kernel.org
References: <20180123155928.7629-1-sweet_f_a@gmx.de> <20180123155928.7629-3-sweet_f_a@gmx.de> <30fb7d14-74fb-6021-169e-973dd8b3b37c@stoeckmann.org>
In-Reply-To: <30fb7d14-74fb-6021-169e-973dd8b3b37c@stoeckmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201801241541.38366.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 23 January 2018, Tobias Stc3b6ckmann wrote:
> > This hopefully fixes the original problem addressed by the reverted
> > patch 7cb962c7.
>
> It does.
>
> >  	/* What are valid superblock sizes? */
> > -	if (super.size < sizeof(struct cramfs_super))
> > +	if (super.size < *start + sizeof(struct cramfs_super))
>
> And this is a more elegant (and working) solution. I was not sure how
> much adjustment this if-statement can handle due to the comment.

The comment is a bit stupid. Actually super.size should be a multiple of 
PAGE_SIZE of the running kernel to be able to mount it on the current 
system. I've relaxed this requirement to be able to fsck a cramfs from 
other systems. This is IMO a nice feature because in real life cramfs 
will be created often on cross-compiler hosts to be deployed to another 
embedded system. Though maybe we should add a warning like "This image 
is not mountable on the current system".

>
> Thanks and sorry for the regression,

All fine, you discovered a bug I made. :)

> Tobias
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



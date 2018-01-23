Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.74]:49804 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeAWTlH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Jan 2018 14:41:07 -0500
Subject: Re: [PATCH 2/7] fsck.cramfs: fix crash when superblock size is too
 small
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
 <20180123155928.7629-3-sweet_f_a@gmx.de>
From: =?UTF-8?Q?Tobias_St=c3=b6ckmann?= <tobias@stoeckmann.org>
Message-ID: <30fb7d14-74fb-6021-169e-973dd8b3b37c@stoeckmann.org>
Date: Tue, 23 Jan 2018 20:41:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180123155928.7629-3-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> This hopefully fixes the original problem addressed by the reverted
> patch 7cb962c7.

It does.

>  	/* What are valid superblock sizes? */
> -	if (super.size < sizeof(struct cramfs_super))
> +	if (super.size < *start + sizeof(struct cramfs_super))

And this is a more elegant (and working) solution. I was not sure how
much adjustment this if-statement can handle due to the comment.


Thanks and sorry for the regression,

Tobias

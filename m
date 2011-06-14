Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12259 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189Ab1FNL33 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2011 07:29:29 -0400
Date: Tue, 14 Jun 2011 13:29:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/6] sfdisk: fix for data type mismatches
Message-ID: <20110614112919.GE14293@nb.net.home>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi> <1307387239-9022-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307387239-9022-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 06, 2011 at 09:07:19PM +0200, Sami Kerola wrote:
> +	if ((unsigned long) pno+4 >= ARRAY_SIZE(z->partitions)) {

 Why 'unsigned long'? I guess that ARRAY_SIZE returns size_t. Maybe it
 would be better to use size_t for partno numbers rather than add the
 cast.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

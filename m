Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934302AbcCPLho (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 07:37:44 -0400
Date: Wed, 16 Mar 2016 12:37:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] tests: fix fdisk/bsd for alpha
Message-ID: <20160316113741.cdm4hrufcoiki5ae@ws.net.home>
References: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 16, 2016 at 01:40:44AM +0100, Ruediger Meier wrote:
> BTW it was a bad idea to use md5sum. In case of failure it
> would be much easier to debug hexdump diffs. Now it's nearly
> impossible to collect all these exotic hexdumps.

 I'll try to prepare a new test with hexdump, PPC[64] LE/BE should 
 not be a problem. The rest we can gather later.

> CC: Andreas Henriksson <andreas@fatal.se>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  tests/ts/fdisk/bsd | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50285 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965414AbcCNPT2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 11:19:28 -0400
Date: Mon, 14 Mar 2016 16:19:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: Fix model and model name on Power Systems
Message-ID: <20160314151925.xlfo6kdxq4lj5tu2@ws.net.home>
References: <20160314144804.415.11481.stgit@hegdevasant>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160314144804.415.11481.stgit@hegdevasant>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 14, 2016 at 08:18:07PM +0530, Vasant Hegde wrote:
>   Model:                 2.1 (pvr 004b 0201)
>   Model name:            POWER8E (raw), altivec supported
>   ...
>   ...
> ---
>  sys-utils/lscpu.c |    5 +++++
>  1 file changed, 5 insertions(+)

Seems better. Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

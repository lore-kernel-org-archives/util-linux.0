Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47911 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab2EWJqf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 May 2012 05:46:35 -0400
Date: Wed, 23 May 2012 11:46:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 6/6] fdisk: add debug support
Message-ID: <20120523094608.GB1297@x2.net.home>
References: <1337530299.2677.17.camel@offbook>
 <1337632345.2596.7.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337632345.2596.7.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 21, 2012 at 10:32:25PM +0200, Davidlohr Bueso wrote:
>  fdisk/fdisk.c |    2 ++
>  fdisk/fdisk.h |   27 +++++++++++++++++++++++++++
>  fdisk/utils.c |   33 ++++++++++++++++++++++++++++++++-
>  3 files changed, 61 insertions(+), 1 deletions(-)

 Applied, thanks.

> +void fdisk_init_debug(int mask)
> +{
> +	if (fdisk_debug_mask & FDISK_DEBUG_INIT)
> +		return;
> +	if (!mask) {
> +		char *str = getenv("FDISK_DEBUG");
> +		if (str)
> +			fdisk_debug_mask = strtoul(str, 0, 0);
> +	} else
> +		fdisk_debug_mask = mask;
> +
> +	if (fdisk_debug_mask)
> +		printf("fdisk: debug mask set to 0x%04x.\n",
> +		       fdisk_debug_mask);

 this is bug (in libmount too), the message should be printed to
 stderr as all others debug messages.

 I have added dbgprint() inline function to standardize the output, so

> +		DBG(CONTEXT, printf("opened %s as read-only\n", fname));

 should be 

        DBG(CONTEXT, dbgprint("opened %s as read-only", fname));

 All the changes are already pushed to the repository.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

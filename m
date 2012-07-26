Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab2GZPHd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 11:07:33 -0400
Date: Thu, 26 Jul 2012 17:07:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>, dave@gnu.org
Subject: Re: [PATCH 1/5] fdisk: make grain global variable part of
 fdisk_context()
Message-ID: <20120726150728.GF21901@x2.net.home>
References: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 26, 2012 at 04:04:24PM +0200, Petr Uzel wrote:
> There is no reason for this to be global variable - it belongs
> to the context.

 Yes. Applied, thanks.

> diff --git a/fdisks/utils.c b/fdisks/utils.c
> index 19aed87..9b69de3 100644
> --- a/fdisks/utils.c
> +++ b/fdisks/utils.c
> @@ -488,6 +488,8 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
>  	__discover_topology(cxt);
>  	__discover_system_geometry(cxt);
>  
> +	cxt->grain = DEFAULT_SECTOR_SIZE;
> +

 This is unnecessary now, we call update_sector_offset() here. IMHO this
 function should be modified to contains non-DOS stuff only and
 renamed to update_alignment_info().

 But it would be nice to add label specific update_alignment() to
 fdisk_label struct. For DOS compatible mode we can set sector_offset
 and grain there.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

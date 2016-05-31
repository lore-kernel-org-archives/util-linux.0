Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53528 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbcEaLVJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 31 May 2016 07:21:09 -0400
Date: Tue, 31 May 2016 13:21:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck.minix: Verify more fields in super-block.
Message-ID: <20160531112106.gxkme4nhed4fdqvx@ws.net.home>
References: <20160529165658.GA7092@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160529165658.GA7092@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 29, 2016 at 06:56:58PM +0200, Tobias Stoeckmann wrote:

Applied, thanks.

> diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
> index aa64569..931658f 100644
> --- a/disk-utils/fsck.minix.c
> +++ b/disk-utils/fsck.minix.c
> @@ -573,8 +573,12 @@ read_superblock(void) {
>  		die(_("bad magic number in super-block"));
>  	if (get_zone_size() != 0 || MINIX_BLOCK_SIZE != 1024)
>  		die(_("Only 1k blocks/zones supported"));
> +	if (get_ninodes() == 0 || get_ninodes() == UINT32_MAX)
> +		die(_("bad s_ninodes field in super-block"));
>  	if (get_nimaps() * MINIX_BLOCK_SIZE * 8 < get_ninodes() + 1)
>  		die(_("bad s_imap_blocks field in super-block"));
> +	if (get_first_zone() > get_nzones())
> +		die(_("bad s_firstdatazone field in super-block"));

   if (get_first_zone() > (off_t) get_nzones())

seems better to keep compiler happy :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

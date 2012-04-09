Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pz0-f52.google.com ([209.85.210.52]:44555 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab2DIOM3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 Apr 2012 10:12:29 -0400
Received: by dake40 with SMTP id e40so5325538dak.11
        for <util-linux@vger.kernel.org>; Mon, 09 Apr 2012 07:12:28 -0700 (PDT)
Date: Mon, 9 Apr 2012 10:12:26 -0400
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: don't free fstab table on parse failure
Message-ID: <20120409141226.GA843@rampage>
References: <1332852838-6188-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332852838-6188-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 27, 2012 at 08:53:58AM -0400, Dave Reisner wrote:
> Even if we fail parsing, fstab gets referenced later in the code (and
> will subsequently crash via heap corruption). Take the easy way out and
> simply avoid deallocating this table, as it will be freed for us on
> program exit regardless.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---

Pinging this, as it doesn't seem it was merged...

d

> Crash reproducible with 'FSTAB_FILE=/dev/null fsck <any-blockdev>'
> 
>  disk-utils/fsck.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
> index a019a69..44200d0 100644
> --- a/disk-utils/fsck.c
> +++ b/disk-utils/fsck.c
> @@ -430,7 +430,6 @@ static void load_fs_info(void)
>  	path = getenv("FSTAB_FILE");
>  
>  	if (mnt_table_parse_fstab(fstab, path)) {
> -		mnt_free_table(fstab);
>  		if (!path)
>  			path = mnt_get_fstab_path();
>  		if (errno)
> -- 
> 1.7.9.4
> 

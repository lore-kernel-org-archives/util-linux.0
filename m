Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbdHNJIZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Aug 2017 05:08:25 -0400
Date: Mon, 14 Aug 2017 11:08:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] isosize: iterate over all arguments even when something
 fails
Message-ID: <20170814090821.qxqr4ill4ihtjlyc@ws.net.home>
References: <20170812083208.1208-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170812083208.1208-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 12, 2017 at 09:32:07AM +0100, Sami Kerola wrote:
> Earlier the command exit too early if one of the arguments failed.  After
> this change all arguments are examined, and command return value will have
> information what happen during processing.
> 
> $ isosize /etc/shadow / ; echo $?
> isosize: cannot open /etc/shadow: Permission denied
> isosize: /: might not be an ISO filesystem
> isosize: read error on /: Is a directory
> 14
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  disk-utils/isosize.8 | 24 ++++++++++++++++++++++++
>  disk-utils/isosize.c | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/disk-utils/isosize.8 b/disk-utils/isosize.8
> index 44ac124ea..225b0ae46 100644
> --- a/disk-utils/isosize.8
> +++ b/disk-utils/isosize.8
> @@ -32,6 +32,30 @@ filesystem can be marginally larger than the actual size of the
>  iso9660 filesystem.  One reason for this is that cd writers
>  are allowed to add "run out" sectors at the end of an iso9660
>  image.
> +.SH "EXIT STATUS"
> +Exit values are subject to bitwise inclusive or.  That means a return value
> +such as 14 means all of the 2, 4, 8 errors happen to some of the input
> +files.
> +.PP
> +.RS
> +.PD 0
> +.TP
> +.B 0
> +Success.
> +.TP
> +.B 1
> +Generic error, such as invalid usage.
> +.TP
> +.B 2
> +Could not open input file.
> +.TP
> +.B 4
> +Invalid ISO header.
> +.TP
> +.B 8
> +Size could not be read.
> +.PD
> +.RE
>  .SH AVAILABILITY
>  The isosize command is part of the util-linux package and is available from
>  .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
> diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
> index 5fbbbfc76..dfb2c4ca9 100644
> --- a/disk-utils/isosize.c
> +++ b/disk-utils/isosize.c
> @@ -30,6 +30,12 @@
>  #include "strutils.h"
>  #include "closestream.h"
>  
> +enum {
> +	EXIT_OPEN = 2,
> +	EXIT_HEADER = 4,
> +	EXIT_READ = 8
> +};

Seems like overkill, why we need so specific information? I guess it
would be enough

    0 - EXIT_SUCCESS
    1 - EXIT_FAILURE
   64 - EXIT_SOMEOK  (already used for mount, lsblk, kill, ...)

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

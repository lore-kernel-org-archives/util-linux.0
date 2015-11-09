Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39542 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbbKIInb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 03:43:31 -0500
Date: Mon, 9 Nov 2015 09:43:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/12] script, hwclock: check file exist with access(3)
 rather than stat(3)
Message-ID: <20151109084329.GN19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
 <1446319284-24778-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446319284-24778-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 31, 2015 at 07:21:17PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/hwclock.c | 5 +----
>  term-utils/script.c | 3 +--
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 4b201d7..0d11061 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -258,15 +258,12 @@ hw_clock_is_utc(const bool utc, const bool local_opt,
>  static int read_adjtime(struct adjtime *adjtime_p)
>  {
>  	FILE *adjfile;
> -	int rc;			/* local return code */
> -	struct stat statbuf;	/* We don't even use the contents of this. */
>  	char line1[81];		/* String: first line of adjtime file */
>  	char line2[81];		/* String: second line of adjtime file */
>  	char line3[81];		/* String: third line of adjtime file */
>  	long timeval;
>  
> -	rc = stat(adj_file_name, &statbuf);
> -	if (rc < 0 && errno == ENOENT) {
> +	if (access(adj_file_name, R_OK) != 0) {

Not sure, but I remember reports from people who use suid hwclock.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755Ab1LPKn7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Dec 2011 05:43:59 -0500
Date: Fri, 16 Dec 2011 11:43:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 1/2] findmnt: use warnx for libmnt error callback
Message-ID: <20111216104353.GD25486@nb.net.home>
References: <1323629885-17940-1-git-send-email-dreisner@archlinux.org> <1323629885-17940-2-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323629885-17940-2-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 11, 2011 at 01:58:04PM -0500, Dave Reisner wrote:
>  misc-utils/findmnt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
> index 9c2b9fc..4577dc6 100644
> --- a/misc-utils/findmnt.c
> +++ b/misc-utils/findmnt.c
> @@ -484,7 +484,7 @@ leave:
>  static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
>  			const char *filename, int line)
>  {
> -	warn(_("%s: parse error at line %d"), filename, line);
> +	warnx(_("%s: parse error at line %d"), filename, line);

Oh.. yes, errno does not make sense here. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

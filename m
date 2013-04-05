Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4816 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161483Ab3DEMFH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 5 Apr 2013 08:05:07 -0400
Date: Fri, 5 Apr 2013 14:04:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/13] setarch: add option to list settable architectures
Message-ID: <20130405120457.GD14350@x2.net.home>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
 <1364931777-2645-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364931777-2645-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 02, 2013 at 08:42:53PM +0100, Sami Kerola wrote:
>  sys-utils/setarch.8 |  3 +++
>  sys-utils/setarch.c | 18 +++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)

 Applied, thanks.

> @@ -110,6 +110,8 @@ show_help(void)
>     " -3, --3gb                limits the used address space to a maximum of 3 GB\n"
>     "     --4gb                ignored (for backward compatibility only)\n"
>     "     --uname-2.6          turns on UNAME26\n"));
> +   printf(_(
> +   "     --list               list settable architectures, and exit\n"));
>  
>    printf(USAGE_SEPARATOR);
>    printf(USAGE_HELP);
> @@ -136,7 +138,7 @@ show_version(void)
>  }

 It would be nice to cleanup the usage() for 2.24 release.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

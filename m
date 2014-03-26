Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2867 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbaCZLTQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Mar 2014 07:19:16 -0400
Date: Wed, 26 Mar 2014 12:19:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] findfs: use symbolic exit values, and tell about
 them in manual
Message-ID: <20140326111906.GD23464@x2.net.home>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 09, 2014 at 03:30:14PM -0500, Sami Kerola wrote:
>  include/exitcodes.h |  5 +++++
>  misc-utils/findfs.8 | 30 ++++++++++++++++++++++++++----
>  misc-utils/findfs.c | 13 +++++++------
>  3 files changed, 38 insertions(+), 10 deletions(-)

 Applied, thanks.

> --- a/include/exitcodes.h
> +++ b/include/exitcodes.h
> @@ -32,4 +32,9 @@
>  #define MOUNT_EX_FAIL		32	/* mount failure */
>  #define MOUNT_EX_SOMEOK		64	/* some mount succeeded */
>  
> +/* Exit codes used by findfs. */
> +#define FINDFS_SUCCESS		0	/* no errors */
> +#define FINDFS_NOT_FOUND	1	/* label or uuid cannot be found */
> +#define FINDFS_USAGE_ERROR	2	/* user did something unexpected */

 I don't think it's necessary to have the codes in include/ as it is
 not shared between more utils. Fixed.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

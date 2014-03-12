Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbaCLKhX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Mar 2014 06:37:23 -0400
Date: Wed, 12 Mar 2014 11:37:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] findfs: use symbolic exit values, and tell about
 them in manual
Message-ID: <20140312103712.GK9303@x2.net.home>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 09, 2014 at 03:30:14PM -0500, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/exitcodes.h |  5 +++++
>  misc-utils/findfs.8 | 30 ++++++++++++++++++++++++++----
>  misc-utils/findfs.c | 13 +++++++------
>  3 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/include/exitcodes.h b/include/exitcodes.h
> index 24ee123..fc893f1 100644
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

 Do we really need to add findfs exit codes to exitcodes.h? The
 codes are specific to findfs and no shared anywhere.

 It would be also better to use FINDFS_EX_{SUCCESS,NOTFOUND,USAGE}.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

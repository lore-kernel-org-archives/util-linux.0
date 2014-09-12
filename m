Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbaILJOX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Sep 2014 05:14:23 -0400
Date: Fri, 12 Sep 2014 11:14:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/17] mountpoint: add struct mountpoint_control
Message-ID: <20140912091411.GU21325@x2.net.home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
 <1410093785-17537-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410093785-17537-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 07, 2014 at 01:42:57PM +0100, Sami Kerola wrote:
> This unifies variable names in different functions, and removes redundant
> stat() calls.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/mountpoint.c | 86 ++++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 45 deletions(-)
> 
> diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
> index 3919ab7..3392cdd 100644
> --- a/sys-utils/mountpoint.c
> +++ b/sys-utils/mountpoint.c
> @@ -40,9 +40,17 @@
>  #include "closestream.h"
>  #include "pathnames.h"
>  
> -static int quiet;
> +struct mountpoint_control {
> +	char *devname;

 This member name makes the code difficult to read, on many places it's
 not device at all. Please, use "path" or "spec" rather then "devname".

> +	dev_t dev;
> +	struct stat st;
> +	uint8_t
> +		dev_devno:1,
> +		fs_devno:1,
> +		quiet:1;
> +};

 Use "unsigned int" for bit fields, it's compiler business to optimize
 how the bits are packed in the struct.


C99, 6.7.2.1 Structure and union specifiers

 A bit-field shall have a type that is a qualified or unqualified
 version of _Bool, signed int, unsigned int, or some other
 implementation-defined type.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

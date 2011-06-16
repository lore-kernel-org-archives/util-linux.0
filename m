Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757428Ab1FPPyF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 11:54:05 -0400
Date: Thu, 16 Jun 2011 17:54:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] uuid: implement uuid_generate_random_safe
Message-ID: <20110616155400.GB5352@nb.redhat.com>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de> <1308232779-21018-2-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308232779-21018-2-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 16, 2011 at 03:59:37PM +0200, Ludwig Nussel wrote:
> uuid_generate_random_safe() cannot really fail but it may use a weak
> random number generator as fallback.
> ---
>  libuuid/src/gen_uuid.c |   32 +++++++++++++++++++++++++++++---
>  libuuid/src/uuid.h     |    4 +++-
>  libuuid/src/uuid.sym   |    2 ++
>  misc-utils/uuidgen.c   |   10 ++++++++--
>  4 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
> index f4c8997..0c81a5c 100644
> --- a/libuuid/src/gen_uuid.c
> +++ b/libuuid/src/gen_uuid.c
> @@ -693,6 +693,18 @@ void uuid_generate_random(uuid_t out)
>  	__uuid_generate_random(out, &num);
>  }
>  
> +int uuid_generate_random_safe(uuid_t out)
> +{
> +	int	num = 1;
> +	/* No real reason to use the daemon for random uuid's -- yet */
> +
> +	if (get_random_fd() < 0)
> +		return -1;
> +
> +	__uuid_generate_random(out, &num);
> +	return 0;
> +}
> +

 It would be nice to use the same concept for the *_random functions as
 we already use for the *_time functions. It means to rename
 __uuid_generate_random() to uuid_generate_random_generic().

>  /*
>   * This is the generic front-end to uuid_generate_random and
> @@ -700,10 +712,24 @@ void uuid_generate_random(uuid_t out)
>   * /dev/urandom is available, since otherwise we won't have
>   * high-quality randomness.
>   */
> -void uuid_generate(uuid_t out)
> +static int _uuid_generate(uuid_t out)

 rename to: static int uuid_generate_genetic()

> +void uuid_generate(uuid_t out)
> +{
> +	(void)_uuid_generate(out);

 Don't use "(void)" in the code :-) It's unnecessary.

> +int uuid_generate_time_safe(uuid_t out) __attribute__((warn_unused_result));
> +int uuid_generate_random_safe(uuid_t out) __attribute__((warn_unused_result));
> +int uuid_generate_safe(uuid_t out) __attribute__((warn_unused_result));

 Good idea, but is warn_unused_result supported in old gcc versions?
 See include/c.h where we have __GNUC_PREREQ stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

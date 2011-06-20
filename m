Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692Ab1FTKfx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 06:35:53 -0400
Date: Mon, 20 Jun 2011 12:35:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] uuid: use new functions by default
Message-ID: <20110620103548.GB17967@nb.net.home>
References: <1308232779-21018-1-git-send-email-ludwig.nussel@suse.de> <1308232779-21018-3-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308232779-21018-3-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 16, 2011 at 03:59:38PM +0200, Ludwig Nussel wrote:
> -void uuid_generate(uuid_t out);
> -void uuid_generate_random(uuid_t out);
> -void uuid_generate_time(uuid_t out);
>  int uuid_generate_time_safe(uuid_t out) __attribute__((warn_unused_result));
>  int uuid_generate_random_safe(uuid_t out) __attribute__((warn_unused_result));
>  int uuid_generate_safe(uuid_t out) __attribute__((warn_unused_result));
> +#ifdef LIBUUID_UNSAFE_LEGACY_PROTOTYPES
> +void uuid_generate(uuid_t out) __attribute__((deprecated));
> +void uuid_generate_random(uuid_t out) __attribute__((deprecated));
> +void uuid_generate_time(uuid_t out) __attribute__((deprecated));
> +#else
> +static inline int uuid_generate_time(uuid_t out) { return uuid_generate_time_safe(out); }
> +static inline int uuid_generate_random(uuid_t out) { return uuid_generate_random_safe(out); }
> +static inline int uuid_generate(uuid_t out) { return uuid_generate_safe(out); }
> +#endif

 Oh, <censored> ... :-)

 Please, move this change to your (SAP) applications. I really don't
 want to mess up the library API for a reason which is completely
 irrelevant for 99% of all users.

 I don't think that overwrite any exported symbols with in-line
 functions is a good way how maintain any API. 
 
 I don't see a problem to support the *_safe functions for you, but
 don't force us to use it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

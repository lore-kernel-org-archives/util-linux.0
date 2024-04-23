Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFF5FB9C
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867583; cv=none; b=GNL6TpIT+GFtKB+6WTAmyn0qR65FXKnmAyYYq6VfhaVaQ/LIYI91MROhjFPsi2r6yqT5C6RMx57nFVC60n4YhVzETnt05Ok8CCfRGvOJBqoqe2uHHDu1LiO7HeOYrj2zPajr7BLHwl74y8oAyp100k6JkSE4GOZN1gdY6vUunRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867583; c=relaxed/simple;
	bh=9dozYjXbsXlH2ntA/XwaOzQ96HvssPfFfU8SESA3K84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0n8Wx6uLotvNh85jyUVkZ3BPhMShE1qe0QuAkS40UwBm+l1XF9DrvB17cAM2zNH20Zxnxfa1Cgn4ISext1oXmeWo0CgA2DhJafGJyFuzD6V3OL6GdcyEDCHMdWxN7OjlOEtjG4uGp4mCD59JKG9rqWoY1H+6fhmSCtu3/e6ciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=GJyzgRzL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="GJyzgRzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1713867577; bh=9dozYjXbsXlH2ntA/XwaOzQ96HvssPfFfU8SESA3K84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJyzgRzLMX/Vk2VgYynE/317rWfeYBVM5Sd0PxqQID6nM42i1lJ+AYvLzDew02n8d
	 HTFwjIjiPDxWCAabpF73gK29VkGoTg9U8hSBzap0hqqLYRHXKjYUiQrgLICaiQ8stq
	 thV0KETwJw4FRebYrrzh7qyapk/GkoADNUx+LXIs=
Date: Tue, 23 Apr 2024 12:19:37 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Thijs Raymakers <thijs@raymakers.nl>
Cc: kzak@redhat.com, util-linux@vger.kernel.org, 
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v9] coresched: Manage core scheduling cookies for tasks
Message-ID: <df7a25a0-7923-4f8b-a527-5e6f0064074d@t-8ch.de>
References: <20240417103138.g3bk5zamemhx6xm2@ws.net.home>
 <20240417113932.14237-1-thijs@raymakers.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417113932.14237-1-thijs@raymakers.nl>

On 2024-04-17 13:39:32+0000, Thijs Raymakers wrote:
> Co-authored-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Thijs Raymakers <thijs@raymakers.nl>
> ---
> 
> Hi Karel,
> 
> Thanks for taking a look at it! Here is the version that addresses the
> man page comments that Phil made.
> 
> Thijs

[..]

> diff --git a/schedutils/coresched.c b/schedutils/coresched.c
> new file mode 100644
> index 000000000..bb97cc020
> --- /dev/null
> +++ b/schedutils/coresched.c
> @@ -0,0 +1,358 @@
> +/**
> + * SPDX-License-Identifier: EUPL-1.2
> + *
> + * coresched.c - manage core scheduling cookies for tasks
> + *
> + * Copyright (C) 2024 Thijs Raymakers, Phil Auld
> + * Licensed under the EUPL v1.2
> + */
> +
> +#include <getopt.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <sys/prctl.h>
> +#include <unistd.h>
> +
> +#include "c.h"
> +#include "closestream.h"
> +#include "nls.h"
> +#include "strutils.h"
> +
> +// These definitions might not be defined in the header files, even if the
> +// prctl interface in the kernel accepts them as valid.
> +#ifndef PR_SCHED_CORE
> +	#define PR_SCHED_CORE 62
> +#endif
> +#ifndef PR_SCHED_CORE_GET
> +	#define PR_SCHED_CORE_GET 0
> +#endif
> +#ifndef PR_SCHED_CORE_CREATE
> +	#define PR_SCHED_CORE_CREATE 1
> +#endif
> +#ifndef PR_SCHED_CORE_SHARE_TO
> +	#define PR_SCHED_CORE_SHARE_TO 2
> +#endif
> +#ifndef PR_SCHED_CORE_SHARE_FROM
> +	#define PR_SCHED_CORE_SHARE_FROM 3
> +#endif
> +#ifndef PR_SCHED_CORE_SCOPE_THREAD
> +	#define PR_SCHED_CORE_SCOPE_THREAD 0
> +#endif
> +#ifndef PR_SCHED_CORE_SCOPE_THREAD_GROUP
> +	#define PR_SCHED_CORE_SCOPE_THREAD_GROUP 1
> +#endif
> +#ifndef PR_SCHED_CORE_SCOPE_PROCESS_GROUP
> +	#define PR_SCHED_CORE_SCOPE_PROCESS_GROUP 2
> +#endif
> +
> +typedef int sched_core_scope;
> +typedef unsigned long sched_core_cookie;

This should be uint64_t, as the kernel will always copy 64 bytes.

Otherwise it will smash the stack on 32bit:

https://download.copr.fedorainfracloud.org/results/packit/util-linux-util-linux-2990/fedora-rawhide-i386/07339240-util-linux/builder-live.log.gz

> +typedef enum {
> +	SCHED_CORE_CMD_GET,
> +	SCHED_CORE_CMD_NEW,
> +	SCHED_CORE_CMD_COPY,
> +} sched_core_cmd;
> +
> +struct args {
> +	pid_t src;
> +	pid_t dest;
> +	sched_core_scope type;
> +	sched_core_cmd cmd;
> +	int exec_argv_offset;
> +};
> +

[..]

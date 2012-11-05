Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab2KEQtZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Nov 2012 11:49:25 -0500
Date: Mon, 5 Nov 2012 17:49:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/13] ipcs: determine ipc limits from /proc
Message-ID: <20121105164915.GC3799@x2.net.home>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
 <1350246145-10600-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350246145-10600-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 14, 2012 at 09:22:15PM +0100, Sami Kerola wrote:
> +static int shmctl_limits_wrapper(struct proc_limits *lim, int use_proc)

 The basic rule is to call function by functionality, nobody cares if
 the function is wrapper ;-)

 IMHO for example ipc_shm_get_limits() is better.

> +{
> +	struct shminfo shminfo;
> +	lim->shmmax = SHMMAX;

 really no, shmmax is also in /proc and it maybe changed by sysctl.

> +	lim->shmmin = SHMMIN;
> +	if (use_proc) {
> +		FILE *f;
> +		if ((f = fopen(_PATH_PROC_IPC_SHMMNI, "r")) == NULL)
> +			return 1;
> +		fscanf(f, "%d", &(lim->shmmni));
> +		fclose(f);
> +		if ((f = fopen(_PATH_PROC_IPC_SHMALL, "r")) == NULL)
> +			return 1;
> +		fscanf(f, "%zu", &(lim->shmall));
> +		fclose(f);
> +		return 0;
> +	}
> +

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

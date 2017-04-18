Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdDRJXd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Apr 2017 05:23:33 -0400
Date: Tue, 18 Apr 2017 11:23:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: Ensure utab.lock mode 644
Message-ID: <20170418092328.rnyzxw2w7f6hc3r5@ws.net.home>
References: <e837973e-9f84-827f-ba86-1799d291bf8b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e837973e-9f84-827f-ba86-1799d291bf8b@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 11, 2017 at 04:12:52PM +0200, Stanislav Brabec wrote:
> If utab.lock is created by a process with a restricted umask, utab.lock is
> created with restricted permissions. It breaks userspace monitor.
> 
> Ensure that the mode is always 644.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  libmount/src/lock.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/libmount/src/lock.c b/libmount/src/lock.c
> index 06eff1344..f9d0253fb 100644
> --- a/libmount/src/lock.c
> +++ b/libmount/src/lock.c
> @@ -220,6 +220,11 @@ static int lock_simplelock(struct libmnt_lock *ml)
>  		rc = -errno;
>  		goto err;
>  	}
> +	rc = fchmod(ml->lockfile_fd, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
> +	if (rc < 0) {
> +		rc = -errno;
> +		goto err;
> +	}

Hmm... interesting issue. systemd?

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

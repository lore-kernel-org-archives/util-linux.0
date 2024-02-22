Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6423747
	for <util-linux@vger.kernel.org>; Thu, 22 Feb 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593544; cv=none; b=MXveuEygbirKqQD+DiOfMj0lI34tarGFBPcULDmthGk7nUf8C5kTsrwBROEWGj7LU/g7rP4drThw3DuSGKzd/LudWf9V6WF1Ekg04Nrfj3F8IART5J7nIyGDrliZ8oLphXNZ1n1dyIVXMDUoc9+Bix+I9FRFtNtPoG1pQjGcWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593544; c=relaxed/simple;
	bh=CA8EB6z3qi12xMI992le1E5/6KxMAd8C14Lgu+AQcpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2siL7xRviPU968pRRoj6il+udzHXNL1Lw26X2ZysijzV9rG/mhXmVKRyvr5CoK5xEs+zXqewPZfS3I1OL+mC9F68KdiIkpp7VAD3S7WLjPhTy6tWmSWbdtPTsWVCrk3uKudLPBwkIHdwVr/W290FR+FpheI+Ta0+X+2LXVFRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esAnehCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esAnehCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B837DC433F1;
	Thu, 22 Feb 2024 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708593543;
	bh=CA8EB6z3qi12xMI992le1E5/6KxMAd8C14Lgu+AQcpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esAnehCEcTDudGly03dGryHtWnpS4lafb6WYrnll/eiwNfEkRTUpeK39M9vqVeivP
	 EB4vPUtApNKGOGq9wf0dc/n72psQNSLsMXBWdGsU1XYDN2ojSU4HOwNqHj0KL86lUE
	 XwZW9rTootekwRAh7ePuWd3J+LvhvvMURG4sZOhQG63D1TswAl2ny9rtZgmMr78Ppo
	 TF/yY7Bnid9W8ksLBHp7At4/L+5VxV1Ntv4RP1k4MNhHT/ntLCcY2FnbLnD5dNdqUo
	 YLF+jEZtlrT4BHdsmQxSbK4JTufGddylp8MofgF48o6H2zKQ77CXCQWboOwbvtZp0u
	 GkSuOxQ7rzkmQ==
Date: Thu, 22 Feb 2024 10:19:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: util-linux@vger.kernel.org, JunChao Sun <sunjunchao2870@gmail.com>
Subject: Re: [PATCH] libmount: don't hold write fd to mounted device
Message-ID: <20240222-gasbetrieben-dadurch-ed43089ca1e3@brauner>
References: <20240221173050.21970-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221173050.21970-1-jack@suse.cz>

On Wed, Feb 21, 2024 at 06:30:50PM +0100, Jan Kara wrote:
> Avoid holding writeable fd to a loop device that is being mounted. In
> the hardened configurations (CONFIG_BLK_DEV_WRITE_MOUNTED = n) the
> kernel wants to make sure nobody else has the block device writeably
> open when mounting so this makes the mount fail.
> 
> Reported-by: JunChao Sun <sunjunchao2870@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Sounds good!
Acked-by: Christian Brauner <brauner@kernel.org>

>  libmount/src/hook_loopdev.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/libmount/src/hook_loopdev.c b/libmount/src/hook_loopdev.c
> index 8c8f7f218732..e2114b0cbebe 100644
> --- a/libmount/src/hook_loopdev.c
> +++ b/libmount/src/hook_loopdev.c
> @@ -356,15 +356,19 @@ success:
>  			 */
>  			mnt_optlist_append_flags(ol, MS_RDONLY, cxt->map_linux);
>  
> -		/* we have to keep the device open until mount(1),
> -		 * otherwise it will be auto-cleared by kernel
> +		/*
> +		 * We have to keep the device open until mount(1), otherwise it
> +		 * will be auto-cleared by kernel. However we don't want to
> +		 * keep writeable fd as kernel wants to block all writers to
> +		 * the device being mounted (in the more hardened
> +		 * configurations). So grab read-only fd instead.
>  		 */
> -		hd->loopdev_fd = loopcxt_get_fd(&lc);
> +		hd->loopdev_fd = open(lc.device, O_RDONLY | O_CLOEXEC);
>  		if (hd->loopdev_fd < 0) {
> -			DBG(LOOP, ul_debugobj(cxt, "failed to get loopdev FD"));
> +			DBG(LOOP,
> +			    ul_debugobj(cxt, "failed to reopen loopdev FD"));
>  			rc = -errno;
> -		} else
> -			loopcxt_set_fd(&lc, -1, 0);
> +		}
>  	}
>  done:
>  	loopcxt_deinit(&lc);
> -- 
> 2.35.3
> 

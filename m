Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A71224D9
	for <util-linux@vger.kernel.org>; Thu,  4 Jan 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQ/EVk/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704370355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQsAghu4ztpGgEyQ1bEPbcIL5DFz/FO9ToMtyz2dvxk=;
	b=JQ/EVk/vP+GIuDGsKA9zBgiDO5oK8bcN/ZkuvWCzg0CqLsmOCrj1EH8YG5Hei1H9EuWnB7
	2VeVB4e60A3hSAeddpV0m8TXKceYeGxYTkutpK8NzIfrBHITbBrWoioMDIx2ueGhCl7sRm
	bD6xt7HOlnLpUpEighLMV6NkIpBDLZk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-Jnt2ZuNuOaq69vDwvYZzig-1; Thu,
 04 Jan 2024 07:12:33 -0500
X-MC-Unique: Jnt2ZuNuOaq69vDwvYZzig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4946B3C23FC3;
	Thu,  4 Jan 2024 12:12:33 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CA2D7492BE6;
	Thu,  4 Jan 2024 12:12:32 +0000 (UTC)
Date: Thu, 4 Jan 2024 13:12:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Michael Trapp <michael.trapp@sap.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidd: add cont_clock persistence
Message-ID: <20240104121230.3bi7nt52tb3fu6ww@ws.net.home>
References: <20231215221829.46932-1-michael.trapp@sap.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215221829.46932-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Fri, Dec 15, 2023 at 11:18:29PM +0100, Michael Trapp wrote:
> cont_clock requires a correct time setup and therefore it
> must be possible to detect a step back between uuidd starts.
> 
> Reserving the next 10 seconds in clock-cont.txt is sufficient
> and should not have a noticeable performance impact.
> It will also provide the possibility to start with the clock_reg
> from the previous session when the system was rebooted.
> 
> Whith that, the early cont_clock initialization in uuidd
> should be removed because writing the cont_clock persitence
> when -C was not set is useless and might be confusing.

Hi Michael, 

that is an interesting idea; I have only a few pedantic notes ;-)

> ---
>  libuuid/src/gen_uuid.c | 78 ++++++++++++++++++++++++++++++++++++------
>  libuuid/src/uuidP.h    |  1 +
>  misc-utils/uuidd.c     |  9 -----
>  3 files changed, 69 insertions(+), 19 deletions(-)
> 
> diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
> index 826cd2245..94b99f1bd 100644
> --- a/libuuid/src/gen_uuid.c
> +++ b/libuuid/src/gen_uuid.c
> @@ -355,44 +355,102 @@ static uint64_t get_clock_counter(void)
>  /*
>   * Get continuous clock value.
>   *
> - * Return -1 if there is no further clock counter available,
> + * Return -1 if there is no valid clock counter available,
>   * otherwise return 0.
>   *
>   * This implementation doesn't deliver clock counters based on
>   * the current time because last_clock_reg is only incremented
>   * by the number of requested UUIDs.
>   * max_clock_offset is used to limit the offset of last_clock_reg.
> + * used/reserved UUIDs are written to LIBUUID_CLOCK_CONT_FILE.
>   */
>  static int get_clock_cont(uint32_t *clock_high,
>  			  uint32_t *clock_low,
>  			  int num,
>  			  uint32_t max_clock_offset)
>  {
> -	/* 100ns based time offset according to RFC 4122. 4.1.4. */
> +	/* all 64bit clock_reg values in this function represent '100ns ticks'
> +         * due to the combination of tv_usec + MAX_ADJUSTMENT */
> +
> +	enum { fd_init = -2, fd_error = -1 };

In the code (below) the enum items seems like variables, a little bit
confusing. It would be better use upper-case, STATE_FD_INIT, STATE_FD_ERROR.

> +	/* time offset according to RFC 4122. 4.1.4. */
>  	const uint64_t reg_offset = (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
>  	static uint64_t last_clock_reg = 0;
> -	uint64_t clock_reg;
> +	static uint64_t saved_clock_reg = 0;
> +	static int state_fd = fd_init;
> +	static FILE *state_f = NULL;
> +	uint64_t clock_reg, next_clock_reg;
>  
> -	if (last_clock_reg == 0)
> -		last_clock_reg = get_clock_counter();
> +	if (state_fd == fd_error)
> +		return -1;
>  
>  	clock_reg = get_clock_counter();
> +
> +	if (state_fd == fd_init) {
> +		mode_t save_umask;
> +		struct stat st;
> +
> +		save_umask = umask(0);
> +		state_fd = open(LIBUUID_CLOCK_CONT_FILE, O_RDWR|O_CREAT|O_CLOEXEC, 0660);
> +		(void) umask(save_umask);
> +		if (state_fd == fd_error)
> +			return -1;
> +
> +		state_f = fdopen(state_fd, "r+" UL_CLOEXECSTR);
> +		if (!state_f)
> +			goto error;

Seems it duplicates code from get_clock(), what about introduce a generic

    state_fd_init(LIBUUID_CLOCK_CONT_FILE, &state_fd, &state_f);

and use the same in get_clock() for LIBUUID_CLOCK_FILE?

> +		if (fstat(state_fd, &st))
> +			goto error;
> +
> +		if (st.st_size) {
> +			rewind(state_f);
> +			if (fscanf(state_f, "cont: %lu\n", &last_clock_reg) != 1)
> +				goto error;
> +		} else
> +			last_clock_reg = clock_reg;

For LIBUUID_CLOCK_FILE we use flock(), I guess it's unnecessary for
LIBUUID_CLOCK_CONT_FILE as we assume only one uuidd instance, right?

Thanks!
 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


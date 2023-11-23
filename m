Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4owWi+H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFC19E
	for <util-linux@vger.kernel.org>; Thu, 23 Nov 2023 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700731852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RliSo6SXK/gBmKt8JPEslwUfthZoYknEJkPRLlVRv7Q=;
	b=I4owWi+HxafFO3uYFSMQJJeEZZa3YnlRjFOJ1rOrrGW+8Siq9c1oJNqXGYw2mlDY6aGSal
	O9aVcCwyP6KfkIZjDR4W+j8sR/WP5nNWoLDr2X7mOL1aZHp2I429lh9jAgvOZLU3u2u0zg
	3n/QmdV0Fa6O+Jx7TxHO/4yvc7D82As=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-OEsdYQ7VMiiUX5Lz4uDo6g-1; Thu, 23 Nov 2023 04:30:48 -0500
X-MC-Unique: OEsdYQ7VMiiUX5Lz4uDo6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FC1F811E7D;
	Thu, 23 Nov 2023 09:30:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 721081121306;
	Thu, 23 Nov 2023 09:30:47 +0000 (UTC)
Date: Thu, 23 Nov 2023 10:30:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Rishabh Thukral <rthukral@arista.com>
Cc: util-linux@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] util-linux/sys-utils dmesg support for additional human
 readable timestamp
Message-ID: <20231123093045.c5cmdviyupxr2wn7@ws.net.home>
References: <20231110232612.10969-1-rthukral@arista.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110232612.10969-1-rthukral@arista.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


 Hi Rishabh,

sorry for delay

On Fri, Nov 10, 2023 at 03:26:12PM -0800, Rishabh Thukral wrote:
> This change updates the --time-format option in dmesg to enable the
> user to specify it multiple times with different formats with each

good idea

> input providing a timestamp format among the currently supported
> choices. This enables seeing the dmesg logs in both seconds since boot
> and human readable format simultaneously in each row of the log output.
> The sequence of timestamp format is fixed and independent of the order
> in which the user provides the desired formats.

and would be better to support arbitrary (user defined) order?

  ctl->time_fmts[ ctl->ntime_fmts++ ] = DMESG_TIMEFTM_FOO;
  ctl->time_fmts[ ctl->ntime_fmts++ ] = DMESG_TIMEFTM_BAR;

and print it by a simple loop

  for (i = 0; i < ctl->ntime_fmts; i++)
    switch (ctl->time_fmts[ i ]) {
       ...
    }

I guess the implementation will be more simple.

> -		if (ctl->time_fmt != DMESG_TIMEFTM_RELTIME) {
> +		if (ctl->time_fmts[DMESG_TIMEFTM_RELTIME] == TIMESTAMP_FMT_UNSET) {

This code pattern is used pretty often in your patch, maybe add macros

 #define is_timefmt_set(c, f)       ((c)->time_fmts[DMESG_TIMEFTM_ ##f] == TIMESTAMP_FMT_SET))
 #define is_timefmt_unset(c, f)     ((c)->time_fmts[DMESG_TIMEFTM_ ##f] == TIMESTAMP_FMT_UNSET))
 #define is_timefmt_initset(c, f)   ((c)->time_fmts[DMESG_TIMEFTM_ ##f] == TIMESTAMP_FMT_INIT_SET))

and use

  if (is_timefmt_set(ctl, RELTIME))

in code.

> @@ -1388,9 +1416,11 @@ int main(int argc, char *argv[])
>  		.action = SYSLOG_ACTION_READ_ALL,
>  		.method = DMESG_METHOD_KMSG,
>  		.kmsg = -1,
> -		.time_fmt = DMESG_TIMEFTM_TIME,

I guess you can use 

        .time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_INIT_SET,

>  		.indent = 0,
>  	};
> +	memset(ctl.time_fmts, 0,
> +		TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED * sizeof(*(ctl.time_fmts)));

You do not need memset() here. All unspecified struct fields in 'ctl'
are set zero according to C standards (if any other fields are
explicitly initialized).

> +	ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_INIT_SET;
>  	int colormode = UL_COLORMODE_UNDEF;
>  	enum {
>  		OPT_TIME_FORMAT = CHAR_MAX + 1,
> @@ -1475,7 +1505,9 @@ int main(int argc, char *argv[])
>  			ctl.action = SYSLOG_ACTION_CONSOLE_ON;
>  			break;
>  		case 'e':
> -			ctl.time_fmt = DMESG_TIMEFTM_RELTIME;
> +			if (ctl.time_fmts[DMESG_TIMEFTM_TIME] == TIMESTAMP_FMT_INIT_SET)
> +				ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_UNSET;
> +			ctl.time_fmts[DMESG_TIMEFTM_RELTIME] = TIMESTAMP_FMT_SET;

This complicated setup will be unnecessary if we will not need fixed
order, right? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


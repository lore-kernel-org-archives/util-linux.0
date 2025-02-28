Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6F276D11
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 01:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706469; cv=none; b=YvvzCk8KgHgas6MoXRoyyrnelcwfZuTKLDK1MYU4QxLvmk69fQ8AAoRmUUXVxZwqA3NmxPU+WCkzQoQ0KMg/jUE1LBmNrRA+pDRoa+LQxmjMhWXquZxSE6p9oLjt9GxU27Kvs3dkliktT8vq39eSEOaoLNGwbdsoPo5wQV45yAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706469; c=relaxed/simple;
	bh=CY62sEXepTzqfIYA6vKCkSyaunMM186vCTCsXfGib/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0+YqSa6c05TedsHIdUoa10ENYvlfR5m3NidtvsusyNzOJdvQTFYVpmO/c4nLDRVOQ1iXLZEEugFM6AukzkOi6PeGL/YUgMuvowN8N4aCiCnHytKPkY+3OzNBMlyDTp0zPp/XqJ5usHkzcFfFF2X8aqPizrrG2OKMxSBkNwxLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZRIrr2A4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZRIrr2A4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2feb9076a1cso1252073a91.0
        for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 17:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740706466; x=1741311266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZyL6tC/NwR7mGQsS5h0ezT0renCv/PRV0UUn9JF27Y=;
        b=ZRIrr2A4dRbC0phZSsvqG5jvk0jcvt89O9eDGxOS9hdsKuDIXlXajA84H02WgCfVqs
         D2AAG7K+4N2EqVDbb0Bu3UKFs0/ao6VxbrZNFfvh84EkuE9AukxPNdv5TM3N7rweL/R6
         2IrRocnjnlAGFCxaV1CJlo8eWekE1mY6vFDEPS43cv2B2mHDUbzsNfK/GeZoxOeAyNqk
         h1438mmd8Wc2TJmSGBiDDWC5YazwOT+3ALpnk7t8eUVu8QspdnZHLJ1eMDqZyzOsBBM/
         ZjuzO0Q0DQvl+MKyfBp8n/Q2o7fm5ApbLHPCC+v9594dIoI/+apnhQyEpzeWjKfp966J
         jugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740706466; x=1741311266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZyL6tC/NwR7mGQsS5h0ezT0renCv/PRV0UUn9JF27Y=;
        b=WfG141/5AGKfWwbww1lRZ30RIcpsnWWUK+V1adlTtz/3SOMNv10QDOxrWBXuV32h2J
         gkmndC006kc1hCi6DAfUkaEx/38y75dy9Bpzh9a59BFuTkxgXHO5ZBhTam3InkrrtVXo
         Osai64oU3956SlZwp7ZDjhayjthkFOzn0+wE/YC12ox9ikcg3RNx2ObSXY8F54an+alc
         UVRafRGcCJw8VpkcjcQdoIDWDeO73iAls+BOmJ+IEmnMWAAa6OtrdJCXLIDb7ZCJ0IMw
         11Ag5U7Am1Po9iRbi8phFJeXBboUiIgveHSU8MUzdaxNZe1PBBOD2bWlr89a4HwRCo9u
         E4Iw==
X-Gm-Message-State: AOJu0Yz3+vb25CmL/MAEs3A++JbCQhnxgALDaDyACscSS7hv2QHfVnlL
	mAVtYnIlKmTwadfPf/9O7RnSEtVHl+NdcQj2d7qpaLT9xkLLZleNWq8ZGVzXllY=
X-Gm-Gg: ASbGncuRz/ofN6K5pt6l/2Q9qeRTqnloxnWUVncRcX0jCVNbnkwC88JNqFe4fRLRjO+
	OHwmYWPLW/XBYz7H/6aqMLIRE9LiMtb1RDIvaYA5aEosy3+PmZ4bVyQbrW+BuYpjRGMA3qMSnXJ
	B2fSU9fKmVJ9k4FyTceyQtOas/W/4bw6vyv1OuEGvdKZI5dTcASpRaQawyZHCxhZyQGLk/js7vO
	R1SExKV4OWK2NcWvB9GumAC7yCCW6t2CUcbUhc4YJkTgtvonc+cSbv0VprjnDEHKKSCR9v2ReJE
	PjCZpzs/hoZ1TFyvLkzOR1Q2A2aGiccv
X-Google-Smtp-Source: AGHT+IHUcnvNtBWR2ENeezLVBTlQzoF+eexp5TJXRl3dVZ6wo7GCt/TtUVWHUAYiGVc1oMdr9U45tA==
X-Received: by 2002:a17:90b:4c11:b0:2ee:a4f2:b307 with SMTP id 98e67ed59e1d1-2febab2ebcfmr2506929a91.4.1740706466368;
        Thu, 27 Feb 2025 17:34:26 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8283c9d2sm4572106a91.35.2025.02.27.17.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 17:34:25 -0800 (PST)
Message-ID: <75000d2c-8f17-46b2-aabc-9cc5a3c97e2e@bytedance.com>
Date: Fri, 28 Feb 2025 09:34:22 +0800
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] irqtop: add batch mode support
To: Joe Jin <joe.jin@oracle.com>, Karel Zak <kzak@redhat.com>,
 Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-2-joe.jin@oracle.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20250227044916.89925-2-joe.jin@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joe,

I'm a little confused about 'batch'...

Rather than the original terminal formatted style, the new change brings 
'raw' style?

What about 'raw'? Hi Karel, what do you think of this?

On 2/27/25 12:49, Joe Jin wrote:
> Add batch mode support, which could be useful for sending output to
> other programs or to a file.
> 
> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Cc: Zhenwei Pi <pizhenwei@bytedance.com>
> Cc: Sami Kerola <kerolasa@iki.fi>
> ---
>   bash-completion/irqtop  |  6 +++-
>   sys-utils/irqtop.1.adoc |  3 ++
>   sys-utils/irqtop.c      | 79 ++++++++++++++++++++++++++++-------------
>   3 files changed, 63 insertions(+), 25 deletions(-)
> 
> diff --git a/bash-completion/irqtop b/bash-completion/irqtop
> index b9e454d4c..215281ee8 100644
> --- a/bash-completion/irqtop
> +++ b/bash-completion/irqtop
> @@ -5,6 +5,9 @@ _irqtop_module()
>   	cur="${COMP_WORDS[COMP_CWORD]}"
>   	prev="${COMP_WORDS[COMP_CWORD-1]}"
>   	case $prev in
> +		'-b'|'--batch')
> +			return 0
> +			;;
>   		'-c'|'--cpu-stat')
>   			COMPREPLY=( $(compgen -W "auto enable disable" -- $cur) )
>   			return 0
> @@ -40,7 +43,8 @@ _irqtop_module()
>   			return 0
>   			;;
>   	esac
> -	OPTS="	--cpu-stat
> +	OPTS="	--batch
> +		--cpu-stat
>   		--cpu-list
>   		--delay
>   		--sort
> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
> index 443e23b84..e81f4fbb6 100644
> --- a/sys-utils/irqtop.1.adoc
> +++ b/sys-utils/irqtop.1.adoc
> @@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
>   *-o*, *--output* _list_::
>   Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
>   
> +*-b*, *--batch*::
> +Starts irqtop in batch mode, which could be useful for sending output to other programs or to a file.
> +
>   *-c*, *--cpu-stat* _mode_::
>   Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*, *disable*. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enough to show a full line of statistics.
>   
> diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
> index 8fbedb16a..00bf8fe50 100644
> --- a/sys-utils/irqtop.c
> +++ b/sys-utils/irqtop.c
> @@ -83,10 +83,22 @@ struct irqtop_ctl {
>   	cpu_set_t *cpuset;
>   
>   	enum irqtop_cpustat_mode cpustat_mode;
> +	bool	batch;
>   	bool	request_exit,
>   		softirq;
>   };
>   
> +#define irqtop_batch_mode(ctl) ((ctl)->batch == true)
> +#define irqtop_printf(ctl, fmt, args...)		\
> +	do { 						\
> +		if (irqtop_batch_mode(ctl))		\
> +			fprintf(stdout, fmt, ##args);	\
> +		else {					\
> +			wprintw(ctl->win, fmt, ##args);	\
> +		}					\
> +	}while(0)
> +
> +
>   /* user's input parser */
>   static void parse_input(struct irqtop_ctl *ctl, struct irq_output *out, char c)
>   {
> @@ -128,16 +140,19 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>   			scols_table_enable_nowrap(cpus, 1);
>   	}
>   
> -	/* print header */
> -	move(0, 0);
>   	strtime_iso(&now, ISO_TIMESTAMP, timestr, sizeof(timestr));
> -	wprintw(ctl->win, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
> +	if (!irqtop_batch_mode(ctl))
> +		move(0, 0);
> +
> +	/* print header */
> +	irqtop_printf(ctl, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
>   			   stat->total_irq, stat->delta_irq, ctl->hostname, timestr);
>   
> +
>   	/* print cpus table or not by -c option */
>   	if (cpus) {
>   		scols_print_table_to_string(cpus, &data);
> -		wprintw(ctl->win, "%s\n\n", data);
> +		irqtop_printf(ctl, "%s\n\n", data);
>   		free(data);
>   	}
>   
> @@ -149,13 +164,15 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>   	if (p) {
>   		/* print header in reverse mode */
>   		*p = '\0';
> -		attron(A_REVERSE);
> -		wprintw(ctl->win, "%s\n", data);
> -		attroff(A_REVERSE);
> +		if (!irqtop_batch_mode(ctl))
> +			attron(A_REVERSE);
> +		irqtop_printf(ctl, "%s\n", data);
> +		if (!irqtop_batch_mode(ctl))
> +			attroff(A_REVERSE);
>   		data = p + 1;
>   	}
>   
> -	wprintw(ctl->win, "%s", data);
> +	irqtop_printf(ctl, "%s\n", data);
>   	free(data0);
>   
>   	/* clean up */
> @@ -212,7 +229,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
>   		err(EXIT_FAILURE, _("epoll_ctl failed"));
>   
>   	retval |= update_screen(ctl, out);
> -	refresh();
> +	if (!irqtop_batch_mode(ctl))
> +		refresh();
>   
>   	while (!ctl->request_exit) {
>   		const ssize_t nr_events = epoll_wait(efd, events, MAX_EVENTS, -1);
> @@ -227,10 +245,12 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
>   					continue;
>   				}
>   				if (siginfo.ssi_signo == SIGWINCH) {
> -					get_terminal_dimension(&ctl->cols, &ctl->rows);
> +					if (!irqtop_batch_mode(ctl)) {
> +						get_terminal_dimension(&ctl->cols, &ctl->rows);
>   #if HAVE_RESIZETERM
> -					resizeterm(ctl->rows, ctl->cols);
> +						resizeterm(ctl->rows, ctl->cols);
>   #endif
> +					}
>   				}
>   				else {
>   					ctl->request_exit = 1;
> @@ -245,7 +265,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
>   			} else
>   				abort();
>   			retval |= update_screen(ctl, out);
> -			refresh();
> +			if (!irqtop_batch_mode(ctl))
> +				refresh();
>   		}
>   	}
>   	return retval;
> @@ -260,6 +281,7 @@ static void __attribute__((__noreturn__)) usage(void)
>   	puts(_("Interactive utility to display kernel interrupt information."));
>   
>   	fputs(USAGE_OPTIONS, stdout);
> +	fputs(_(" -b, --batch batch mode\n"), stdout);
>   	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
>   	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
>   	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
> @@ -291,6 +313,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   {
>   	const char *outarg = NULL;
>   	static const struct option longopts[] = {
> +		{"batch", no_argument, NULL, 'b'},
>   		{"cpu-stat", required_argument, NULL, 'c'},
>   		{"cpu-list", required_argument, NULL, 'C'},
>   		{"delay", required_argument, NULL, 'd'},
> @@ -304,8 +327,11 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   	};
>   	int o;
>   
> -	while ((o = getopt_long(argc, argv, "c:C:d:o:s:St:hV", longopts, NULL)) != -1) {
> +	while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
>   		switch (o) {
> +		case 'b':
> +			ctl->batch = true;
> +			break;
>   		case 'c':
>   			if (!strcmp(optarg, "auto"))
>   				ctl->cpustat_mode = IRQTOP_CPUSTAT_AUTO;
> @@ -394,16 +420,18 @@ int main(int argc, char **argv)
>   
>   	parse_args(&ctl, &out, argc, argv);
>   
> -	is_tty = isatty(STDIN_FILENO);
> -	if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
> -		fputs(_("terminal setting retrieval"), stdout);
> +	if (ctl.batch == false) {
> +		is_tty = isatty(STDIN_FILENO);
> +		if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
> +			fputs(_("terminal setting retrieval"), stdout);
>   
> -	ctl.win = initscr();
> -	get_terminal_dimension(&ctl.cols, &ctl.rows);
> +		ctl.win = initscr();
> +		get_terminal_dimension(&ctl.cols, &ctl.rows);
>   #if HAVE_RESIZETERM
> -	resizeterm(ctl.rows, ctl.cols);
> +		resizeterm(ctl.rows, ctl.cols);
>   #endif
> -	curs_set(0);
> +		curs_set(0);
> +	}
>   
>   	ctl.hostname = xgethostname();
>   	event_loop(&ctl, &out);
> @@ -412,10 +440,13 @@ int main(int argc, char **argv)
>   	free(ctl.hostname);
>   	cpuset_free(ctl.cpuset);
>   
> -	if (is_tty)
> -		tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
> -	delwin(ctl.win);
> -	endwin();
> +	if (ctl.batch == false) {
> +		if (is_tty)
> +			tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
> +
> +		delwin(ctl.win);
> +		endwin();
> +	}
>   
>   	return EXIT_SUCCESS;
>   }


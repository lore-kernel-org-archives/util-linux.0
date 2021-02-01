Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8252AC433E0
	for <util-linux@archiver.kernel.org>; Mon,  1 Feb 2021 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506A264EAA
	for <util-linux@archiver.kernel.org>; Mon,  1 Feb 2021 17:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBARdQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:33:16 -0500
Received: from foss.arm.com ([217.140.110.172]:35068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232267AbhBARcv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 1 Feb 2021 12:32:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 131041042;
        Mon,  1 Feb 2021 09:32:06 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4EF3F718;
        Mon,  1 Feb 2021 09:32:04 -0800 (PST)
Date:   Mon, 1 Feb 2021 17:32:02 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH v2 2/5] Add uclampset schedutil
Message-ID: <20210201173202.jrsd6mbhbm2hhebm@e107158-lin>
References: <20210130205039.581764-1-qais.yousef@arm.com>
 <20210130205039.581764-3-qais.yousef@arm.com>
 <20210201161252.3suz2dbihpdxyg5x@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210201161252.3suz2dbihpdxyg5x@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 02/01/21 17:12, Karel Zak wrote:
> On Sat, Jan 30, 2021 at 08:50:36PM +0000, Qais Yousef wrote:
> 
> Now I see that you have reused chrt concept of --pid. We keep it for
> chrt due to backward compatibility, but for new util it would be
> better to use standard 'required_argument' for --pid.

Hmm what does required mean here? --pid is optional. But if passed, a value
is required to be passed indeed.

> 
> > +	static const struct option longopts[] = {
> > +		{ "all-tasks",		no_argument, NULL, 'a' },
> > +		{ "pid",		no_argument, NULL, 'p' },
> 
>  { "pid", required_argument, NULL, 'p' },

Assuming this means --pid must be followed by a value then indeed that's what
we expect to happen.

> 
> > +		{ "system",		no_argument, NULL, 's' },
> > +		{ "reset-on-fork",	no_argument, NULL, 'R' },
> > +		{ "help",		no_argument, NULL, 'h' },
> > +		{ "verbose",		no_argument, NULL, 'v' },
> > +		{ "version",		no_argument, NULL, 'V' },
> > +		{ NULL,			no_argument, NULL, 0 }
> > +	};
> > +
> > +	setlocale(LC_ALL, "");
> > +	bindtextdomain(PACKAGE, LOCALEDIR);
> > +	textdomain(PACKAGE);
> > +	close_stdout_atexit();
> > +
> > +	while((c = getopt_long(argc, argv, "+asRphmMvV", longopts, NULL)) != -1)
> 
>  The same we can do for -m and -M, just normal options where getopt_long() 
>  use optarg:
> 
>    "+asRp:hm:M:vV"

+1

> 
> > +	{
> > +		switch (c) {
> > +		case 'a':
> > +			ctl->all_tasks = 1;
> > +			break;
> > +		case 'p':
> > +			errno = 0;
> > +			ctl->pid = strtos32_or_err(argv[optind], _("invalid PID argument"));
> 
> 
>  ctl->pid = strtos32_or_err(optarg, _("invalid PID argument")); 

+1

will fix this and the 2 other occurrences below to include in v3.

Thanks!

--
Qais Yousef

> 
> > +			optind++;
> > +			break;
> > +		case 's':
> > +			ctl->system = 1;
> > +			break;
> > +		case 'R':
> > +			ctl->reset_on_fork = 1;
> > +			break;
> > +		case 'v':
> > +			ctl->verbose = 1;
> > +			break;
> > +		case 'm':
> > +			ctl->util_min = strtos32_or_err(argv[optind], _("invalid util_min argument"));
> 
>  ctl->util_min = strtos32_or_err(optarg, _("invalid util_min argument"));
>  
> 
> > +			ctl->util_min_set = 1;
> > +			validate_util(ctl->util_min);
> > +			optind++;
> > +			break;
> > +		case 'M':
> > +			ctl->util_max = strtos32_or_err(argv[optind], _("invalid util_max argument"));
> 
>  ctl->util_max = strtos32_or_err(optarg, _("invalid util_max argument"));
> 
> > +			ctl->util_max_set = 1;
> > +			validate_util(ctl->util_max);
> > +			optind++;
> > +			break;
> > +		case 'V':
> > +			print_version(EXIT_SUCCESS);
> > +			/* fallthrough */
> > +		case 'h':
> > +			usage();
> > +		default:
> > +			errtryhelp(EXIT_FAILURE);
> > +		}
> > +	}
> 
> 
>  Karel
> 
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 

Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63803C433DB
	for <util-linux@archiver.kernel.org>; Mon,  1 Feb 2021 16:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2565C64E2B
	for <util-linux@archiver.kernel.org>; Mon,  1 Feb 2021 16:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBAQOc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Feb 2021 11:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229763AbhBAQOa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Feb 2021 11:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612195984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tc9mw8Qp9/hzLjum5fFflEWAM9GVFWCzLHTv8kyrTnc=;
        b=ZJFiyFhO9yEUY7Ud6Ce6gfb8crAhDYPKXQZvNAjHDlzb4YD26hRZAd65ZtKYGuwlt4aDQV
        7feW46vrDPgee7dQIvjni/EvhRd4FW/ef2h9QDGQ2rIH3ZPDzy1T5HP687kMLAlpV3RgjJ
        L8+TdXel0hUPg6tDKb//jRXZyr7tSUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-JZdj__VcOl-A5nzOTXy3gQ-1; Mon, 01 Feb 2021 11:12:58 -0500
X-MC-Unique: JZdj__VcOl-A5nzOTXy3gQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F242193579D;
        Mon,  1 Feb 2021 16:12:57 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C74B5C1A1;
        Mon,  1 Feb 2021 16:12:55 +0000 (UTC)
Date:   Mon, 1 Feb 2021 17:12:52 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH v2 2/5] Add uclampset schedutil
Message-ID: <20210201161252.3suz2dbihpdxyg5x@ws.net.home>
References: <20210130205039.581764-1-qais.yousef@arm.com>
 <20210130205039.581764-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130205039.581764-3-qais.yousef@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 30, 2021 at 08:50:36PM +0000, Qais Yousef wrote:

Now I see that you have reused chrt concept of --pid. We keep it for
chrt due to backward compatibility, but for new util it would be
better to use standard 'required_argument' for --pid.

> +	static const struct option longopts[] = {
> +		{ "all-tasks",		no_argument, NULL, 'a' },
> +		{ "pid",		no_argument, NULL, 'p' },

 { "pid", required_argument, NULL, 'p' },

> +		{ "system",		no_argument, NULL, 's' },
> +		{ "reset-on-fork",	no_argument, NULL, 'R' },
> +		{ "help",		no_argument, NULL, 'h' },
> +		{ "verbose",		no_argument, NULL, 'v' },
> +		{ "version",		no_argument, NULL, 'V' },
> +		{ NULL,			no_argument, NULL, 0 }
> +	};
> +
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +	close_stdout_atexit();
> +
> +	while((c = getopt_long(argc, argv, "+asRphmMvV", longopts, NULL)) != -1)

 The same we can do for -m and -M, just normal options where getopt_long() 
 use optarg:

   "+asRp:hm:M:vV"

> +	{
> +		switch (c) {
> +		case 'a':
> +			ctl->all_tasks = 1;
> +			break;
> +		case 'p':
> +			errno = 0;
> +			ctl->pid = strtos32_or_err(argv[optind], _("invalid PID argument"));


 ctl->pid = strtos32_or_err(optarg, _("invalid PID argument")); 

> +			optind++;
> +			break;
> +		case 's':
> +			ctl->system = 1;
> +			break;
> +		case 'R':
> +			ctl->reset_on_fork = 1;
> +			break;
> +		case 'v':
> +			ctl->verbose = 1;
> +			break;
> +		case 'm':
> +			ctl->util_min = strtos32_or_err(argv[optind], _("invalid util_min argument"));

 ctl->util_min = strtos32_or_err(optarg, _("invalid util_min argument"));
 

> +			ctl->util_min_set = 1;
> +			validate_util(ctl->util_min);
> +			optind++;
> +			break;
> +		case 'M':
> +			ctl->util_max = strtos32_or_err(argv[optind], _("invalid util_max argument"));

 ctl->util_max = strtos32_or_err(optarg, _("invalid util_max argument"));

> +			ctl->util_max_set = 1;
> +			validate_util(ctl->util_max);
> +			optind++;
> +			break;
> +		case 'V':
> +			print_version(EXIT_SUCCESS);
> +			/* fallthrough */
> +		case 'h':
> +			usage();
> +		default:
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +	}


 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


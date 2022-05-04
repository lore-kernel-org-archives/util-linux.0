Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0623BC433F5
	for <util-linux@archiver.kernel.org>; Wed,  4 May 2022 10:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbiEDKzh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 4 May 2022 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348415AbiEDKyQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 4 May 2022 06:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E8B713E3A
        for <util-linux@vger.kernel.org>; Wed,  4 May 2022 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651661436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqolhpSfGVsNPHRD5GMAPBZQBYuv5dCJ6nkgj4RI5B0=;
        b=bwS4dxO0zIDqnoGYniqSjtX/psgP4jzOYbVIWMwOvzzKdGk4clDpa/bnmLzahgYd+8ZqSN
        1iG8Y7NBIoE4HVv9/g2GW/Ey9tipmNgr4g9iqmKFjc2mm4nrreWJmgtx4n+d6jTaiAvjzz
        HCPgYSpn1Nia9OkJJ7iXec7sHm+dXY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-rKxtJWLSMOWofB_Y-AtdOA-1; Wed, 04 May 2022 06:50:33 -0400
X-MC-Unique: rKxtJWLSMOWofB_Y-AtdOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CECC3185A7BA;
        Wed,  4 May 2022 10:50:32 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51BCB400DE5E;
        Wed,  4 May 2022 10:50:32 +0000 (UTC)
Date:   Wed, 4 May 2022 12:50:30 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Nathan Sharp <nwsharp@live.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] misc-utils: add the pipesz utility
Message-ID: <20220504105030.tqswjfqezivnodgb@ws.net.home>
References: <20220412045930.236051-1-nwsharp@live.com>
 <SN6PR04MB3983957C75B4FF779E3D611CC2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB3983957C75B4FF779E3D611CC2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 11, 2022 at 10:59:27PM -0600, Nathan Sharp wrote:
>  .gitignore               |   1 +
>  configure.ac             |   8 +
>  include/pathnames.h      |   4 +
>  meson.build              |  12 ++
>  meson_options.txt        |   2 +
>  misc-utils/Makemodule.am |   7 +
>  misc-utils/meson.build   |   4 +
>  misc-utils/pipesz.c      | 347 +++++++++++++++++++++++++++++++++++++++
>  8 files changed, 385 insertions(+)
>  create mode 100644 misc-utils/pipesz.c

I had time to review it finally (sorry for delay). 

> +static void __attribute__((__noreturn__)) usage(void)
> +{
> +	fputs(USAGE_HEADER, stdout);
> +	printf(_(" %s [options] [--set <size>] [--] [command]\n"), program_invocation_short_name);
> +	printf(_(" %s [options] --get\n"), program_invocation_short_name);
> +
> +	fputs(USAGE_SEPARATOR, stdout);
> +	/* TRANSLATORS: 'command' refers to a program argument */
> +	puts(_("Set or examine pipe buffer sizes and optionally execute command."));
> +
> +	fputs(USAGE_OPTIONS, stdout);
> +	puts(_(" -g, --get          examine pipe buffers"));
> +	/* TRANSLATORS: '%s' refers to a system file */
> +	printf(_(" -s, --set <size>  set pipe buffer sizes\n"
> +		"                      size defaults to %s\n"
> +	), PIPESZ_DEFAULT_SIZE_FILE);
> +
> +	fputs(USAGE_SEPARATOR, stdout);
> +	puts(_(" -f, --file <path>  act on a file"));
> +	puts(_(" -n, --fd <num>     act on a file descriptor"));
> +	puts(_(" -i, --stdin        act on standard input"));
> +	puts(_(" -o, --stdout       act on standard output"));
> +	puts(_(" -e, --stderr       act on standard error"));
> +
> +	fputs(USAGE_SEPARATOR, stdout);
> +	puts(_(" -c, --check        do not continue after an error"));

Would be better to be paranoid (as expected by --check) by default and
implement --force for cases when user wants something crazy? That's
usual way utils are implemented.

...

> +	/* check for --help or --version */
> +	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1)
> +		switch (c) {
> +		case 'h':
> +			usage();
> +		case 'V':
> +			print_version(EXIT_SUCCESS);
> +		}

Why we need multiple getopt_long() blocks? I guess --help and
--version could be together with other options. This is very unusual.

> +	/* gather normal options */
> +	optind = 1;
> +	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1) {
> +		err_exclusive_options(c, longopts, excl, excl_st);
> +
> +		switch (c) {
> +		case 'c':
> +			opt_check = TRUE;
> +			break;
> +		case 'e':
> +			++n_opt_pipe;
> +			break;
> +		case 'f':
> +			++n_opt_pipe;
> +			break;
> +		case 'g':
> +			opt_get = TRUE;
> +			break;
> +		case 'i':
> +			++n_opt_pipe;
> +			break;
> +		case 'n':
> +			fd = strtos32_or_err(optarg, _("invalid fd argument"));
> +			++n_opt_pipe;
> +			break;
> +		case 'o':
> +			++n_opt_pipe;
> +			break;
> +		case 'q':
> +			opt_quiet = TRUE;
> +			break;
> +		case 's':
> +			sz = strtosize_or_err(optarg, _("invalid size argument"));
> +			opt_size = sz >= INT_MAX ? INT_MAX : (int)sz;
> +			break;
> +		case 'v':
> +			opt_verbose = TRUE;
> +			break;
> +		default:
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +	}

...

> +	/* go through the arguments again and do the requested operations */
> +	optind = 1;
> +	while ((c = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1)
> +		switch (c) {
> +		case 'e':
> +			do_fd(STDERR_FILENO);
> +			break;
> +		case 'f':
> +			do_file(optarg);
> +			break;
> +		case 'i':
> +			do_fd(STDIN_FILENO);
> +			break;
> +		case 'n':
> +			/* optarg was checked before, but it's best to be safe */
> +			fd = strtos32_or_err(optarg, _("invalid fd argument"));
> +			do_fd(fd);
> +			break;
> +		case 'o':
> +			do_fd(STDOUT_FILENO);
> +			break;
> +		}

... and another getopt_long() block.


What about to define

enum {
    PIPESZ_ON_STDERR = (1 << 1),
    PIPESZ_ON_STDIN  = (1 << 2),
    PIPESZ_ON_STDOUT = (1 << 3),
    PIPESZ_ON_FILE   = (1 << 4),
    PIPESZ_ON_FD     = (1 << 5)
};

and in the while (getopt_long()) block set operation |= PIPESZ_ON_xxxxx and
later in code use it? (also with variables 'filename' and 'fd'.

Then you can keep all arguments parsing on one place, right? :-)

The rest seems good.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


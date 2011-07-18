Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab1GRWRz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 18:17:55 -0400
Date: Tue, 19 Jul 2011 00:17:51 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] schedutils
Message-ID: <20110718221751.GD4354@nb.redhat.com>
References: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 17, 2011 at 08:37:58PM +0200, Sami Kerola wrote:
>  	default:
> -		printf(_("unknown\n"));
> +		printf(_("unknown scheduling policy\n"));

 what about warnx() ?

> +	printf(_("policy          : min/max priority\n"
> +		 "----------------+-----------------\n"));

 oh...

>  	for (i = 0; i < ARRAY_SIZE(policies); i++) {
>  		int max = sched_get_priority_max(policies[i]);
>  		int min = sched_get_priority_min(policies[i]);
> 
>  		if (max >= 0 && min >= 0)
> -			printf(_("SCHED_%s min/max priority\t: %d/%d\n"),
> +			printf(_("SCHED_%-10s: %d/%d\n"),
>  					names[i], min, max);

 ...this is not backwardly compatible.

 If you really want to have nice output then use include/tt.c (see for
 example partx, findmnt or lsblk) and add a new option for such
 functionality.

>  .SH SYNOPSIS
>  .B ionice
> -.RB [[ \-c
> -.IR class ]
> -.RB [ \-n
> -.IR classdata ]
> -.RB [ \-t ]]
> -.BI \-p \ PID
> -.RI [ PID  ]...
> +[OPTION] \fB\-p\fR PID [PID...]
>  .br
>  .B ionice
> -.RB [ \-c
> -.IR class ]
> -.RB [ \-n
> -.IR classdata ]
> -.RB [ \-t ]
> -.IR COMMAND\  [ ARG  ]...
> +[OPTION] COMMAND

hmm.. don't forget that people love examples, IMHO the old version
seems more readable.

>  	textdomain(PACKAGE);
> 
> -	while ((c = getopt(argc, argv, "+n:c:p:th")) != EOF) {
> +	while ((c = getopt_long(argc, argv, "+n:c:p:tVh", longopts, NULL)) != EOF)
>  		switch (c) {
>  		case 'n':
> -			ioprio = strtol_or_err(optarg, _("failed to parse class data"));
> +			ioprio = strtol_or_err(optarg, _("failed to parse priority"));

well, the original kernel Documentation/block/ioprio.txt is talking
about "class data" and I think it would be better to follow kernel
here. Maybe one day the mask for the syscall will used for a different
things than only for priority...

> +		case 'V':
> +			printf(_("%s (%s)\n"),

 "%s from %s" ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

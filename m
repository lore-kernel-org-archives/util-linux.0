Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55359 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964975AbbD1LwM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Apr 2015 07:52:12 -0400
Date: Tue, 28 Apr 2015 13:52:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: implement fsck -r {fd}
Message-ID: <20150428115210.GW27969@ws.net.home>
References: <553E53D7.8020800@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <553E53D7.8020800@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Applied, thanks. See notes below.

On Mon, Apr 27, 2015 at 05:20:55PM +0200, Stanislav Brabec wrote:
> Note: Code in if and else is intentionally partially duplicated. Current
> human readable output of floats does not conform to locale conventions,
> and may be changed in future. But we want to keep machine readable output
> exactly same as it is now.

The question is if we can change the human readable output. It was
requested by Google and I guess they parse the output.

> +static int report_stats_fd;
> +static FILE *report_stats_file;

It seems that report_stats_fd does not have to be global variable,
code depends on report_stats_file. Fixed.

>  			case 'r':
>  				report_stats = 1;
> +				if (arg[j+1]) {					/* -r<fd> */
> +					report_stats_fd = string_to_int(arg+j+1);
> +					if (report_stats_fd < 0)
> +						report_stats_fd = 0;
> +					else
> +						goto next_arg;
> +				} else if (i+1 < argc && *argv[i+1] != '-') {	/* -r <fd> */
> +					report_stats_fd = string_to_int(argv[i+1]);
> +					if (report_stats_fd < 0)
> +						report_stats_fd = 0;
> +					else {
> +						++i;
> +						goto next_arg;
> +					}
> +				}
>  				break;

...you have copied code from -C, right?

The -C code interprets errors or missing fd as 0, it's probably
because fsck.extN requires file descriptor for -C, but fsck(8) has the
fd as optional argument.

I don't think we need this behavior for -r too. It would be better to
report all possible mistakes. Fixed.

> +	/* Validate the report stats file descriptor to avoid disasters */
> +	if (report_stats_fd) {
> +		report_stats_file = fdopen(report_stats_fd, "w");
> +		if (!report_stats_file)
> +			err(FSCK_EX_ERROR,
> +				_("invalid argument -r %d"),
> +				report_stats_fd);
> +	}
> +

It means that "-r 0" is unsupported, why? I have fixed this.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

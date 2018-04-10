Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751862AbeDJKA1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Apr 2018 06:00:27 -0400
Date: Tue, 10 Apr 2018 12:00:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, mail@nh2.me
Subject: Re: [PATCH] setpriv: implement option to restore parent death signal
Message-ID: <20180410100023.yego5fwd552id2u6@ws.net.home>
References: <d791e27f0ccbe1af12797ce380a41be0389019f9.1522964667.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d791e27f0ccbe1af12797ce380a41be0389019f9.1522964667.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 06, 2018 at 08:13:42AM +0100, Patrick Steinhardt wrote:
> +static void dump_pdeathsig(void)
> +{
> +	const char *signame;
> +	int pdeathsig;
> +
> +	if (prctl(PR_GET_PDEATHSIG, &pdeathsig) != 0) {
> +		warn(_("get pdeathsig failed"));
> +		return;
> +	}
> +
> +	printf("Parent death signal: ");
> +	if (pdeathsig && get_signame_by_idx(pdeathsig, &signame, NULL) == 0)

We use get_signame_by_idx() to list signals. I guess you want to use
signum_to_signame().

> +		printf("%s\n", signame);
> +	else if (pdeathsig)
> +		printf("%d\n", pdeathsig);
> +	else
> +		printf("[none]\n");
> +}
> +

....

> +		case KEEP_PDEATHSIG:
> +			if (opts.pdeathsig)
> +				errx(EXIT_FAILURE,
> +				     _("duplicate --keep-pdeathsig option"));
> +			if (prctl(PR_GET_PDEATHSIG, &opts.pdeathsig) != 0)
> +				errx(SETPRIV_EXIT_PRIVERR,
> +				     _("failed to get parent death signature"));
> +			break;

Good idea, but what about to make it usable for more use-cases:

    --pdeathsig [keep|clear|<signame>]

then we will have command line interface to completely control 
PR_SET_PDEATHSIG ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

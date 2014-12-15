Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60459 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbaLOJ3D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Dec 2014 04:29:03 -0500
Date: Mon, 15 Dec 2014 10:28:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/16] lslogins: reject unknown time format arguments
Message-ID: <20141215092852.GX19904@x2.net.home>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
 <1418579052-29386-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418579052-29386-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 14, 2014 at 05:44:01PM +0000, Sami Kerola wrote:
> @@ -1398,8 +1388,18 @@ int main(int argc, char *argv[])
>  			break;
>  		case OPT_TIME_FMT:
>  			{
> +				struct lslogins_timefmt {
> +					const char *name;
> +					const int val;
> +				};
> +				const struct lslogins_timefmt timefmts[] = {

 static const ....

> +					{ "iso", TIME_ISO },
> +					{ "full", TIME_FULL },
> +					{ "short", TIME_SHORT },
> +				};
>  				size_t i;
>  
> +				ctl->time_mode = TIME_INVALID;
>  				for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
>  					if (strcmp(timefmts[i].name, optarg) == 0) {
>  						ctl->time_mode = timefmts[i].val;
> @@ -1407,7 +1407,7 @@ int main(int argc, char *argv[])
>  					}
>  				}
>  				if (ctl->time_mode == TIME_INVALID)
> -					usage(stderr);
> +					errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);

This is not elegant solution, it would be better to move all the code
to small function parse_time_mode() and keep the main() less "crowded".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

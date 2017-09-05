Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbdIELB6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 5 Sep 2017 07:01:58 -0400
Date: Tue, 5 Sep 2017 13:01:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: add -a that is short of --adjust to manual page
 and usage
Message-ID: <20170905110154.s3ld4ziq2fifprj2@ws>
References: <20170903223407.5459-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170903223407.5459-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 03, 2017 at 11:34:07PM +0100, Sami Kerola wrote:
> In same go use -V as return value of --version from getopts_long().
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/hwclock.8.in | 2 +-
>  sys-utils/hwclock.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index 107e3f196..2be7147e2 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -34,7 +34,7 @@ was added.  See their respective descriptions below.
>  The following functions are mutually exclusive, only one can be given at
>  a time.  If none is given, the default is \fB\-\-show\fR.
>  .TP
> -.B \-\-adjust
> +.B \-a, \-\-adjust

Good idea.

>  Add or subtract time from the Hardware Clock to account for systematic
>  drift since the last time the clock was set or adjusted.  See the
>  discussion below, under
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 0b8444156..0da053617 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1089,7 +1089,7 @@ usage(const struct hwclock_control *ctl)
>  	puts(_(" -s, --hctosys        set the system time from the RTC"));
>  	puts(_(" -w, --systohc        set the RTC from the system time"));
>  	puts(_("     --systz          send timescale configurations to the kernel"));
> -	puts(_("     --adjust         adjust the RTC to account for systematic drift"));
> +	puts(_(" -a, --adjust         adjust the RTC to account for systematic drift"));
>  #if defined(__linux__) && defined(__alpha__)
>  	puts(_("     --getepoch       display the RTC epoch"));
>  	puts(_("     --setepoch       set the RTC epoch according to --epoch"));
> @@ -1167,7 +1167,7 @@ int main(int argc, char **argv)
>  		{ "show",         no_argument,       NULL, 'r'            },
>  		{ "hctosys",      no_argument,       NULL, 's'            },
>  		{ "utc",          no_argument,       NULL, 'u'            },
> -		{ "version",      no_argument,       NULL, 'v'            },
> +		{ "version",      no_argument,       NULL, 'V'            },

What about backward compatibility? I can imagine script with "hwclock -v".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

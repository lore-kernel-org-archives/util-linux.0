Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbaILHfW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Sep 2014 03:35:22 -0400
Date: Fri, 12 Sep 2014 09:35:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/6] renice: avoid having same lines of code twice
Message-ID: <20140912073504.GQ21325@x2.net.home>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
 <1410002693-16540-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410002693-16540-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 06, 2014 at 12:24:51PM +0100, Sami Kerola wrote:
> +static int getprio(const int which, const int who, const char *idtype)
> +{
> +	int ret;
> +
> +	errno = 0;
> +	ret = getpriority(which, who);
> +	if (ret == -1 && errno) {
> +		warn(_("failed to get priority for %d (%s)"), who, idtype);
> +		return PRIO_MAX + 1;
> +	}
> +	return ret;
> +}

This is exactly the situation when you want to use "return" only for
function status rather than for any data.

static int getprio(const int which,
                   const int who,
                   const char *idtype,
                   int *prio)                       <--------!
{
    errno = 0;
    *prio = getpriority(which, who);
    if (*prio == -1 && errno) {
        warn(_("failed to get priority for %d (%s)"), who, idtype);
        return -errno;
    }
    return 0;
}


> -	errno = 0;
> -	newprio = getpriority(which, who);
> -	if (newprio == -1 && errno) {
> -		warn(_("failed to get priority for %d (%s)"), who, idtype);
> +	if ((newprio = getprio(which, who, idtype)) == PRIO_MAX + 1)
>  		return 1;
> -	}

   if (getprio(which, who, idtype, &newprio) != 0)
        return 1;

 .. so you don't need complicated things like PRIO_MAX + 1.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

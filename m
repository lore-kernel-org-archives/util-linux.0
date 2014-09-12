Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48890 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791AbaILIEH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Sep 2014 04:04:07 -0400
Date: Fri, 12 Sep 2014 10:03:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/6] renice: fix numeric uid argument parsing
Message-ID: <20140912080354.GR21325@x2.net.home>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
 <1410002693-16540-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410002693-16540-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 06, 2014 at 12:24:52PM +0100, Sami Kerola wrote:
>  		if (which == PRIO_USER) {
> -			register struct passwd *pwd = getpwnam(*argv);
> +			struct passwd *pwd = getpwnam(*argv);
>  
> -			if (pwd == NULL) {
> -				warnx(_("unknown user %s"), *argv);
> -				errs = 1;
> -				continue;
> +			if (pwd != NULL)
> +				who = pwd->pw_uid;
> +			else {
> +				error_msg = _("unknown user %s");
> +				goto numeric_pid;
>  			}
> -			who = pwd->pw_uid;
>  		} else {
> +			error_msg = _("bad value %s");
> + numeric_pid:
>  			who = strtol(*argv, &endptr, 10);
>  			if (who < 0 || *endptr) {
> -				warnx(_("bad value %s"), *argv);
> +				warnx(error_msg, *argv);
>  				errs = 1;
>  				continue;
>  			}

 The goto is unnecessary. Just set who = -1 by default.

  who = -1;
  if (which == PRIO_USER) {
        ...
        who = pwd->pw_uid;
  }

  if (who < 0) {
        who = strtol(*argv, &endptr, 10);
        ...
        if (who < 0 || *endptr)
            warnx(_("failed to parse %s argument"), idtype[which]);
  }


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

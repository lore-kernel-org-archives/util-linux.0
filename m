Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbdGaNcB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 09:32:01 -0400
Date: Mon, 31 Jul 2017 15:31:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] build: use --runstatedir instead of --localstatedir
Message-ID: <20170731133156.2pk6qz7d6zmsevor@ws.net.home>
References: <1501164042-27281-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501164042-27281-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 27, 2017 at 04:00:42PM +0200, Andreas Henriksson wrote:
> Current GNU Coding Standards introduced the @runstatedir@ variable
> for this purpose. Lets use that instead.
> 
> The GNU default for @runstatedir@ is ${localstatedir}/run so util-linux
> still override the default to be /run to preserve the status quo from
> before. The only difference is that you'll now pass --runstatedir to
> override the location on the command line instead of --localstatedir.

Applied.

...

> -AS_CASE([$prefix:$localstatedir],
> -  [NONE:'${prefix}/var' | /usr:'${prefix}/var'],
> -    [localstatedir=/run
> -     AC_MSG_NOTICE([  --localstatedir defaults to /run])
> -    ]
> +AS_CASE([$prefix:$runstatedir],
> +    [NONE:'${localstatedir}/run' | /usr:'${localstatedir}/run'],
> +      [runstatedir=/run
> +       AC_MSG_NOTICE([  --runstatedir defaults to /run])
> +      ]
>  )
> -AC_SUBST([localstatedir])
> +AC_SUBST([runstatedir])

It seems we need somehow to support autoconf < 2.70 where is no
$runstatedir. So, I have modified the code to use fallback

    runstatedir='${localstatedir}/run'

It also seems we need to check for unmodified $localstatedir rather
than care about $prefix. So, I have improved the AS_CASE().

Please, git-pull from master branch and retest it with new autoconf
and your environment. Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

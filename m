Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754620AbdDEIv4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 5 Apr 2017 04:51:56 -0400
Date: Wed, 5 Apr 2017 10:51:51 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
Message-ID: <20170405085151.beeuqeovoqrkumjx@ws.net.home>
References: <20170402081436.861-1-kerolasa@iki.fi>
 <20170402081436.861-3-kerolasa@iki.fi>
 <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
 <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
 <CAG27Bk2_YT8jEOrxb4ANwH59CAw-ramfZkpCBDHbAqkkDHOfwQ@mail.gmail.com>
 <35c0fb17-6b6e-35df-fe2f-18dd14f3987c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35c0fb17-6b6e-35df-fe2f-18dd14f3987c@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 04, 2017 at 09:03:08PM -0400, J William Piggott wrote:
> 
> I don't understand this:
> 
>  8< ---
> 
>        -o, --login-options "/path/command --option argument -- \u"
>               Options   that  are passed to the login program.  \u is replaced
>               by the login name.  The default is "/bin/login -- \u".
>  8< ---
> 
> Is this saying the argument must include the login command? Is that what
> "/path/command" represents? If yes, then the second line is incorrect.
> If no, then the last sentence is incorrect.

from code:

    login_argv[login_argc++] = options.login; 
    ...

    login_options_to_argv(login_argv, &login_argc,
                        options.logopt, username);
    ...
    execv(options.login, login_argv);


where:
    options.login is --login-program
    login-options is --login-options

so the man page is wrong, --login-options should be without the path.

I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

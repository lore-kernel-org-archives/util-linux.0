Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36415 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169756AbdDXMYl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 24 Apr 2017 08:24:41 -0400
Received: by mail-pg0-f68.google.com with SMTP id 34so3952193pgx.3
        for <util-linux@vger.kernel.org>; Mon, 24 Apr 2017 05:24:41 -0700 (PDT)
Date: Mon, 24 Apr 2017 14:24:37 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] sulogin: reduce vulnerability surface
Message-ID: <20170424122435.4engxht6k6r5xo5l@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20170423205821.7444-1-kerolasa@iki.fi>
 <20170423205821.7444-8-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170423205821.7444-8-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

> Hopefully these changes are unreachable code, but better safe than sorry
> when dealing with setuid root code that is installed everywhere.  Quite
> obviously the introduced abort() calls protect from impossible inputs.

> Secondly set all possible data to be read-only in attempt to make it more
> difficult to alter anything at all.

> Reference: https://www.securecoding.cert.org/confluence/display/c/DCL00-C.+Const-qualify+immutable+objects
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/su-common.c        | 53 +++++++++++++++++++++++-------------------
>  login-utils/sulogin-consoles.c | 20 ++++++++--------
>  login-utils/sulogin.c          | 39 ++++++++++++-------------------
>  3 files changed, 54 insertions(+), 58 deletions(-)

> diff --git a/login-utils/su-common.c b/login-utils/su-common.c
> index 41f2b1cea..08f327c50 100644
> --- a/login-utils/su-common.c
> +++ b/login-utils/su-common.c
<snip>
> -  int retval;
> +  const int retval = pam_open_session (pamh, 0);;
                                                  ^
												  double semicolon.
Kind regards,
Petr


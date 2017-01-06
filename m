Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([217.72.192.75]:59212 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938382AbdAFLQk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 6 Jan 2017 06:16:40 -0500
Subject: Re: [PATCH] newgrp: use libc explicit_bzero() when it is available
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170105223340.2721-1-kerolasa@iki.fi>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <4462d609-2049-7484-d6a8-53daf9b4534f@bernhard-voelker.de>
Date: Fri, 6 Jan 2017 12:09:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170105223340.2721-1-kerolasa@iki.fi>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/05/2017 11:33 PM, Sami Kerola wrote:
> +#ifdef HAVE_EXPLICIT_BZERO
> +		explicit_bzero(xpwd, strlen(xpwd));
> +#else
>  		xmemset_s(xpwd, strlen(xpwd), 0);
> +#endif
>  		free(xpwd);

Do you think it's worth making things even more complicated
for overwriting a simple string?  I mean, a simple

  for (char *c = xpwd; c; c++)
    c = '\0';

would do, wouldn't it?

Have a nice day,
Berny

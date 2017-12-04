Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753919AbdLDMEH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Dec 2017 07:04:07 -0500
Date: Mon, 4 Dec 2017 13:04:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: improve setarch(8) manual page
Message-ID: <20171204120404.aa4p6p2o3goupsq3@ws.net.home>
References: <20171203125117.28159-1-kerolasa@iki.fi>
 <20171203125117.28159-3-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171203125117.28159-3-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 03, 2017 at 12:51:16PM +0000, Sami Kerola wrote:
>  \fB\-3\fR, \fB\-\-3gb\fR
> -Specifies that processes should use a maximum of 3GB of address space on systems where it is supported (ADDR_LIMIT_3GB).
> +Specifies
> +.I program
> +should use a maximum of 3GB of address space.  Supported on x86 (as of
> +2017-12-02).  Turns on ADDR_LIMIT_3GB.

What is the magic day 2017-12-02 ?

Frankly, I don't like dates in docs. It's better to use versions
"since util-linux v2.31" or "since Linux v4.32", etc.

>  \fB\-\-4gb\fR
> -Ignored (for backward compatibility only).
> +Ignored for backward compatibility only.

Dmitry is right, the old version is better.

> +This makes
> +.BR select (2),
> +.BR pselect (2),
> +and
> +.BR ppoll (2)
> +system calls preserve the timeout value instead of storing the unslept time
> +when interrupted by a signal handler.  Use when
> +.I program
> +depends on this behavior, and the source code is not available to be fixed.

See Dmitry's note ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

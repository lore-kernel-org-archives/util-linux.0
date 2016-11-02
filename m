Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbcKBPvx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Nov 2016 11:51:53 -0400
Date: Wed, 2 Nov 2016 16:51:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: wait for flock background process
Message-ID: <20161102155151.ode6abioi7kcvksq@ws.net.home>
References: <1478097115-3203-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478097115-3203-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 02, 2016 at 03:31:55PM +0100, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Maybe we should add a --daemonize option to flock to cover
> this use case.

I have doubts it will be usable for anything else than for our tests :-)

>  tests/ts/misc/flock | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks!

> +# the lock should be established when flock has a child
> +timeout 1s bash -c "while [ \$(ps --ppid $pid |wc -l) -lt 2 ]; do sleep 0.1 ;done" \

is "0.1" portable? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757906AbbEEKqv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 May 2015 06:46:51 -0400
Date: Tue, 5 May 2015 12:46:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Brad Forschinger <bnjf@bnjf.id.au>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] NULL deref
Message-ID: <20150505104646.GC27969@ws.net.home>
References: <CAEMywzpvtywWytnvGeWyNG0GmTVeYWzLTgswRrRSOw1Gq9WDkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEMywzpvtywWytnvGeWyNG0GmTVeYWzLTgswRrRSOw1Gq9WDkw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 05, 2015 at 11:51:24AM +1000, Brad Forschinger wrote:
>  sys-utils/flock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> -                       printf(_("%s: executing %s\n"),
> program_invocation_short_name, cmd_argv[2]);
> +                       printf(_("%s: executing %s\n"),
> program_invocation_short_name, cmd_argv[0]);

It seems your email client sucks :-) (due to extra line breaks...)
The best is to use git-send-email for the patches.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

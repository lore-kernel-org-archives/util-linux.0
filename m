Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759691Ab3ICI3y (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Sep 2013 04:29:54 -0400
Date: Tue, 3 Sep 2013 10:29:43 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 14/15] hexdump: remove unnecessary global variables
Message-ID: <20130903082943.GB6094@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
 <1371408836-16663-15-git-send-email-kerolasa@iki.fi>
 <20130902232239.GA6888@rampage>
 <CAG27Bk1OcVLMWaT1f5+ct2PgW3KoF5Y2R0eY94Rrcc+nNQLzHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1OcVLMWaT1f5+ct2PgW3KoF5Y2R0eY94Rrcc+nNQLzHg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 03, 2013 at 08:15:18AM +0100, Sami Kerola wrote:
> On 3 September 2013 00:22, Dave Reisner <d@falconindy.com> wrote:
> > A little late to the game, but this commit breaks the return value of

I'm happy that you play the game with us, better later than never :-)

> > hexdump and causes it to always return 1, even on successful invocation.
> > next(char**) will always return 1 for the usual (non-NULL) values of argv.
> 
> You are not late at all. Thanks to you broken hexdump was never
> released to greater audience. I'll fix the issue in near future,
> unless someone else is quicker.

BTW, Ondrej Oprala is working on hexdump refactoring for v2.25 (for
v2.24 is too late). So, I hope that one day we will have more 
readable and maintainable code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

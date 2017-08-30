Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbdH3Jcl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Aug 2017 05:32:41 -0400
Date: Wed, 30 Aug 2017 11:32:37 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] chsh: remove local /etc/shells parsing in favour of
 getusershell(3)
Message-ID: <20170830093237.dwfpapsf47z4qgsb@ws.net.home>
References: <20170828203813.12698-1-kerolasa@iki.fi>
 <20170830073205.h4czf7hv5nrnwtcd@ws.net.home>
 <CAG27Bk0OvYHEq29aSCHkSSBcMjfDWX=D-9CurLoN9c2DxyPXTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0OvYHEq29aSCHkSSBcMjfDWX=D-9CurLoN9c2DxyPXTQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 30, 2017 at 10:09:41AM +0100, Sami Kerola wrote:
> On 30 August 2017 at 08:32, Karel Zak <kzak@redhat.com> wrote:
> > On Mon, Aug 28, 2017 at 09:38:13PM +0100, Sami Kerola wrote:
> >> Less code, less bugs.  And if there are bugs at least share them with all
> >> other programs that use getusershell(3) from libc.
> >
> > Is it portable? ulibC etc.. ?
> 
> It is available in uClib
> https://git.uclibc.org/uClibc/tree/libc/unistd/usershell.c
> 
> Also in musl, but strangely in legacy directory
> https://git.musl-libc.org/cgit/musl/tree/src/legacy/getusershell.c

OK.

> But I guess the best option is to add check to configure.ac and write

I have add getusershell to configure to disable build on system where
the function is missing.

> util-linux getusershell() fallback when it is not available. I'll do that
> sometime soonish, about before end of the week.

I think we can be a little bit passive :-) (wait for any feedback before we 
add fallback code).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

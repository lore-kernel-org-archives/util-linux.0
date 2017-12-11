Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753114AbdLKNq6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 11 Dec 2017 08:46:58 -0500
Date: Mon, 11 Dec 2017 14:46:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: improve setarch(8) manual page
Message-ID: <20171211134653.wthtrktw373udxdw@ws.net.home>
References: <20171203125117.28159-1-kerolasa@iki.fi>
 <20171203125117.28159-3-kerolasa@iki.fi>
 <20171204120404.aa4p6p2o3goupsq3@ws.net.home>
 <CAG27Bk3ScbYMxT3xi8x6tmx6map3_gRbddbU1p9nN=k3NJQMuQ@mail.gmail.com>
 <20171209012937.GA27446@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171209012937.GA27446@altlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 09, 2017 at 04:29:37AM +0300, Dmitry V. Levin wrote:
> On Mon, Dec 04, 2017 at 01:20:01PM +0000, Sami Kerola wrote:
> > On 4 December 2017 at 12:04, Karel Zak wrote:
> > > On Sun, Dec 03, 2017 at 12:51:16PM +0000, Sami Kerola wrote:
> [...]
> > >>  \fB\-\-4gb\fR
> > >> -Ignored (for backward compatibility only).
> > >> +Ignored for backward compatibility only.
> > >
> > > Dmitry is right, the old version is better.
> > 
> > How about text:
> > 
> > This option is no-op compatibility with an old Debian setarch
> > implementation. Please do not use.
> 
> Let's add a description that is informative but without giving advice.

Yes, and without any distro name...

> For example,
> 
> "This option has no effect.  It is retained for backward compatibility only,
> and may be removed in future releases."

+1

> > How about this:
> > 
> > -- snip
> > This makes
> > .BR select (2),
> > .BR pselect (2),
> > and
> > .BR ppoll (2)
> > system calls preserve the timeout value instead of storing the unslept time
> 
> I'm not sure about "unslept time" phrase.  Wouldn't a more formal
> description be better, .e.g.
> 
> This makes
> ...
> system calls preserve the timeout value instead of modifying it to reflect
> the amount of time not slept when interrupted by a signal handler.
> ...

+1

> 
> > when interrupted by a signal handler. Use when
> > .I program
> > depends on this behavior. For more details see the timeout description from
> 
> s/from/in/
> 
> > .BR select (2)
> > manual page. Turns on STICKY_TIMEOUTS.
> > -- snip
> 
> On the whole, this looks much better.
> 
> > My remote git has the latest.
> > 
> > https://github.com/kerolasa/lelux-utiliteetit/blob/2017wk48/sys-utils/setarch.8
> > 
> > And that branch also has FIXME item near FDPIC_FUNCPTRS description.
> > Proposal(s) welcome how to make that text understandable.
> 
> What about this text:
> 
> "Treat user-space function pointers to signal handlers as pointers
> to address descriptors.  This option has no effect on architectures
> that do not support FDPIC ELF binaries.  Turns on FDPIC_FUNCPTRS."

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:63472 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdFTNQ4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 09:16:56 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/4] flock: cleanup usage issues
Date: Tue, 20 Jun 2017 15:16:43 +0200
Cc: util-linux@vger.kernel.org
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de> <201706191745.24555.sweet_f_a@gmx.de> <20170620095727.axbjbm7l2z3loodb@ws.net.home>
In-Reply-To: <20170620095727.axbjbm7l2z3loodb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706201516.43490.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 20 June 2017, Karel Zak wrote:
> On Mon, Jun 19, 2017 at 05:45:24PM +0200, Ruediger Meier wrote:
> > > > -static void usage(FILE * out) {
> > > > +static void usage(void) {
> > > > +    FILE * out = stdout;
> > > >      fputs(USAGE_HEADER, out);
> > > >      ...
> > > > }
> > >
> > > Yes, seems good, but I sure one day someone will ask:
> > >
> > >     what the hell are you doing with "out = stdout;" ?
> > >
> > > :-)
> >
> > Hehe I know :)
> >
> > This is all legacy. It's funny, eventhough I hate usage messages on
> > error, my new checkusage.sh script does it also that way. That's
> > how most simple commands are born ;)
>
> It would be better to make a conclusion (about FILE in the usage())
> and follow this conclusion in the patches. I don't think
>
>   FILE * out = stdout;
>
> and replace 'stderr' with 'out' is necessary step. It already changes
> all the lines with stderr, so why not use stdout?

Well, seems like I've had the talent to find the most unusal 3 files 
first.

You can postpone this pull request. I will send a big one all together,
Seems like I need to push some minor fixes separately before.

> If we agree about
>
>   fputs(_("text\n"), stdout);
>
> then we should do the change.
>
> BTW, maybe it would be possible to use Coccinelle to generate the
> patches :-)
>
> Comments?
>
>     Karel



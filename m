Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdFTJ5d (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 05:57:33 -0400
Date: Tue, 20 Jun 2017 11:57:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] flock: cleanup usage issues
Message-ID: <20170620095727.axbjbm7l2z3loodb@ws.net.home>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
 <201706191640.14280.ruediger.meier@ga-group.nl>
 <20170619150101.zm5heihmzcentutb@ws.net.home>
 <201706191745.24555.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706191745.24555.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 19, 2017 at 05:45:24PM +0200, Ruediger Meier wrote:
> > > -static void usage(FILE * out) {
> > > +static void usage(void) {
> > > +    FILE * out = stdout;
> > >      fputs(USAGE_HEADER, out);
> > >      ...
> > > }
> >
> > Yes, seems good, but I sure one day someone will ask:
> >
> >     what the hell are you doing with "out = stdout;" ?
> >
> > :-)
> 
> Hehe I know :)
> 
> This is all legacy. It's funny, eventhough I hate usage messages on 
> error, my new checkusage.sh script does it also that way. That's how 
> most simple commands are born ;)

It would be better to make a conclusion (about FILE in the usage())
and follow this conclusion in the patches. I don't think 

  FILE * out = stdout;
  
and replace 'stderr' with 'out' is necessary step. It already changes
all the lines with stderr, so why not use stdout?

If we agree about

  fputs(_("text\n"), stdout);

then we should do the change.

BTW, maybe it would be possible to use Coccinelle to generate the
patches :-)

Comments?

    Karel
  
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

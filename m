Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbdFSPBF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 11:01:05 -0400
Date: Mon, 19 Jun 2017 17:01:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <ruediger.meier@ga-group.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] flock: cleanup usage issues
Message-ID: <20170619150101.zm5heihmzcentutb@ws.net.home>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
 <20170619142420.yzmqhilscitwgsmz@ws.net.home>
 <201706191637.17889.sweet_f_a@gmx.de>
 <201706191640.14280.ruediger.meier@ga-group.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706191640.14280.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 19, 2017 at 04:40:14PM +0200, Ruediger Meier wrote:
> On Monday 19 June 2017, Ruediger Meier wrote:
> > On Monday 19 June 2017, Karel Zak wrote:
> > > On Mon, Jun 19, 2017 at 02:36:17PM +0200, Ruediger Meier wrote:
> > > > Sorry I forgot that the fputs/puts repacement adds another
> > > > newline.
> > > >
> > > > I could either
> > > >   1. remove the newlines from the strings (but would this cause
> > > > extra work for translators?)
> > > >   2. use printf instead of puts
> > > >   3. don't change anything, just use constant FILE argument
> > > > stdout.
> > >
> > > I think fputs(..., stdout) is non-invasive change, better than
> > > modify all strings and probably more effective than printf().
> > >
> > >     Karel
> >
> > I'm using
> >
> > -static void usage(FILE * out) {
> > -    FILE * out = stdout;
> > -    fputs(USAGE_HEADER, out);
> > +static void usage(void) {
> > +    FILE * out = stdout;
> > +    fputs(USAGE_HEADER, out);
> >     ...
> > }
> 
> Sorry I mean this 
> 
> -static void usage(FILE * out) {
> +static void usage(void) {
> +    FILE * out = stdout;
>      fputs(USAGE_HEADER, out);
>      ...
> }

Yes, seems good, but I sure one day someone will ask: 

    what the hell are you doing with "out = stdout;" ?

:-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54340 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbdFSPpw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 11:45:52 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/4] flock: cleanup usage issues
Date: Mon, 19 Jun 2017 17:45:24 +0200
Cc: util-linux@vger.kernel.org
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de> <201706191640.14280.ruediger.meier@ga-group.nl> <20170619150101.zm5heihmzcentutb@ws.net.home>
In-Reply-To: <20170619150101.zm5heihmzcentutb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706191745.24555.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 19 June 2017, Karel Zak wrote:
> On Mon, Jun 19, 2017 at 04:40:14PM +0200, Ruediger Meier wrote:
> > On Monday 19 June 2017, Ruediger Meier wrote:
> > > On Monday 19 June 2017, Karel Zak wrote:
> > > > On Mon, Jun 19, 2017 at 02:36:17PM +0200, Ruediger Meier wrote:
> > > > > Sorry I forgot that the fputs/puts repacement adds another
> > > > > newline.
> > > > >
> > > > > I could either
> > > > >   1. remove the newlines from the strings (but would this
> > > > > cause extra work for translators?)
> > > > >   2. use printf instead of puts
> > > > >   3. don't change anything, just use constant FILE argument
> > > > > stdout.
> > > >
> > > > I think fputs(..., stdout) is non-invasive change, better than
> > > > modify all strings and probably more effective than printf().
> > > >
> > > >     Karel
> > >
> > > I'm using
> > >
> > > -static void usage(FILE * out) {
> > > -    FILE * out = stdout;
> > > -    fputs(USAGE_HEADER, out);
> > > +static void usage(void) {
> > > +    FILE * out = stdout;
> > > +    fputs(USAGE_HEADER, out);
> > >     ...
> > > }
> >
> > Sorry I mean this
> >
> > -static void usage(FILE * out) {
> > +static void usage(void) {
> > +    FILE * out = stdout;
> >      fputs(USAGE_HEADER, out);
> >      ...
> > }
>
> Yes, seems good, but I sure one day someone will ask:
>
>     what the hell are you doing with "out = stdout;" ?
>
> :-)

Hehe I know :)

This is all legacy. It's funny, eventhough I hate usage messages on 
error, my new checkusage.sh script does it also that way. That's how 
most simple commands are born ;)

cu,
Rudi

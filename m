Return-Path: util-linux-owner@vger.kernel.org
Received: from mx6-phx2.redhat.com ([209.132.183.39]:32949 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaG1TPm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Jul 2014 15:15:42 -0400
Date: Mon, 28 Jul 2014 15:15:38 -0400 (EDT)
From: Jaromir Capik <jcapik@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Message-ID: <638452322.25419746.1406574938905.JavaMail.zimbra@redhat.com>
In-Reply-To: <54850462.25033124.1406563271629.JavaMail.zimbra@redhat.com>
References: <844628876.22654954.1406302034993.JavaMail.zimbra@redhat.com> <2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com> <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com> <969740755.24655086.1406558319251.JavaMail.zimbra@redhat.com> <20140728151034.GM8533@x2.net.home> <54850462.25033124.1406563271629.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to,
 -r/--repair
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> > > > > + if ((unsigned int)track_from > param.track - 1)
> > > > > + err(EXIT_FAILURE, _("'from' is out of allowed range\n"));
> > > > > + if ((unsigned int)track_to > param.track - 1)
> > > > > + err(EXIT_FAILURE, _("'to' is out of allowed range\n"));
> > > > > + if (track_from > track_to)
> > > > > + err(EXIT_FAILURE, _("'from' is higher than 'to'\n"));
> > > > 
> > > > The err() adds new line to print out, so the messages above will print
> > > > unexpected empty line.
> > > 
> > > This can be completely removed after the change to strtou32_or_err(),
> > > right?
> > 
> >  I guess you still want to check user's input against the hardware, so
> >  check
> >  if track_to is smaller than param.track is correct thing. Right?
> 
> The comparison with the param.track is done elsewhere as we don't know
> the disk parameters during the argument parsing yet.
> We get the parameters after finishing the argument parsing.

Sorry, I overlooked and thought you're writing about the argument
parsing. Of course, this needs to be preserved.

I've reworked the patch, but I'll send it after doing few tests at home.

J.

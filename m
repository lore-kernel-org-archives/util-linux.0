Return-Path: util-linux-owner@vger.kernel.org
Received: from mx5-phx2.redhat.com ([209.132.183.37]:37518 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbaG1QBO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Jul 2014 12:01:14 -0400
Date: Mon, 28 Jul 2014 12:01:11 -0400 (EDT)
From: Jaromir Capik <jcapik@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Message-ID: <54850462.25033124.1406563271629.JavaMail.zimbra@redhat.com>
In-Reply-To: <20140728151034.GM8533@x2.net.home>
References: <844628876.22654954.1406302034993.JavaMail.zimbra@redhat.com> <2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com> <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com> <969740755.24655086.1406558319251.JavaMail.zimbra@redhat.com> <20140728151034.GM8533@x2.net.home>
Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to,
 -r/--repair
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Ahoj Karle.

> > > > + if ((unsigned int)track_from > param.track - 1)
> > > > + err(EXIT_FAILURE, _("'from' is out of allowed range\n"));
> > > > + if ((unsigned int)track_to > param.track - 1)
> > > > + err(EXIT_FAILURE, _("'to' is out of allowed range\n"));
> > > > + if (track_from > track_to)
> > > > + err(EXIT_FAILURE, _("'from' is higher than 'to'\n"));
> > > 
> > > The err() adds new line to print out, so the messages above will print
> > > unexpected empty line.
> > 
> > This can be completely removed after the change to strtou32_or_err(),
> > right?
> 
>  I guess you still want to check user's input against the hardware, so check
>  if track_to is smaller than param.track is correct thing. Right?

The comparison with the param.track is done elsewhere as we don't know
the disk parameters during the argument parsing yet.
We get the parameters after finishing the argument parsing.


>  Anyway, \n is unnecessary, errx() does not print error based on
>  errno, err() follows errno.

Sure, this was more of a copy'n'paste error.


>  Thank, it's nice to see we have someone to test fdformat!

Np. Can test any time.
Going to rework the patch.

Thx,
Jaromir.

--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / Secondary Arch

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016

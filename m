Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752332AbaG1PKk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 11:10:40 -0400
Date: Mon, 28 Jul 2014 17:10:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Jaromir Capik <jcapik@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to,
 -r/--repair
Message-ID: <20140728151034.GM8533@x2.net.home>
References: <844628876.22654954.1406302034993.JavaMail.zimbra@redhat.com>
 <2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com>
 <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com>
 <969740755.24655086.1406558319251.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <969740755.24655086.1406558319251.JavaMail.zimbra@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 28, 2014 at 10:38:39AM -0400, Jaromir Capik wrote:
> > Do you mean commit 18b1fcb9cc62f4dd26eccd1c35f612ac6db1cd9b or some other
> > change? 
... 
> -		printf("%3d\b\b\b", track);
> +		printf("%3ud\b\b\b", track);

 This is obvious...

> >  The change you sent is rather long, and at
> > least I cannot see where is the correction.  That said splitting the
> > change to smaller chunks would be nice.
> 
> It has no sense to split that as I modified the code to support
> heads and the format string had to be changed to a different one.

 Perfect is the enemy of good. It's no so huge (all the original code 
 has ~160 lines).

> > The format_begin() and format_end() are not doing much, are they really
> > needed?
> 
> They increase the code abstraction and readability.

 +1

> > > + if (retries_left) continue;
> > 
> > New line & indent step missing.
> 
> I usually don't indent if well readable and other lines are longer,
> but no problem with that. Can be changed.

 Please, change it.

> > Use strtou32_or_err() and remove INT_MAX check.
> 
> Ok, had no idea it exists. Looked at few other tools and copied that.
> This is a good candidate for a change.

 Yep.

> > > + if ((unsigned int)track_from > param.track - 1)
> > > + err(EXIT_FAILURE, _("'from' is out of allowed range\n"));
> > > + if ((unsigned int)track_to > param.track - 1)
> > > + err(EXIT_FAILURE, _("'to' is out of allowed range\n"));
> > > + if (track_from > track_to)
> > > + err(EXIT_FAILURE, _("'from' is higher than 'to'\n"));
> > 
> > The err() adds new line to print out, so the messages above will print
> > unexpected empty line.
> 
> This can be completely removed after the change to strtou32_or_err(), right?

 I guess you still want to check user's input against the hardware, so check
 if track_to is smaller than param.track is correct thing. Right?

 Anyway, \n is unnecessary, errx() does not print error based on
 errno, err() follows errno. 


 Thank, it's nice to see we have someone to test fdformat!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

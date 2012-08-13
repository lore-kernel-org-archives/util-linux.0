Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab2HMMjZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Aug 2012 08:39:25 -0400
Date: Mon, 13 Aug 2012 14:39:21 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
Message-ID: <20120813123921.GB3533@x2.net.home>
References: <501D42D2.6050904@draigBrady.com>
 <20120806081533.GA24621@x2.net.home>
 <20120806111059.GB24621@x2.net.home>
 <501FD845.50001@draigBrady.com>
 <20120807080939.GF24621@x2.net.home>
 <5021A665.9060305@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5021A665.9060305@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 08, 2012 at 12:36:05AM +0100, Pádraig Brady wrote:
> ck\slash is not \x<xdigit> sequence, so escape is unnecessary
> > 
> >  Note that \\server\path is pretty common for cifs and use \x5c
> >  for all '\' will make the findmnt output unreadable in many cases.
> >  IMHO is better to be "smart" and use escape sequences only when it's
> >  really necessary.
> 
> Better for humans, but awkward for scripts to parse.
> What I was thinking was perhaps --raw or -P would
> do unconditional escaping of '\' so unescaping can be
> done with just `printf %b`?

 Good point. Fixed, all '\' will be replaced with \x5c.

> With the conditional escaping you'd have to do something like:
> 
> unmangle() {
>   printf '%b' $(
>     sed '
>       s/\\\([^x]\)/\\x5c\1/g;
>       s/\\\(x[^0-9a-f]\)/\\x5c\1/g;
>       s/\\\(x[0-9a-f][^0-9a-f]\)/\\x5c\1/g;
>     '
>   )
> }

 ugly, I see, let's use printf '%b' without the sed stuff. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

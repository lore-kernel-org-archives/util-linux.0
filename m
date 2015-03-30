Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47230 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbbC3MM2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Mar 2015 08:12:28 -0400
Date: Mon, 30 Mar 2015 14:12:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Jann Horn <jann@thejh.net>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux: wall security issue: unprivileged users can suppress
 banner
Message-ID: <20150330121223.GT1749@ws.net.home>
References: <20150327182707.GA9561@pc.thejh.net>
 <20150330094447.GR1749@ws.net.home>
 <20150330112129.GA24751@pc.thejh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150330112129.GA24751@pc.thejh.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 30, 2015 at 01:21:29PM +0200, Jann Horn wrote:
> On Mon, Mar 30, 2015 at 11:44:47AM +0200, Karel Zak wrote:
> > > +static void buf_append(char *data, char **buf, size_t *size, size_t *used)
> > > +{
> > > +	size_t data_len = strlen(data);
> > > +	while (data_len > *size - *used) {
> > > +		*size = 2 * *size;
> > 
> >  How do you know that "2 * size" is enough for data_len?
> 
> I don't. It probably usually is, but if it's not, the while loop is going
> to increase the size again and again until it fits.

Ah... not sure why, but I have read "while() as "if ()". Sorry.

> > if you replace xfmkstemp() with open_memstream() than you don't need
> > all the buf_append() changes. libc is able to use FILE as in memory
> > buffer for fprintf-like function :-)
> 
> Which libcs? The manpage for open_memstream() says something about "not
> widely available on other systems". Is that acceptable? The wall code

This is good question, we already use mem-streams in libsmartcols (and
cfdisk depends on this functionality since v2.25) and nobody complains. 

uClibc supports mem-streams, not sure if people use util-linux with
about another non-glibc alternatives.

It does not mean that your solution is bad, it was just hint. I have
no problem to accept your solution.

> even avoids the use of snprintf because it "is not always available".

snprintf() is absolutely fine, we use it in util-linux everywhere. The
note in the code is pretty obsolete.

I'm going to review more carefully the patch later this week. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

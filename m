Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbbGCIE2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Jul 2015 04:04:28 -0400
Date: Fri, 3 Jul 2015 10:04:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] script: evaluate errno only if read() sets it
Message-ID: <20150703080426.GH26962@ws.net.home>
References: <201507021206.47499.sweet_f_a@gmx.de>
 <1435831817-13227-1-git-send-email-sweet_f_a@gmx.de>
 <201507021221.02981.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201507021221.02981.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 02, 2015 at 12:21:02PM +0200, Ruediger Meier wrote:
> I have a question and a comment about my own patch :)

 :-)

I have applied the patch with some small changes:

> On Thursday 02 July 2015, Ruediger Meier wrote:
> 
> > @@ -367,7 +365,7 @@ static void handle_signal(struct script_control
> > *ctl, int fd)
> >
> >  	bytes = read(fd, &info, sizeof(info));
> >  	if (bytes != sizeof(info)) {
> > -		if (errno == EAGAIN)
> > +		if (bytes < 0 && errno == EAGAIN)
> >  			return;
> 
> Should we also return on EINTR here like we do in handle_io()?

It's probably more robust, Fixed.

> And I see some more potential problems. For example see this snippet 
> from handle_io();
> 
> 	bytes = read(fd, buf, sizeof(buf));
> 	if (bytes < 0) {
> 		DBG(IO, ul_debug(" read failed"));
> 		if (errno == EAGAIN || errno == EINTR)
> 			return;
> 		fail(ctl);
> 	}
> 
> We are using errno after DBG(). But in theory printf() or whatever we do 
> in DBG() could change errno. Wouldn't it be a good idea to write 
> generally all DBG macros errno-invariant?

It seems like overkill solution to modify DBG() and always save errno
on all places. I think it's better to care about this locally on place
where you use DBG(). Fixed in script(1).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

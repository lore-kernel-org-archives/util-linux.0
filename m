Return-Path: util-linux-owner@vger.kernel.org
Received: from hosting.adsl24.co.uk ([84.234.17.171]:53763 "EHLO
	hosting.adsl24.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030221Ab2LHTqE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Dec 2012 14:46:04 -0500
Date: Sat, 8 Dec 2012 19:46:41 +0000
From: Alun <alun.linux@ty-penguin.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add option to fsfreeze to call syncfs() prior to
 freezing.
Message-ID: <20121208194641.3efe5087@aspire.ty-penguin.org.uk>
In-Reply-To: <20121208124743.GA18956@infradead.org>
References: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
	<20121207124415.GA28504@infradead.org>
	<20121207125032.6f4a0fea@pcebbj.staff.aber.ac.uk>
	<20121208124743.GA18956@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 8 Dec 2012 07:47:43 -0500
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Dec 07, 2012 at 12:50:32PM +0000, Alun wrote:
> > Christoph Hellwig <hch@infradead.org> said, in message
> > 20121207124415.GA28504@infradead.org:
> > > 
> > > It might be better to send a kernel patch to do a first async sync
> > > attempt instead of band aiding this in one of the consumers.
> > 
> > That's what I did originally - see
> > http://marc.info/?t=135474654500003&r=1&w=2
> 
> So let's keep the discussion there, if you do exactly the same call
> from userspace the same arguments still apply.

I'm out of my depth when it comes to the politics of all this. So I
think I'm going to bow out now. I'd already got the solution to my
specific issue (write a tiny "syncfs" program and call it from my
script prior to taking a snapshot). While I'd like to try and help
others avoid the same pitfall as me, I'm not motivated enough to
blunder any further into this disagreement.

Cheers,
Alun.

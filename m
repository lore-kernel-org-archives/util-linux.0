Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41791 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201Ab3CTN2Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Mar 2013 09:28:16 -0400
Date: Wed, 20 Mar 2013 14:28:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Alun <alun.linux@ty-penguin.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Add option to fsfreeze to call syncfs() prior to
 freezing.
Message-ID: <20130320132804.GA18443@x2.net.home>
References: <20121207101400.5e46ba48@pcebbj.staff.aber.ac.uk>
 <20121207124415.GA28504@infradead.org>
 <20121207125032.6f4a0fea@pcebbj.staff.aber.ac.uk>
 <20121208124743.GA18956@infradead.org>
 <20121208194641.3efe5087@aspire.ty-penguin.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121208194641.3efe5087@aspire.ty-penguin.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 08, 2012 at 07:46:41PM +0000, Alun wrote:
> On Sat, 8 Dec 2012 07:47:43 -0500
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Fri, Dec 07, 2012 at 12:50:32PM +0000, Alun wrote:
> > > Christoph Hellwig <hch@infradead.org> said, in message
> > > 20121207124415.GA28504@infradead.org:
> > > > 
> > > > It might be better to send a kernel patch to do a first async sync
> > > > attempt instead of band aiding this in one of the consumers.
> > > 
> > > That's what I did originally - see
> > > http://marc.info/?t=135474654500003&r=1&w=2
> > 
> > So let's keep the discussion there, if you do exactly the same call
> > from userspace the same arguments still apply.
> 
> I'm out of my depth when it comes to the politics of all this. So I
> think I'm going to bow out now. I'd already got the solution to my
> specific issue (write a tiny "syncfs" program and call it from my
> script prior to taking a snapshot). While I'd like to try and help
> others avoid the same pitfall as me, I'm not motivated enough to
> blunder any further into this disagreement.

 What is the current status of this issue?

 Do we really need a special option (fsfreeze -s) to call syncfs()?
 Cannot we call it always in fsfreeze(8)? 

 And if the thing will be implemented without the command line option
 then we can later remove the syncfs() call when kernel will be improved.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

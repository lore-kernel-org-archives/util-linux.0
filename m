Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbbEOKyE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 May 2015 06:54:04 -0400
Date: Fri, 15 May 2015 12:54:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: WANG Chao <wcwxyz@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add cpu flags entry to summary output
Message-ID: <20150515105402.GI4834@ws.net.home>
References: <1431486905-63291-1-git-send-email-wcwxyz@gmail.com>
 <20150513093207.GD4834@ws.net.home>
 <20150515073747.GB4280@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150515073747.GB4280@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 15, 2015 at 09:37:48AM +0200, Heiko Carstens wrote:
> On Wed, May 13, 2015 at 11:32:07AM +0200, Karel Zak wrote:
> > On Wed, May 13, 2015 at 11:15:05AM +0800, WANG Chao wrote:
> > >  sys-utils/lscpu.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> >  Applied, thanks.
> 
> Hello Karel,
> 
> just a general question, from my understanding the the summary output
> is supposed to be human readable. I'm not sure how a 500+ character
> line fits into this.

It's last line printed by lscpu, so terminal wraps it and from my
point of view it's still pretty human readable.

> At least it doesn't fit to the current layout of the summary output,
> but maybe that's just my impression.

Any suggestion how to improve it?

I think that provide incomplete info and force people to read also
/proc/cpuinfo is bad idea.
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:46544 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934286AbbEOMku (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2015 08:40:50 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 15 May 2015 13:40:48 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D322617D8042
	for <util-linux@vger.kernel.org>; Fri, 15 May 2015 13:41:33 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4FCeid043712666
	for <util-linux@vger.kernel.org>; Fri, 15 May 2015 12:40:44 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4FCegFr004463
	for <util-linux@vger.kernel.org>; Fri, 15 May 2015 06:40:43 -0600
Date: Fri, 15 May 2015 14:40:42 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: WANG Chao <wcwxyz@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add cpu flags entry to summary output
Message-ID: <20150515124042.GC4280@osiris>
References: <1431486905-63291-1-git-send-email-wcwxyz@gmail.com>
 <20150513093207.GD4834@ws.net.home>
 <20150515073747.GB4280@osiris>
 <20150515105402.GI4834@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150515105402.GI4834@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 15, 2015 at 12:54:02PM +0200, Karel Zak wrote:
> On Fri, May 15, 2015 at 09:37:48AM +0200, Heiko Carstens wrote:
> > On Wed, May 13, 2015 at 11:32:07AM +0200, Karel Zak wrote:
> > > On Wed, May 13, 2015 at 11:15:05AM +0800, WANG Chao wrote:
> > > >  sys-utils/lscpu.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > 
> > >  Applied, thanks.
> > 
> > Hello Karel,
> > 
> > just a general question, from my understanding the the summary output
> > is supposed to be human readable. I'm not sure how a 500+ character
> > line fits into this.
> 
> It's last line printed by lscpu, so terminal wraps it and from my
> point of view it's still pretty human readable.
> 
> > At least it doesn't fit to the current layout of the summary output,
> > but maybe that's just my impression.
> 
> Any suggestion how to improve it?
> 
> I think that provide incomplete info and force people to read also
> /proc/cpuinfo is bad idea.

Ok, I was just wondering what the general "guide line" for stuff like
this is.
When I applied the patch and saw the output it looked strange to me
and it didn't fit to the rest of the output. However that's probably
just my personal taste ;)

Anyway, no further objections.


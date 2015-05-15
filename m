Return-Path: util-linux-owner@vger.kernel.org
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:45222 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133AbbEOHhw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2015 03:37:52 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 15 May 2015 08:37:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B962B219005E
	for <util-linux@vger.kernel.org>; Fri, 15 May 2015 08:37:30 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F7bnFT54919306
	for <util-linux@vger.kernel.org>; Fri, 15 May 2015 07:37:49 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F7bmTB012865
	for <util-linux@vger.kernel.org>; Fri, 15 May 2015 01:37:49 -0600
Date: Fri, 15 May 2015 09:37:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: WANG Chao <wcwxyz@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add cpu flags entry to summary output
Message-ID: <20150515073747.GB4280@osiris>
References: <1431486905-63291-1-git-send-email-wcwxyz@gmail.com>
 <20150513093207.GD4834@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513093207.GD4834@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 13, 2015 at 11:32:07AM +0200, Karel Zak wrote:
> On Wed, May 13, 2015 at 11:15:05AM +0800, WANG Chao wrote:
> >  sys-utils/lscpu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
>  Applied, thanks.

Hello Karel,

just a general question, from my understanding the the summary output
is supposed to be human readable. I'm not sure how a 500+ character
line fits into this.
At least it doesn't fit to the current layout of the summary output,
but maybe that's just my impression.

Just wondering.


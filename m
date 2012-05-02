Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab2EBHXT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 May 2012 03:23:19 -0400
Date: Wed, 2 May 2012 09:22:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: fix calculation due to type mismatch (ix86)
Message-ID: <20120502072252.GA18519@x2.net.home>
References: <1333723993-11424-1-git-send-email-petr.uzel@suse.cz>
 <20120410103422.GJ19784@x2.net.home>
 <20120425151603.GA31410@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120425151603.GA31410@burratino>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 25, 2012 at 10:16:03AM -0500, Jonathan Nieder wrote:
> >> Addresses: https://bugzilla.novell.com/show_bug.cgi?id=754789
> >> Reported-by: Dan Mares <dan.mares@norcrossgroup.com>
> >> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> >
> >  Ah.. pretty dirty bug. Applied, thanks.
> 
> (This is 9c45d49fe01c "sfdisk: fix calculation due to type mismatch
> (ix86)".)  Thanks.  Do you think this fix might belong in currently
> maintained stable/ branches, too, and if so, how can I help make that
> happen?

 I'm going to release 2.21.2 next week.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

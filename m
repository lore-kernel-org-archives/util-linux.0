Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2ITKNC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Sep 2012 06:13:02 -0400
Date: Thu, 20 Sep 2012 12:12:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Amit Uttamchandani <amit.uttam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Return status of mnt_context_mount when helper is used
Message-ID: <20120920101259.GD16499@x2.net.home>
References: <loom.20120919T005618-428@post.gmane.org>
 <20120919100638.GC9602@x2.net.home>
 <20120919221427.GA25659@amit-debian.lg.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120919221427.GA25659@amit-debian.lg.local>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 19, 2012 at 03:14:27PM -0700, Amit Uttamchandani wrote:
> On Wed, Sep 19, 2012 at 12:06:38PM +0200, Karel Zak wrote:
> 
> [snip]
> 
> > 
> > docs:
> > 
> >  * mnt_context_get_status:
> >  * @cxt: mount context
> >  *
> >  * Global libmount status.
> >  *
> >  * The real exit code of the mount.type helper has to be tested
> >  * by  mnt_context_get_helper_status(). The mnt_context_get_status()
> >  * only inform that exec() has been successful.
> > 
> 
> I guess this was implemented after util-linux-2.20.1 since the docs in
> that version does not mention it. Also, it is not implemented in the
> code.
> 
> What would you recommend as a work around?

Hmm... the status from mount.<type> is stored in cxt->helper_status,
but this variable is nowhere exported in v2.20.

> Should I statically link
> libmount and bundle it with the application?

Yes, or update to 2.21.2 or v2.22 :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

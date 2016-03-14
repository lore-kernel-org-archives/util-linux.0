Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185AbcCNPPj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 11:15:39 -0400
Date: Mon, 14 Mar 2016 16:15:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 5/5] unshare: improve wording and formatting in the man
 page
Message-ID: <20160314151535.ol3kmgdnjzy4inue@ws.net.home>
References: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
 <1457949959-2866-1-git-send-email-bensberg@justemail.net>
 <1457950112.2289076.548369274.2DB1DE7E@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457950112.2289076.548369274.2DB1DE7E@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 14, 2016 at 11:08:32AM +0100, Benno Schulenberg wrote:
> > +.BR setgroups (2)
> >  is only callable with CAP_SETGID and CAP_SETGID in a user
> >  namespace (since Linux 3.19) does not give you permission to call setgroups(2)
> > -until after GID map has been set.
> 
> Before the "does" something seems to be missing, but I don't
> know what.

I guess "Linux kernel does not give..." is the right thing.

All the patches applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

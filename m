Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:47302
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751388AbaEBWWB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 May 2014 18:22:01 -0400
Date: Fri, 2 May 2014 18:21:51 -0400
Message-Id: <201405022221.s42MLpT4015462@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Andy Lutomirski <luto@amacapital.net>
CC: util-linux@vger.kernel.org
In-reply-to: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
	(luto@amacapital.net)
Subject: Re: getting rid of "mount: only root can ..."
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Andy Lutomirski <luto@amacapital.net>
> 
> This isn't really true any more.  Can we get rid of those checks or at
> least have an option to turn them off?

My understanding is that whether the user has to be root when running
mount depends on the "user" and "users" options in fstab.  I assume
that "those checks" haven't changed recently because the required
behavior hasn't changed recently.

Dale

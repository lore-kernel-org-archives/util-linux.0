Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:37371
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756752AbaEEW45 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 18:56:57 -0400
Date: Mon, 5 May 2014 18:50:49 -0400
Message-Id: <201405052250.s45Monxm008110@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Andy Lutomirski <luto@amacapital.net>
CC: util-linux@vger.kernel.org
In-reply-to: <CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
	(luto@amacapital.net)
Subject: Re: getting rid of "mount: only root can ..."
References: <CALCETrUbaFwpdiLBv7G8GbkgUuiEgyyBWn0dr8R57NzCdSL9gg@mail.gmail.com>
 <201405022221.s42MLpT4015462@hobgoblin.ariadne.com> <CALCETrUU6ziKYA3RSb_6nEW4HyeR5BLGQ_3SgcnnnLnBX1us0g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Andy Lutomirski <luto@amacapital.net>

> What if mount determined that the requested option wasn't allowed by
> fstab and instead fell back to dropping privileges and trying anyway?

I'm not envisioning the problem that you're addressing very well.

What I was thinking is that, in the best of all worlds, if mount
doesn't permit the requested operation, it should correctly report the
test that failed.  For instance, sometimes only root may perform the
operation, and so mount should say

 "mount: only root can ..."

But if members of group 'foo' are permitted, then it should say

 "mount: only members of 'foo' and root can ..."

etc.

Dale

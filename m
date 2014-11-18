Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbaKRNGH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Nov 2014 08:06:07 -0500
Date: Tue, 18 Nov 2014 14:05:25 +0100
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: improve wording and formattin of man page of
 hwclock
Message-ID: <20141118130525.GM6704@x2.net.home>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
 <1414444693-16407-4-git-send-email-bensberg@justemail.net>
 <544EECC9.2000300@gmx.com>
 <1414526532.495299.184374637.2BF00A99@webmail.messagingengine.com>
 <20141031095142.GX10134@x2.net.home>
 <54566F88.4040101@gmx.com>
 <1415049315.2564297.186608257.366970B7@webmail.messagingengine.com>
 <5458D1A2.40106@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5458D1A2.40106@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 04, 2014 at 08:16:18AM -0500, JWP wrote:
> I do not disagree with you here. I did not want to be heavy handed when
> editing Karel's words, because it is his project and I am new here.

 Karel is not always right. Don't care who is author, bugs have to be
 fixed.

> > "Since v2.26 hwclock --hctosys does a better job at setting the System Clock:
> > it no longer simply copies the time from the Hardware Clock to the System Clock,
> > but it reads the Hardware Clock, applies a compensation for the systematic drift
> > to this read time, and sets the System Clock to the resulting time.  Thus it is
> > no longer necessary to run hwclock --adjust before doing hwclock --hctosys, and
> > therefore hwclock can be used very early on in the boot process when the root
> > filesystem is still read-only."
> > 
> > Any amendments?
> 
> Nope, that seems quite complete Benno!

 Benno, re-send a complete patch with this change. Please.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

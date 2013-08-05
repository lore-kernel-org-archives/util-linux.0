Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab3HEIkl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Aug 2013 04:40:41 -0400
Date: Mon, 5 Aug 2013 10:40:31 +0200
From: Karel Zak <kzak@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: util-linux@vger.kernel.org, rleigh@debian.org
Subject: Re: [PATCH] get_line fixes for wide characters and overflows
Message-ID: <20130805084031.GA15105@x2.net.home>
References: <20130716232033.GD9944@gallifrey>
 <20130719223501.GA13613@gallifrey>
 <20130801110159.GA2484@x2.net.home>
 <20130801125703.GA7815@gallifrey>
 <20130801140407.GC2484@x2.net.home>
 <20130803123830.GB5098@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130803123830.GB5098@gallifrey>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 03, 2013 at 01:38:30PM +0100, Dr. David Alan Gilbert wrote:
> u mean. So I have added p < &Line[LineLen - 1]
> >  check to the for() where the code copies the multibyte buffer to line buffer.
> >  See git tree for more details.
> 
> OK; so I think with your ...ea608842 change then it should work (not tried
> to push it); but with that change hopefully the extra check in ..623bc74f
> should never trigger; which is good because if it does then I think you'll
> end up outputing part of a wide character which would get messy.
> 
> One thing I tried to do in my change was remove the magic '4's that
> pop up in a few places because of the wide characters.

then it would be better to use #define ...

Anyway, the more.c code is so horrible that it does not make sense to
waste time to try to make it perfect. It would be better to do
complete refactoring (some control struct, small functions, no global
variables, etc.)

> (Any particular reason you prefered this over my fix?)

Unfortunately I somehow missed the widechar issue in my first commit,
so your original patch was no bad (except the global const variables).

Thanks, look forward to see more patches from you :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

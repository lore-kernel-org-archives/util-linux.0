Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964786AbbBBKfW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 05:35:22 -0500
Date: Mon, 2 Feb 2015 11:35:07 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] more: fix control character display bug
Message-ID: <20150202103507.GJ16162@ws.net.home>
References: <1422608050-28600-1-git-send-email-kerolasa@iki.fi>
 <CAG27Bk08wUXz=s4dRBcYiwZ+KO=3oT3csQH6g3aAoTAk_+0G0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk08wUXz=s4dRBcYiwZ+KO=3oT3csQH6g3aAoTAk_+0G0Q@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 30, 2015 at 05:05:55PM +0100, Sami Kerola wrote:
> On 30 January 2015 at 09:54, Sami Kerola <kerolasa@iki.fi> wrote:
> > This removes isprint(c) column++ from get_line() that made underlining,
> > bold, and other control characters to cause more display to wrap lines
> > incorrectly.  Easiest way to see the difference is to run following
> > before and after compiling this change.
> >
> > PAGER=./more man man
> 
> Hold on. The change also alter press \n that earlier made more(1) to
> more forward one line, but after the change only new line appears. I
> will try to write better change sometime soon.

 I'm going to postpone this to provide time for better bugfix, I think
 it's better one old bug than another unknown hidden bug(s) :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbdB1QUp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Feb 2017 11:20:45 -0500
Date: Tue, 28 Feb 2017 17:10:00 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [V2 0/4] hwclock: remove date(1)
Message-ID: <20170228161000.ijlouecku6a37quk@ws.net.home>
References: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
 <20170228133713.377klbjm44roizx6@ws.net.home>
 <0d36f495-d691-9e80-9c05-461d3563b468@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d36f495-d691-9e80-9c05-461d3563b468@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 28, 2017 at 10:23:39AM -0500, J William Piggott wrote:
> My impression is that the original parse_datetime() is stable. It seems
> like most of the changes now involve parse_datetime2() to expand
> capabilities. I was using the new api only for the debug output; I
> thought if changes were ever needed in the parser it might be helpful.
> Since that may be unlikely, and since you don't like the debugging,
> parse_datetime2() along with all of its extensions can be removed.

Fortunately, this stuff is easy to test, so we can create regression
tests for all the possible formats to be sure we do not introduce any
regression.

> > I guess it will be possible to move it to lib/parse-datetime.c and use
> > it on another places in util-linux (instead of our minimalistic
> > parse_datetime()), right?
> 
> Sure, I think a name change to avoid confusion with gnulib would be
> good. Maybe just parse_date.c?

Sounds, good.

> I will work on these changes Karel.

OK.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

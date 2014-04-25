Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:56217
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840AbaDYOdv (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Apr 2014 10:33:51 -0400
Date: Fri, 25 Apr 2014 10:27:44 -0400
Message-Id: <201404251427.s3PERiaV008964@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: nyerup@one.com
CC: util-linux@vger.kernel.org
In-reply-to: <20140425082133.GA3790@one.com> (nyerup@one.com)
Subject: Re: Using script(1) to log all user sessions
References: <20140425082133.GA3790@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Jesper Dahl Nyerup <nyerup@one.com>

> 1. Adding a daemon next to script(1) and scriptreplay(1), eg.
> scriptcollect(1), to be in the receiving end of the traffic, optionally
> handling the timing functionality, and finally storing data in the same
> manner script(1) would.

You might want to consider using syslog(3) for this.  Or conversely,
if syslog won't work in your environment, that might indicate
improvements that are needed in syslog.

Dale

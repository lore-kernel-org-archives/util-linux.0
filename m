Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755936AbbGTIz6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jul 2015 04:55:58 -0400
Date: Mon, 20 Jul 2015 10:55:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] logger: do not exit when socket errors are not enforced
Message-ID: <20150720085556.GE11633@ws.net.home>
References: <1437337152-947-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437337152-947-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 19, 2015 at 09:19:12PM +0100, Sami Kerola wrote:
> The libc openlog(3) does not have error detection whether unix socket
> could be opened.  As a side effect that made it possible to use logger
> even if syslogd was not running.  Of course user message in these cases
> were lost.  This change makes the logger do behave similar way again, so
> that sysvinit scripts can successfully pipe messages to logger when ever.

Applied, thanks 
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

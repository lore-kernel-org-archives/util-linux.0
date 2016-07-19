Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37962 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbcGSJKp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jul 2016 05:10:45 -0400
Date: Tue, 19 Jul 2016 11:10:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] logger: remove trailing spaces when outputing to journal
Message-ID: <20160719091043.bybrrhdzeb43j3tz@ws.net.home>
References: <20160718203457.3911-1-kerolasa@iki.fi>
 <alpine.LNX.2.20.1607182146130.10723@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1607182146130.10723@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 18, 2016 at 09:49:27PM +0100, Sami Kerola wrote:
> Hi Sami, no repeat 100 time: do not send patches before testing them.

  Always code as if the person who ends up maintaining your code is a
  violent psychopath who knows where you live [1].

... just to make you feel better :-))

[1] http://c2.com/cgi/wiki?CodeForTheMaintainer

> ---
>  misc-utils/logger.c            | 7 ++-----
>  tests/expected/logger/journald | 1 -
>  2 files changed, 2 insertions(+), 6 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

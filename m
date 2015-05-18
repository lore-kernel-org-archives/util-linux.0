Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40714 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282AbbERJoF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 May 2015 05:44:05 -0400
Date: Mon, 18 May 2015 11:44:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] cal: fix January 1753 week number printout
Message-ID: <20150518094402.GM4834@ws.net.home>
References: <1431883662-9121-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431883662-9121-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 17, 2015 at 06:27:42PM +0100, Sami Kerola wrote:
>  misc-utils/cal.c           |  2 +-
>  tests/expected/cal/jan1753 | 19 +++++++++++++++++++
>  tests/ts/cal/jan1753       | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 tests/expected/cal/jan1753
>  create mode 100755 tests/ts/cal/jan1753

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

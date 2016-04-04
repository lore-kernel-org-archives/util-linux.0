Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43740 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932220AbcDDIdI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Apr 2016 04:33:08 -0400
Date: Mon, 4 Apr 2016 10:33:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] colcrt: avoid the command getting hung [afl]
Message-ID: <20160404083305.gfahqr7dwvqgmpiq@ws.net.home>
References: <1459612694-30128-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459612694-30128-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 02, 2016 at 04:58:14PM +0100, Sami Kerola wrote:
>  tests/colcrt                            | Bin 0 -> 14720 bytes
>  tests/expected/colcrt/regressions-hang1 |   3 +++
>  tests/ts/colcrt/hang1                   |   1 +
>  tests/ts/colcrt/regressions             |   3 ++-
>  text-utils/colcrt.c                     |   7 +++++++

 Applied to the "next" branch (does not seem so critical for v2.28),
 thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

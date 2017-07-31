Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdGaL5K (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 07:57:10 -0400
Date: Mon, 31 Jul 2017 13:57:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] tunelp: use linux header
Message-ID: <20170731115707.4oo7tmdlhyld3ah4@ws.net.home>
References: <20170729153530.9119-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170729153530.9119-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 29, 2017 at 04:35:30PM +0100, Sami Kerola wrote:
>  sys-utils/Makemodule.am |  2 +-
>  sys-utils/lp.h          | 83 -------------------------------------------------
>  sys-utils/tunelp.8      | 24 --------------
>  sys-utils/tunelp.c      | 14 ++-------
>  4 files changed, 3 insertions(+), 120 deletions(-)
>  delete mode 100644 sys-utils/lp.h

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

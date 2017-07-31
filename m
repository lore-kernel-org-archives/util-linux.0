Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbdGaLzl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 07:55:41 -0400
Date: Mon, 31 Jul 2017 13:55:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] wdctl: do not call fsync(2) when closing watchdog device
Message-ID: <20170731115538.kyg7hii7bj3plyjl@ws.net.home>
References: <20170723212037.923-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170723212037.923-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 23, 2017 at 10:20:37PM +0100, Sami Kerola wrote:
>  sys-utils/wdctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

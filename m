Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52664 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbaAGLUZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jan 2014 06:20:25 -0500
Date: Tue, 7 Jan 2014 12:20:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Message-ID: <20140107112015.GC2658@x2.net.home>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 06, 2014 at 11:39:08PM +0000, Sami Kerola wrote:
>  configure.ac             |   3 +
>  misc-utils/Makemodule.am |   3 +-
>  misc-utils/sd-daemon.c   | 520 -----------------------------------------------
>  misc-utils/sd-daemon.h   | 282 -------------------------
>  misc-utils/uuidd.c       |   2 +-
>  5 files changed, 5 insertions(+), 805 deletions(-)
>  delete mode 100644 misc-utils/sd-daemon.c
>  delete mode 100644 misc-utils/sd-daemon.h

 Applied with some minor changes, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

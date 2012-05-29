Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43662 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab2E2H7P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 03:59:15 -0400
Date: Tue, 29 May 2012 09:59:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] logger: use memcpy instead of bcopy
Message-ID: <20120529075913.GD3757@x2.net.home>
References: <20120527232300.GA15566@gaara.hadrons.org>
 <1338228179-14512-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338228179-14512-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 28, 2012 at 02:02:59PM -0400, Dave Reisner wrote:
>  misc-utils/logger.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

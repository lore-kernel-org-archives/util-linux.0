Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5949 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab2E2H6r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 03:58:47 -0400
Date: Tue, 29 May 2012 09:58:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] logger: avoid explicit fclose(stdout)
Message-ID: <20120529075840.GC3757@x2.net.home>
References: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337805360-16469-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 23, 2012 at 04:35:58PM -0400, Dave Reisner wrote:
>  misc-utils/logger.c |    2 --
>  1 file changed, 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

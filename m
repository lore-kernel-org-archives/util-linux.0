Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbbHXI6h (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Aug 2015 04:58:37 -0400
Date: Mon, 24 Aug 2015 10:58:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] hwclock: fix signed/unsigned comparison warning on
 alpha
Message-ID: <20150824085835.GK1689@ws.net.home>
References: <1440166409-32215-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440166409-32215-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 21, 2015 at 04:13:27PM +0200, Andreas Henriksson wrote:
>  sys-utils/hwclock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied all three patches. It would be nice to test it on alphas.
Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

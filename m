Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36506 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547AbaHUNKW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Aug 2014 09:10:22 -0400
Date: Thu, 21 Aug 2014 15:10:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mountpoint: drop S_ISDIR check
Message-ID: <20140821131015.GC14708@x2.net.home>
References: <1408625292-2445-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408625292-2445-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 21, 2014 at 08:48:12AM -0400, Dave Reisner wrote:
>  sys-utils/mountpoint.c | 6 ------
>  1 file changed, 6 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

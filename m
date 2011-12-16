Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161Ab1LPKsF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Dec 2011 05:48:05 -0500
Date: Fri, 16 Dec 2011 11:48:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 2/2] findmnt: support alternative location of fstab
Message-ID: <20111216104802.GE25486@nb.net.home>
References: <1323629885-17940-1-git-send-email-dreisner@archlinux.org> <1323629885-17940-3-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323629885-17940-3-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 11, 2011 at 01:58:05PM -0500, Dave Reisner wrote:
>  misc-utils/findmnt.8 |    6 ++++--
>  misc-utils/findmnt.c |    6 +++---
>  2 files changed, 7 insertions(+), 5 deletions(-)

 Applied, thanks. My plan is to support this feature in new
 mount(8) (libmount/src/sample/mount.c) too.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

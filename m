Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933001Ab2IUKIs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Sep 2012 06:08:48 -0400
Date: Fri, 21 Sep 2012 12:08:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Gundersen <teg@jklm.no>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: don't warp the systemtime if the RTC is in UTC
Message-ID: <20120921100845.GB17643@x2.net.home>
References: <1348178566-12850-1-git-send-email-teg@jklm.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348178566-12850-1-git-send-email-teg@jklm.no>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 20, 2012 at 10:02:46PM +0000, Tom Gundersen wrote:
>  sys-utils/hwclock.8 | 11 +++++++----
>  sys-utils/hwclock.c | 17 +++++++++++++++--
>  2 files changed, 22 insertions(+), 6 deletions(-)

 Applied, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

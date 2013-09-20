Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25237 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051Ab3ITIRD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Sep 2013 04:17:03 -0400
Date: Fri, 20 Sep 2013 10:16:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount/utils: use memmove when overlap possible
Message-ID: <20130920081658.GB21960@x2.net.home>
References: <1379451909-23800-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379451909-23800-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 17, 2013 at 05:05:09PM -0400, Dave Reisner wrote:
>  libmount/src/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Oh, stupid bug. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

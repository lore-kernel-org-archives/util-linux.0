Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757997Ab1I2XmL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Sep 2011 19:42:11 -0400
Date: Fri, 30 Sep 2011 01:42:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 1/2] xalloc: check for NULL before calling strdup
Message-ID: <20110929234200.GA13001@nb.net.home>
References: <1317322602-24884-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317322602-24884-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 29, 2011 at 02:56:41PM -0400, Dave Reisner wrote:
>  include/xalloc.h |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

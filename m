Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51588 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756042AbbJIJtJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Oct 2015 05:49:09 -0400
Date: Fri, 9 Oct 2015 11:49:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] [pull] mostly uuidd changes
Message-ID: <20151009094908.GA2356@ws.net.home>
References: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 03, 2015 at 07:31:03PM +0100, Sami Kerola wrote:
>   uuidd: slice up the usage text and normalize its layout
>   blkid, uuidd, uuidgen: assume getopt.h and getopt.h are available
>   uuidd: use signalfd() and setup_timer()
>   uuidd: fix shadow declaration

 Applied, thanks! 

 I see we don't have regression tests for uuidd. It would be nice to
 have something before release ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

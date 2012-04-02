Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4505 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab2DBLWO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Apr 2012 07:22:14 -0400
Date: Mon, 2 Apr 2012 13:22:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Paul Fox <pgf@laptop.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH]  rtcwake:  only invoke RTC_AIE_ON/OFF ioctls in pairs
Message-ID: <20120402112201.GB1084@x2.net.home>
References: <11482.1333111723@foxharp.boston.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11482.1333111723@foxharp.boston.ma.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 30, 2012 at 08:48:43AM -0400, Paul Fox wrote:
>  sys-utils/rtcwake.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

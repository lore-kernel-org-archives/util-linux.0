Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28772 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab2IKHgX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Sep 2012 03:36:23 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q8B7aNKG023740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 11 Sep 2012 03:36:23 -0400
Date: Tue, 11 Sep 2012 09:36:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Ondrej Oprala <ooprala@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFE] hwclock: new --compare option
Message-ID: <20120911073621.GD4576@x2.net.home>
References: <503E45E3.8010001@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <503E45E3.8010001@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 29, 2012 at 06:40:03PM +0200, Ondrej Oprala wrote:
> From 3a5494a1c32e2698de0508cec70149bed8149032 Mon Sep 17 00:00:00 2001
> From: Ondrej Oprala <ooprala@redhat.com>
> Date: Wed, 29 Aug 2012 18:11:15 +0200
> Subject: [PATCH] hwclock: add a new --compare option
> 
> The new option imitates adjtimex -c functionality and outputs
> the drift in 10 second intervals.
> ---
>  sys-utils/hwclock.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 4 deletions(-)

 Applied with some changes (I have added hw-time and system-time
 columns to the output), thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

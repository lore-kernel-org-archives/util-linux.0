Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbbLJJTR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Dec 2015 04:19:17 -0500
Date: Thu, 10 Dec 2015 10:19:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] blkdiscard: some output fixes
Message-ID: <20151210091909.GD2353@ws.net.home>
References: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 09, 2015 at 06:43:09PM +0100, Ruediger Meier wrote:
>   blkdiscard: fix timeval comparison inclusive usecs
>   blkdiscard: fix stats reporting (off by one)
>   blkdiscard: don't report "zero range" at the end
>   tests: blkdiscard, check return values
>   tests: skip BLKDISCARD if unsupported

Merged, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

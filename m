Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38628 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754107AbbFRKWJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Jun 2015 06:22:09 -0400
Date: Thu, 18 Jun 2015 12:22:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Romain Bouvier <skunnyk@alteroot.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Return correct value for uuid_generate_time_safe
Message-ID: <20150618102205.GD1992@ws.net.home>
References: <361341ee5502b6112bc452c27c15ea9f@webmail.alteroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <361341ee5502b6112bc452c27c15ea9f@webmail.alteroot.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 17, 2015 at 03:59:18PM +0000, Romain Bouvier wrote:
> Make return value consistent for consecutive calls.
> If you call uuid_generate_time_safe, it should always
> return -1 if it can't guarantee uniqueness.
> Without this patch, on consecutive calls where it can't guarantee
> uniqueness, the first call returns -1, but later calls return 0.
> 
> Reported-by: Romain Bouvier <skunnyk@alteroot.org>
> Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> 
> ---
>  libuuid/src/gen_uuid.c | 3 +++
>  1 file changed, 3 insertions(+)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

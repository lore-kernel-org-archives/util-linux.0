Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40580 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015AbcDNK7l (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Apr 2016 06:59:41 -0400
Date: Thu, 14 Apr 2016 12:59:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] build-sys: add --enable-libuuid-force-uuidd
Message-ID: <20160414105939.x6ui4t4lpdriojiv@ws.net.home>
References: <20160406122220.24mkbuz3rrkyuqza@ws.net.home>
 <1459950187-29394-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459950187-29394-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 06, 2016 at 03:43:07PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> To build libuuid with uuidd support even though the daemon is
> disabled (--disable-uuidd).
> 
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  configure.ac | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Ah, I forgot to merge this to v2.28. Sorry. Applied now. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

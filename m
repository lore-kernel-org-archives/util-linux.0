Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbaFIIoI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Jun 2014 04:44:08 -0400
Date: Mon, 9 Jun 2014 10:43:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Tobias Klausmann <klausman@schwarzvogel.de>
Subject: Re: [PATCH] libfdisk: fix bsd_translate_fstype() for alpha
Message-ID: <20140609084355.GD30975@x2.net.home>
References: <20140608104251.GA72528@skade.schwarzvogel.de>
 <1402234368-17174-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402234368-17174-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 08, 2014 at 03:32:48PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  libfdisk/src/bsd.c | 2 ++
>  1 file changed, 2 insertions(+)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

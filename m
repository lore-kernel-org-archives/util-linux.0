Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20970 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbaAFNBk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jan 2014 08:01:40 -0500
Date: Mon, 6 Jan 2014 14:01:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Andrey Vagin <avagin@openvz.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hexdump: don't access hex after freeing it
Message-ID: <20140106130135.GD31045@x2.net.home>
References: <1388151906-9057-1-git-send-email-avagin@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388151906-9057-1-git-send-email-avagin@openvz.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 27, 2013 at 05:45:06PM +0400, Andrey Vagin wrote:
>  text-utils/hexdump.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

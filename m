Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbaJNKOZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Oct 2014 06:14:25 -0400
Date: Tue, 14 Oct 2014 12:14:22 +0200
From: Karel Zak <kzak@redhat.com>
To: "Raphael S. Carvalho" <raphaelsc@cloudius-systems.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: fix underflow when offset is greater than
 device size
Message-ID: <20141014101422.GS8057@x2.net.home>
References: <1412815567-2565-1-git-send-email-raphael.scarv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412815567-2565-1-git-send-email-raphael.scarv@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 08, 2014 at 09:46:07PM -0300, Raphael S. Carvalho wrote:
>  sys-utils/blkdiscard.c | 2 ++
>  1 file changed, 2 insertions(+)

 Applied, thanks.

   Karel 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

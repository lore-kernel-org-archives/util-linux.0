Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbcBXLxN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Feb 2016 06:53:13 -0500
Date: Wed, 24 Feb 2016 12:53:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] chrt: fix case SCHED_RR
Message-ID: <20160224115310.huekso4ow2awmhuo@ws.net.home>
References: <1456313389-7290-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456313389-7290-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 24, 2016 at 12:29:48PM +0100, Ruediger Meier wrote:
>  schedutils/chrt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Ah, sorry for this bug -- both patches applied. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756757AbcCVJwQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 05:52:16 -0400
Date: Tue, 22 Mar 2016 10:52:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Always make echo work after performing getpasswd even if
 root account is locked
Message-ID: <20160322095215.bfbgiyrgy3tq6urm@ws.net.home>
References: <1458639539-3457-1-git-send-email-werner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458639539-3457-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 22, 2016 at 10:38:59AM +0100, Werner Fink wrote:
>  login-utils/sulogin.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

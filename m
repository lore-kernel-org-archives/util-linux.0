Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaJAICr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 04:02:47 -0400
Date: Wed, 1 Oct 2014 10:02:37 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?S=F8ren?= Holm <sgh@sgh.dk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Don't return root if path contains // or ending /
Message-ID: <20141001080237.GG26272@x2.net.home>
References: <1411749311-16666-1-git-send-email-sgh@sgh.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1411749311-16666-1-git-send-email-sgh@sgh.dk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 26, 2014 at 06:35:11PM +0200, Søren Holm wrote:
>  libmount/src/tab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Stupid mistake. Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

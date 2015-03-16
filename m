Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37572 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbbCPK0l (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 06:26:41 -0400
Date: Mon, 16 Mar 2015 11:26:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Stef Walter <stefw@redhat.com>
Cc: util-linux@vger.kernel.org, Stef Walter <stef@thewalter.net>
Subject: Re: [PATCH] logger: Fix use of errno after strtol() without zeroing
 first
Message-ID: <20150316102639.GB28925@ws.net.home>
References: <1426425812-24033-1-git-send-email-stefw@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426425812-24033-1-git-send-email-stefw@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 02:23:32PM +0100, Stef Walter wrote:
>  misc-utils/logger.c | 1 +
>  1 file changed, 1 insertion(+)

 Applied, thanks.
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

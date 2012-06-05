Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756853Ab2FENwC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Jun 2012 09:52:02 -0400
Date: Tue, 5 Jun 2012 15:51:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] su: preserve errno in cleanup_pam()
Message-ID: <20120605135158.GN14536@x2.net.home>
References: <1338903084-19479-1-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338903084-19479-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 05, 2012 at 03:31:24PM +0200, Ludwig Nussel wrote:
>  login-utils/su.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

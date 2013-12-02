Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab3LBKLb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Dec 2013 05:11:31 -0500
Date: Mon, 2 Dec 2013 11:11:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] losetup, agetty: remove unnecessary if's before
 free()
Message-ID: <20131202101120.GX5572@x2.net.home>
References: <1384909024-562-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384909024-562-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 20, 2013 at 12:57:03AM +0000, Sami Kerola wrote:
>  sys-utils/losetup.c | 6 ++----
>  term-utils/agetty.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

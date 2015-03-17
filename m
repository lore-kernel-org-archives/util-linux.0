Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932539AbbCQJQd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 05:16:33 -0400
Date: Tue, 17 Mar 2015 10:16:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: fix compiler warnings
Message-ID: <20150317091622.GR28925@ws.net.home>
References: <1426550147-24964-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426550147-24964-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 16, 2015 at 11:55:47PM +0000, Sami Kerola wrote:
>  libblkid/src/superblocks/bcache.c | 2 +-
>  libblkid/src/superblocks/minix.c  | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

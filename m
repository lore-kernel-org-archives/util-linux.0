Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdJWOdx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 23 Oct 2017 10:33:53 -0400
Date: Mon, 23 Oct 2017 16:33:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: Add support for LUKS2 and new LABEL attributes.
Message-ID: <20171023143350.kssx22zb6hqucu74@ws.net.home>
References: <20171023142651.15930-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171023142651.15930-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 23, 2017 at 04:26:51PM +0200, Milan Broz wrote:
>  libblkid/src/superblocks/luks.c | 42 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

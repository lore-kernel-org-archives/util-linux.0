Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18641 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbaILIbS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Sep 2014 04:31:18 -0400
Date: Fri, 12 Sep 2014 10:31:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/17] lib: avoid use of obsolete getpass() function
Message-ID: <20140912083106.GS21325@x2.net.home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
 <1410093785-17537-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410093785-17537-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 07, 2014 at 01:42:51PM +0100, Sami Kerola wrote:
> Reference: http://man7.org/linux/man-pages/man3/getpass.3.html
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  include/xgetpass.h |  2 +-
>  lib/xgetpass.c     | 56 +++++++++++++++++++++++++-----------------------------
>  2 files changed, 27 insertions(+), 31 deletions(-)

 I have a better way how to fix it:

   git rm lib/xgetpass.c include/xgetpass.h

 :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

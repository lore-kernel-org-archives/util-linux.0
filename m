Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754735Ab1FHLff (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jun 2011 07:35:35 -0400
Date: Wed, 8 Jun 2011 13:35:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] simpleinit: remove NLS support
Message-ID: <20110608113532.GC2150@nb.net.home>
References: <1307042126-7242-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307042126-7242-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 02, 2011 at 09:15:26PM +0200, Francesco Cosoleto wrote:
> About 50 messages to translate less.
> 
> shutdown(1) is deprecated since July 2007, simpleinit(1), initctl(1)
> are deprecated since December 2010. They are marked as deprecated why
> nobody uses these implementations.

 I have committed something completely different: 

        commit 0ff9e65ea30ee7e3548d11992a180d95d0a02fe9
        Author: Karel Zak <kzak@redhat.com>
        Date:   Wed Jun 8 13:20:37 2011 +0200

            simpleinit: remove this deprecated set of utils
            
            Signed-off-by: Karel Zak <kzak@redhat.com>

         Makefile.am             |    6 +-
         configure.ac            |    9 -
         simpleinit/.gitignore   |    3 -
         simpleinit/Makefile.am  |   27 -
         simpleinit/fastboot.8   |    1 -
         simpleinit/fasthalt.8   |    1 -
         simpleinit/halt.8       |    1 -
         simpleinit/initctl.8    |  110 -----
         simpleinit/initctl.c    |  217 --------
         simpleinit/reboot.8     |    1 -
         simpleinit/shutdown.8   |  169 -------
         simpleinit/shutdown.c   |  747 ----------------------------
         simpleinit/simpleinit.8 |  180 -------
         simpleinit/simpleinit.c | 1251 -----------------------------------------------
         simpleinit/simpleinit.h |   28 -
         15 files changed, 1 insertions(+), 2750 deletions(-)

 :-)

    Karel


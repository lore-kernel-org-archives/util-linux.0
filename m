Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932879AbdCaK5Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 31 Mar 2017 06:57:16 -0400
Date: Fri, 31 Mar 2017 12:57:11 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: remove 1994 Award BIOS workaround
Message-ID: <20170331105711.2snwcurc6t5hu44k@ws.net.home>
References: <305b9d73-7210-b8f2-cd8b-d221d612dc8d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <305b9d73-7210-b8f2-cd8b-d221d612dc8d@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 24, 2017 at 11:03:16AM -0400, J William Piggott wrote:
>  sys-utils/hwclock.8.in | 38 +------------------------------
>  sys-utils/hwclock.c    | 62 --------------------------------------------------
>  sys-utils/hwclock.h    |  1 -
>  3 files changed, 1 insertion(+), 100 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

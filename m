Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbdATKK0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 20 Jan 2017 05:10:26 -0500
Date: Fri, 20 Jan 2017 11:10:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Carlos Santos <casantos@datacom.ind.br>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix compilation with ncurses and uClibc or musl libc
Message-ID: <20170120101005.do3cojj7htwo7vxi@ws.net.home>
References: <1484854057-2506-1-git-send-email-casantos@datacom.ind.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484854057-2506-1-git-send-email-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 19, 2017 at 05:27:37PM -0200, Carlos Santos wrote:
>  text-utils/colcrt.c | 2 +-
>  text-utils/colrm.c  | 2 +-
>  text-utils/column.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

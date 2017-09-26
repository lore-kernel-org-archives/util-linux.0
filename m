Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbdIZKMI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 Sep 2017 06:12:08 -0400
Date: Tue, 26 Sep 2017 12:12:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] setproctitle: fix out of boundary access
Message-ID: <20170926101203.ku5rflhumet4bplk@ws.net.home>
References: <20170925195534.GB25565@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925195534.GB25565@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 25, 2017 at 09:55:34PM +0200, Tobias Stoeckmann wrote:
>  lib/setproctitle.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

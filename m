Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdLDMFN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 4 Dec 2017 07:05:13 -0500
Date: Mon, 4 Dec 2017 13:05:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] vipw: do not let editor to inherit open file
 descriptors
Message-ID: <20171204120510.v464twalzuoedrrq@ws.net.home>
References: <20171203125117.28159-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171203125117.28159-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 03, 2017 at 12:51:14PM +0000, Sami Kerola wrote:
>  login-utils/vipw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

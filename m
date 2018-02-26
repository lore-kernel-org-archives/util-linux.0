Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752325AbeBZK4Y (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Feb 2018 05:56:24 -0500
Date: Mon, 26 Feb 2018 11:56:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] fincore: Handle large files on 32 bit without LFS
Message-ID: <20180226105620.tkwzauzhs5qc5kpp@ws.net.home>
References: <20180225192758.GB5871@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180225192758.GB5871@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 25, 2018 at 08:27:59PM +0100, Tobias Stoeckmann wrote:
>  misc-utils/fincore.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

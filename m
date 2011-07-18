Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab1GRVry (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 17:47:54 -0400
Date: Mon, 18 Jul 2011 23:47:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] dmesg: fix segfault
Message-ID: <20110718214747.GA4354@nb.redhat.com>
References: <CACpTwpHENHMCSxkh4a-Z5SHVifa=M7ai2XNtfY1An2TiUPc84A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACpTwpHENHMCSxkh4a-Z5SHVifa=M7ai2XNtfY1An2TiUPc84A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 18, 2011 at 07:37:22PM +0200, Marc-Antoine Perennou wrote:
> An element declared as size_t cannot be detected as negative (len < 0)
> is always false.
> This can lead to an infinite loop causing a segmentation fault.
> Check if len is equal to -1 or -2 instead
> 
> Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
> ---
>  sys-utils/dmesg.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

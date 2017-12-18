Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752793AbdLRMII (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Dec 2017 07:08:08 -0500
Date: Mon, 18 Dec 2017 13:08:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: fix overflow in implicit constant conversion
Message-ID: <20171218120804.nt3qggkudc3xjghc@ws.net.home>
References: <20171217064550.7762-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171217064550.7762-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 17, 2017 at 06:45:50AM +0000, Sami Kerola wrote:
> -static const char bcache_magic[] = {
> +static const uint8_t bcache_magic[] = {
>  	0xc6, 0x85, 0x73, 0xf6, 0x4e, 0x1a, 0x45, 0xca,
>  	0x82, 0x65, 0xf5, 0x7f, 0x48, 0xba, 0x6d, 0x81
>  };

Well, libblkid assumes magic number as a string, and it seems we do
not need the variable bcache_magic[] in the code at all. So I have
committed:

    -#define BCACHE_SB_MAGIC     bcache_magic
    +#define BCACHE_SB_MAGIC     "\xc6\x85\x73\xf6\x4e\x1a\x45\xca\x82\x65\xf5\x7f\x48\xba\x6d\x81"

etc.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

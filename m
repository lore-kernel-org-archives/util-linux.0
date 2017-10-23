Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f182.google.com ([209.85.223.182]:47512 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbdJWTiX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Oct 2017 15:38:23 -0400
Received: by mail-io0-f182.google.com with SMTP id h70so21344262ioi.4
        for <util-linux@vger.kernel.org>; Mon, 23 Oct 2017 12:38:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20171018071531.GA2929@infradead.org>
References: <20171016213734.23237-1-kerolasa@iki.fi> <20171018071531.GA2929@infradead.org>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 23 Oct 2017 20:38:20 +0100
Message-ID: <CAG27Bk0aKyD_ZuTOUTM4jgvaioWGLA2-jUHeZTABO+0hz354gw@mail.gmail.com>
Subject: Re: [PATCH] libuuid: use explicit_bzero() in uuid_clear() when possible
To: Christoph Hellwig <hch@infradead.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18 October 2017 at 08:15, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Oct 16, 2017 at 10:37:34PM +0100, Sami Kerola wrote:
>> This ensures value is blanked.  It is possible compiler optimization removed
>> earlier uuid_clear() calls as unnecessary if value was not used after clear.
>
> Can you explain the logic behind this a bit more?  If no one uses the
> uuid later it doesn't matter if we cleared it or not.

When value is not used compiler might deside to remove such clearning
altogether. To me uuid_clear() is promise that the value disappears, and
that is what the function should do. Who knows, maybe someone uses
uuids to something sensitive that must be cleared not to leak secrets.
In that sort of context one really hopes promise of clearing is kept.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

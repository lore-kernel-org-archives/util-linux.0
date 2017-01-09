Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.nue.novell.com ([195.135.221.5]:38460 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030771AbdAIOcQ (ORCPT
        <rfc822;groupwise-util-linux@vger.kernel.org:0:0>);
        Mon, 9 Jan 2017 09:32:16 -0500
From: =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>,
        Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH] newgrp: use libc explicit_bzero() when it is available
In-Reply-To: <4462d609-2049-7484-d6a8-53daf9b4534f@bernhard-voelker.de>
References: <20170105223340.2721-1-kerolasa@iki.fi> <4462d609-2049-7484-d6a8-53daf9b4534f@bernhard-voelker.de>
Date: Mon, 09 Jan 2017 15:31:54 +0100
Message-ID: <mpseg0cl2xx.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bernhard Voelker <mail@bernhard-voelker.de> writes:
> Do you think it's worth making things even more complicated
> for overwriting a simple string?  I mean, a simple
>
>   for (char *c = xpwd; c; c++)
>     c = '\0';
>
> would do, wouldn't it?

Play around with this example:

https://godbolt.org/g/SOSqt2

Compilers are pretty good at eliminated dead code as soon as you enable
optimizations nowadays, it's actually not that easy.

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

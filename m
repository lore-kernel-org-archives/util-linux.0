Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61766 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbaLSJuI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Dec 2014 04:50:08 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so1144844wiw.10
        for <util-linux@vger.kernel.org>; Fri, 19 Dec 2014 01:50:07 -0800 (PST)
Date: Fri, 19 Dec 2014 09:50:04 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 08/10] include/c: define UL_ASAN_BLACKLIST address_sanitizer
 function attribute
In-Reply-To: <1417365732.1298240.196969401.607516E2@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.03.1412190944470.8955@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi> <1417355862-16935-9-git-send-email-kerolasa@iki.fi> <1417365732.1298240.196969401.607516E2@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 30 Nov 2014, Benno Schulenberg wrote:

> On Sun, Nov 30, 2014, at 14:57, Sami Kerola wrote:
>> The UL_ASAN_BLACKLIST allows AddressSanitizer to be set off for functions
>> that cannot be checked.
>
> s/set/switched/

Thanks Benno.

Fixed in

https://github.com/kerolasa/lelux-utiliteetit/commit/03caf13f09b1224aa7bd296ed223785b61ca4c7e

> (Because "set off" means "triggered", which means "run" -- but
> the intention is to say "not run".)
>
>> + *   Furthermore, it will prevent the compiler from
>> + * inlining the function because inlining currently breaks the blacklisting
>> + * mechanism of AddressSanitizer.
>
> Ow...  Could uninlining something in some rare cases not break
> the function of that something?

We shall see? I don't have anything better to offer as a fix to a concern.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

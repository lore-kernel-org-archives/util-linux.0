Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33530 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752141AbaK3QmN (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 30 Nov 2014 11:42:13 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id BFAE32063B
	for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 11:42:12 -0500 (EST)
Message-Id: <1417365732.1298240.196969401.607516E2@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 08/10] include/c: define UL_ASAN_BLACKLIST address_sanitizer
 function attribute
Date: Sun, 30 Nov 2014 17:42:12 +0100
In-Reply-To: <1417355862-16935-9-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
 <1417355862-16935-9-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Nov 30, 2014, at 14:57, Sami Kerola wrote:
> The UL_ASAN_BLACKLIST allows AddressSanitizer to be set off for functions
> that cannot be checked.

s/set/switched/

(Because "set off" means "triggered", which means "run" -- but
the intention is to say "not run".)

> + *   Furthermore, it will prevent the compiler from
> + * inlining the function because inlining currently breaks the blacklisting
> + * mechanism of AddressSanitizer.

Ow...  Could uninlining something in some rare cases not break
the function of that something?

Benno

-- 
http://www.fastmail.com - The way an email service should be


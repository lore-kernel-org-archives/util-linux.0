Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54635 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbaECNCT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 09:02:19 -0400
Message-Id: <1399122138.2035.113244085.6EF15439@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1399084359-28425-5-git-send-email-bjarniig@rhi.hi.is>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
 <1399084359-28425-5-git-send-email-bjarniig@rhi.hi.is>
Subject: Re: [PATCH 21/21] login-utils/login.1: Improve the typesetting of the
 manual
Date: Sat, 03 May 2014 15:02:18 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, May 3, 2014, at 4:32, Bjarni Ingi Gislason wrote:
>   Use a real apostrophe \(aq instead of ' (prints as a single right
> quote) or \' (prints as an acute accent)

Indeed, \' prints as an acute accent, which is not right, but for
me, on a terminal, ' is shown as ', as a plain apostrophe, 0x27
-- there is no need for \(aq there.  And for people who actually
want to print a man page, I would have thought they would prefer
to see the curly U+2019 ("this is the preferred character to use
for apostrophe") instead of the straight U+0027.

https://en.wikipedia.org/wiki/Apostrophe#Typographic_form

What makes you prefer the straight form in typeset documents?

Benno

-- 
http://www.fastmail.fm - mmm... Fastmail...


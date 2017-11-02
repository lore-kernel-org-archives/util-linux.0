Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755698AbdKBNpo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Nov 2017 09:45:44 -0400
Date: Thu, 2 Nov 2017 14:45:40 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/timeutils: add common ISO timestamp masks
Message-ID: <20171102134540.o5dhvgwil2ykevdy@ws.net.home>
References: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
 <661c0a48-59bb-8263-9fd7-c1ef80b160f2@gmx.com>
 <20171023094959.dxlot6uqj5pvymwk@ws.net.home>
 <54ed1151-d782-815c-c986-1ae6ea9d20fe@gmx.com>
 <20171024093728.cwri5elvpqxk6tl7@ws.net.home>
 <8421ce81-278a-65d9-9470-bc86e3103b73@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8421ce81-278a-65d9-9470-bc86e3103b73@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 24, 2017 at 12:19:59PM -0400, J William Piggott wrote:
> Anyway, I'm not clear on what you want me to do. You didn't comment on
> my idea that naming the radix point implies usec.

Yes, it implies usec, the question is if such thing is obvious for a
random reader.

> Why define a radix
> point if there is no fractional part, it makes no sense. If you agree
> with that, then your only remaining change request is moving the _G
> suffix to _GM prefix.  Is that the only change you want? If yes, then
> I'll make it so. IMO, it degrades readability, but you have the hammer.

Just brainstorming... the current situation is not so bad from my point 
of view :-)

Anyway I don't see a problem to support complete macros ISO_TIMESTAMP_
as you suggested, but please keep it without magic number with in the
header files. The _G suffix is fine. Send patch.

It would be also nice to use all the complex macros in lib/timeutils.c
test program.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

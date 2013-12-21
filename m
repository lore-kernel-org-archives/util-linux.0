Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33650 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753217Ab3LURDh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 21 Dec 2013 12:03:37 -0500
Message-Id: <1387645415.1452.62357161.76BB1F01@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] docs: cal: mention where Gregorian reformation happen in
 September 1752
Date: Sat, 21 Dec 2013 18:03:35 +0100
In-Reply-To: <1387627066-29740-1-git-send-email-kerolasa@iki.fi>
References: <1387627066-29740-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi Sami,

The change looks okay, but the wording needs some improvement.

On Sat, Dec 21, 2013, at 12:57, Sami Kerola wrote:
> +The
> +.B cal
> +is using for Gregorian reformation the date of 1752 on the 3rd of
> +September when it happen in Great Britain and it's colonies

s/is using for/program uses for the/
s/happen/happened/
s/it's/its/

Or better, written out in full:

  The cal program uses the 3rd of September 1752 as the date of
  the Gregorian calendar reformation -- that is when it happened
  in Great Britain and its colonies...

> +The
> +history when calendar reformation happen in different locales is ignored.

  The historical dates on which the calendar reform actually happened
  in the different countries (locales) are ignored.

Regards,

Benno

-- 
http://www.fastmail.fm - The way an email service should be


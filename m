Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f43.google.com ([209.85.160.43]:65246 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaEZImH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 May 2014 04:42:07 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so7363007pbc.16
        for <util-linux@vger.kernel.org>; Mon, 26 May 2014 01:42:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1401052223.27518.121405397.106D8440@webmail.messagingengine.com>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<1400929696-12548-5-git-send-email-kerolasa@iki.fi>
	<1400935458.18113.121085821.31470970@webmail.messagingengine.com>
	<CAG27Bk2CBYDtF36R-41ZAqQrpzbdqP4=TDQx3m32=hs25GyFZg@mail.gmail.com>
	<1401052223.27518.121405397.106D8440@webmail.messagingengine.com>
Date: Mon, 26 May 2014 09:42:05 +0100
Message-ID: <CAG27Bk2sEtwwNZPb8=ExxwhRVG0WQrd60W=MJuHaJBNXOpptoQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 25 May 2014 22:10, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sun, May 25, 2014, at 12:58, Sami Kerola wrote:
>> That convention should be documented. Meanwhile I hope the following
>> is a bit closer how the manual should be.
>>
>> New version:
>> https://github.com/kerolasa/lelux-utiliteetit/commit/bbc05cc2e30a6d6a3adcc7207d5549b782f03574
>
>> -.B force
>> +.I force
>
> This and poke are literal arguments and should stay bold.

Thank you, I missed them.

https://github.com/kerolasa/lelux-utiliteetit/commit/bbc05cc2e30a6d6a3adcc7207d5549b782f03574

>> -.B \-\-default
>> +\fB\-\-default\fP
>
> Why do you make this kind of changes?  The first is perfectly fine
> and more readable.

I find it more readable when options after .TP are always using
\fB...\fR, what is the only way to make optional option with arguments
and other complex cases to work. Making the simple cases look a like
the other cases feels correct to me.

> I am not going to make any more detailed comments, it's much
> easier to later simply provide a patch.

Would you mind writing the howto update in same go?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

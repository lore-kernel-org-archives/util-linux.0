Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:64926 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK6y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:58:54 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so6221736pab.20
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:58:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1400935458.18113.121085821.31470970@webmail.messagingengine.com>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<1400929696-12548-5-git-send-email-kerolasa@iki.fi>
	<1400935458.18113.121085821.31470970@webmail.messagingengine.com>
Date: Sun, 25 May 2014 11:58:53 +0100
Message-ID: <CAG27Bk2CBYDtF36R-41ZAqQrpzbdqP4=TDQx3m32=hs25GyFZg@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 May 2014 13:44, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
>> Underline option arguments, and use bold for options.
>
> Ehm, no, that is not the style.  Italics (underline on a terminal) is
> for things that need to be replaced, need to be filled in; bold is for
> literal arguments, things that have to be typed as is.

That convention should be documented. Meanwhile I hope the following
is a bit closer how the manual should be.

New version:
https://github.com/kerolasa/lelux-utiliteetit/commit/bbc05cc2e30a6d6a3adcc7207d5549b782f03574

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

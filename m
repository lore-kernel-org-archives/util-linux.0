Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35623 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbcL2LBs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 29 Dec 2016 06:01:48 -0500
Received: by mail-qt0-f194.google.com with SMTP id 3so22751693qtr.2
        for <util-linux@vger.kernel.org>; Thu, 29 Dec 2016 03:01:47 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk32Qb0V2g6HFXdPRakrRhjG9fhZbPSFtA8cTjDKpLWu4w@mail.gmail.com>
References: <20161228220211.5634-1-kerolasa@iki.fi> <20161229003327.oeavblvtsem4e6ge@angband.pl>
 <CAG27Bk32Qb0V2g6HFXdPRakrRhjG9fhZbPSFtA8cTjDKpLWu4w@mail.gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 29 Dec 2016 11:01:45 +0000
Message-ID: <CAG27Bk1PbU1T=7cisG7kcO1txOXz9wap9xvZVs=0iEj7thzqNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] setterm: add --resize option
To: Adam Borowski <kilobyte@angband.pl>
Cc: util-linux <util-linux@vger.kernel.org>,
        Andreas Henriksson <andreas@fatal.se>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 December 2016 at 10:58, Sami Kerola <kerolasa@iki.fi> wrote:
> On 29 December 2016 at 00:33, Adam Borowski <kilobyte@angband.pl> wrote:
>> On Wed, Dec 28, 2016 at 10:02:11PM +0000, Sami Kerola wrote:
>>> Reset terminal size by assessing maximum row and column.  This is useful
>>> when actual geometry and kernel terminal driver are not in sync.
>>>
>>> Addresses: http://bugs.debian.org/835636
>>> Based-on-work-by: Adam Borowski <kilobyte@angband.pl>
>>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>>
>> Awesome, thanks for taking a look at it!
>> Alas, at least the delay length makes your version not work for me.
>
> Fair enough, updates are available in the git repository at:
>
>   git://github.com/kerolasa/lelux-utiliteetit.git setterm
>
> https://github.com/kerolasa/lelux-utiliteetit/commit/9e0d5c6b0f8294ceabf38212f6ec14f148e5e642

Correction. The 9e0d5c... got amend. More recent commit is:

https://github.com/kerolasa/lelux-utiliteetit/commit/5d795999511adc455d223be8281948796bd7d087

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

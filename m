Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33001 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbcGUUUD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Jul 2016 16:20:03 -0400
Received: by mail-oi0-f41.google.com with SMTP id j185so134338650oih.0
        for <util-linux@vger.kernel.org>; Thu, 21 Jul 2016 13:20:02 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20160719084836.pgjmo4v45zme4rys@ws.net.home>
References: <20160717130015.31760-1-kerolasa@iki.fi> <20160717130015.31760-4-kerolasa@iki.fi>
 <20160719084836.pgjmo4v45zme4rys@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 21 Jul 2016 21:20:01 +0100
Message-ID: <CAG27Bk2dCmtE0PL52Br=j6YvZO3wpTRU09mQrB7wUc7k-edaOA@mail.gmail.com>
Subject: Re: [PATCH 03/13] libfdisk: collapse indentation [oclint]
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 July 2016 at 09:48, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jul 17, 2016 at 02:00:05PM +0100, Sami Kerola wrote:
>> -             for (j = 0; j < i; j++)
>> -                 if (lens[j]) {
>
>> +             for (j = 0; j < i && lens[j]; j++)
>
>
>  I don't think the result is the same logic.

Oh I see. The patch is dropped from the my oclint branch, that is
rebased on top change 10e8d7a.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

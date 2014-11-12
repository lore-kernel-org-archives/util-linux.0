Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55657 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbaKLPCH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 12 Nov 2014 10:02:07 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so13004223pab.24
        for <util-linux@vger.kernel.org>; Wed, 12 Nov 2014 07:02:06 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20141112142500.GB5530@x2.net.home>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
	<5461B803.4050707@linux.com>
	<CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>
	<alpine.LNX.2.03.1411112236560.23899@iki.fi>
	<20141112142500.GB5530@x2.net.home>
Date: Wed, 12 Nov 2014 15:02:06 +0000
Message-ID: <CAG27Bk2-c4_AsqCsBd+uBkkcvX0CSJPW+Q2+JndyGts=ZE1rmw@mail.gmail.com>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Boris Egorov <egorov@linux.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12 November 2014 14:25, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Nov 11, 2014 at 10:49:02PM +0000, Sami Kerola wrote:
>>       printf(_("Setting up swapspace version %d, size = %s (%ju bytes)\n"),
>>               version, strsz, sz);
>> +     free(strsz);
>
>  free-before-exit, you know what I think about it, right? :)

Normally I would agree, but this case is bizarre. The mkswap will
return 1 when compiled with clang -fsanitize=address without any
message what is wrong. That's probably clang bug, which is a different
topic all together. Adding the free() calls seems to make the
immediate tests failure issue to go away, that is needed to automate
sanitize. In case travis && address sanitation is not needed at all
then these changes does not make sense.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:44496 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094AbaLDUOY convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 4 Dec 2014 15:14:24 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so23820487wgh.20
        for <util-linux@vger.kernel.org>; Thu, 04 Dec 2014 12:14:23 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <547FA265.6040806@draigBrady.com>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
	<1417355862-16935-2-git-send-email-kerolasa@iki.fi>
	<547FA265.6040806@draigBrady.com>
Date: Thu, 4 Dec 2014 20:14:23 +0000
Message-ID: <CAG27Bk0SOOXzB2aJC66AO2pBeicRYHAosmAsd5kdUx8W3meiCg@mail.gmail.com>
Subject: Re: [PATCH 01/10] lib/mbalign: fix unsigned integer overflow [AddressSanitizer]
From: Sami Kerola <kerolasa@iki.fi>
To: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 December 2014 at 23:53, Pádraig Brady <P@draigbrady.com> wrote:
> On 30/11/14 13:57, Sami Kerola wrote:
>> This error was reported 155 times.
>>
>> lib/mbsalign.c:322:18: runtime error: unsigned integer overflow: 0 - 1
>> cannot be represented in type 'size_t' (aka 'unsigned long')
>
> What compiler and version are you using for this?
> I don't get the error with gcc 4.9.2 with -fsanitize=undefined
> Note the error is incorrect I think as the variable is not read
> after the overflow.

Hi Pádraig,

Sorry it took ages to reply to a trivial question.

$ clang --version
clang version 3.5.0 (tags/RELEASE_350/final)
Target: x86_64-unknown-linux-gnu
Thread model: posix

I have not done sanitation runs with gcc.

The system is archlinux with testing repos enabled with daily updates,
that should mean a lot of libraries and such are fairly recent.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

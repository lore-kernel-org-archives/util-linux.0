Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f181.google.com ([209.85.223.181]:34686 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbHZWoR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Aug 2015 18:44:17 -0400
Received: by iodb91 with SMTP id b91so37150461iod.1
        for <util-linux@vger.kernel.org>; Wed, 26 Aug 2015 15:44:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150826223823.GH3116@vapier>
References: <20150826220230.GA8599@www.outflux.net>
	<20150826223823.GH3116@vapier>
Date: Wed, 26 Aug 2015 15:44:16 -0700
Message-ID: <CAGXu5jK1fGRG4rQWBYgfjb9ffPEL1=qTWDzW1gsn6DUBF3d=fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libmount: handle arbitrary line length for mounts
From: Kees Cook <keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 26, 2015 at 3:38 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On 26 Aug 2015 15:02, Kees Cook wrote:
>> + * Read a line with fgets. If it doesn't fit in the existing buffer,
>> + * allocate more heap memory for storage until it does fit.
>
> why not just use getline then ?

It's not often I get to discover new functions in libc. How did I ever
miss this? If it behaves the same as fgets on EOF, it'll be perfect.

>> +             if (fgets (current, remaining, f) == NULL) {
>
> style omits space before the (.  comes up a few times in this patch.

Noted. I saw the use of strchr and didn't look much more. :)

-Kees

-- 
Kees Cook
Chrome OS Security

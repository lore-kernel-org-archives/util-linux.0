Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f44.google.com ([209.85.220.44]:43039 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK6X (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:58:23 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so6202274pab.17
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:58:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1400935096.17218.121085157.1650AD96@webmail.messagingengine.com>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<1400929696-12548-4-git-send-email-kerolasa@iki.fi>
	<1400935096.17218.121085157.1650AD96@webmail.messagingengine.com>
Date: Sun, 25 May 2014 11:58:23 +0100
Message-ID: <CAG27Bk0anxVUCxkVLJw6gQamBVrSGSyVHsPbAiNJnJricGtxOg@mail.gmail.com>
Subject: Re: [PATCH 3/4] docs: setterm.1 add options compatibility note
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 May 2014 13:38, Benno Schulenberg <bensberg@justemail.net> wrote:
> On Sat, May 24, 2014, at 13:08, Sami Kerola wrote:
>> +Since version 2.25 the
>> +.B setterm
>> +has supported long options with two hyphens, for example
>
> s/has supported/has support for/
>
>> +.BR \-\-help ,
>> +aside with single hyphen options, for example
>
> s/aside with single hyphen options/
>   beside the historical long options with a single hyphen/
>
>> +In scripts it is better to use backward compatibile single hyphen rather
>
> s/use backward /use the backward-/
> s/compatibile/compatible/
>
>> +than two hyphens.  Currently there are no plans or good reasons to
>
> s/two hyphens/the double hyphen/

Thank you again.

New version:
https://github.com/kerolasa/lelux-utiliteetit/commit/94740821907e95f65584762bd362d8b1946e1eb8

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33337 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbEXTHh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 May 2015 15:07:37 -0400
Received: by wicmx19 with SMTP id mx19so25980923wic.0
        for <util-linux@vger.kernel.org>; Sun, 24 May 2015 12:07:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20150521111301.GC4730@ws.net.home>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
	<20150521111301.GC4730@ws.net.home>
Date: Sun, 24 May 2015 20:07:35 +0100
Message-ID: <CAG27Bk3OdumQ0rJJUnVSHnks6TwHSokSySYHcqWHmCRTrfRDcw@mail.gmail.com>
Subject: Re: [PATCH 00/12] pull: script(1) changes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 21 May 2015 at 12:13, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Feb 22, 2015 at 02:42:37PM +0000, Sami Kerola wrote:
>> The following changes are clean ups and improvements to script(1)
>> command.  These changes are also available from my github remote
>> repository.
>>
>>  git://github.com/kerolasa/lelux-utiliteetit.git script
>
> I'd like to merge this patch set, any idea how to really test it? ;-)

Hi Karel,

I added some tests to my 'script2' branch.

https://github.com/kerolasa/lelux-utiliteetit/commit/c7adcdde3ada54c1ede04c37ac44173e9b2e7ba4
https://github.com/kerolasa/lelux-utiliteetit/commit/4f692ce1c11a02fb7f636a79dd1758ffc08f0b30

The above tests are based on git log entries about old bugs and
regressions. I am sure tests could have greater coverage, but even
with these few I found a stupid error in earlier pull request -
'Script done on <timestamp>' line was not printed to typescript file.
That is now corrected.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

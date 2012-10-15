Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64956 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab2JOIch (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Oct 2012 04:32:37 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1753045wib.1
        for <util-linux@vger.kernel.org>; Mon, 15 Oct 2012 01:32:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20121014221044.GR533@rampage>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
	<1350246070-10544-8-git-send-email-kerolasa@iki.fi>
	<20121014221044.GR533@rampage>
Date: Mon, 15 Oct 2012 09:32:36 +0100
Message-ID: <CAG27Bk26Yg3GNmX9Qw8pm2YSeyfRfxCsS-RNWKs-BUCzJCSGkA@mail.gmail.com>
Subject: Re: [PATCH 07/19] sd-daemon: fix cppcheck warnings
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 14, 2012 at 11:10 PM, Dave Reisner <d@falconindy.com> wrote:
> On Sun, Oct 14, 2012 at 09:20:58PM +0100, Sami Kerola wrote:
>> [misc-utils/sd-daemon.c:91]: (style) Checking if unsigned variable 'l' is \
>> less than zero.
>> [misc-utils/sd-daemon.c:254]: (warning) Comparison of a boolean \
>> expression with an integer.
>> [misc-utils/sd-daemon.c:363]: (style) Checking if unsigned variable \
>> 'length' is less than zero.
>> [misc-utils/sd-daemon.c:366]: (style) Checking if unsigned variable \
>> 'length' is less than zero.
>>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  misc-utils/sd-daemon.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/misc-utils/sd-daemon.c b/misc-utils/sd-daemon.c
>> index 763e079..21399e2 100644
>> --- a/misc-utils/sd-daemon.c
>> +++ b/misc-utils/sd-daemon.c
>
> This file comes directly from the systemd tree. I think it'd be better
> to submit the fix there first.
>
> Either way, there's whitespace errors in this patch (tabs rather than
> spaces).

Hi Dave,

OK, I will send the patch there and remove it from my branch. Thank
you for review.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/

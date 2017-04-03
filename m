Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33687 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdDCIkf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Apr 2017 04:40:35 -0400
Received: by mail-qk0-f194.google.com with SMTP id p22so18331197qka.0
        for <util-linux@vger.kernel.org>; Mon, 03 Apr 2017 01:40:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
References: <20170402081436.861-1-kerolasa@iki.fi> <20170402081436.861-3-kerolasa@iki.fi>
 <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 3 Apr 2017 09:40:34 +0100
Message-ID: <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 April 2017 at 02:13, J William Piggott <elseifthen@gmx.com> wrote:
> On 04/02/2017 04:14 AM, Sami Kerola wrote:
>> Without this change an attempt to remove hostname printing required following
>> rather clumsy agetty invocation.
>>
>>   /sbin/agetty --nohostname --login-options '/bin/login -H -- \u'
>>
>> After the change --nohostname behaves similar way with --host option, that
>> is when combined with --remote the effect is passed to login(1).
>>
>> In same go improve manual page a little bit.  This includes small mistake in
>> commit 01095ae33c that claimed option -r is added to command line when
>> passing hostname login while it should have been -h.
>>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  term-utils/agetty.8 | 27 +++++++++++++++++----------
>>  term-utils/agetty.c |  9 ++++++---
>>  2 files changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
>> index 40be8b46c..bdb1a7d35 100644
>> --- a/term-utils/agetty.8
>> +++ b/term-utils/agetty.8
>> @@ -90,18 +90,22 @@ Assume that the tty is 8-bit clean, hence disable parity detection.
>>  .TP
>>  \-a, \-\-autologin \fIusername\fP
>>  Log the specified user automatically in without asking for a login name and
>
> Hey Sami, since you're here you might want to fix this too?

Hi JWP,

Let me split the change in two:

1. --nohostname option forward + minimal manual change
2. manual page update

Karel, please hold on with these three changes. I will push changes to
a some branch in my git and tell when the stuff is fast forwardable.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36570 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423082AbdD0VVB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Apr 2017 17:21:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id t52so6134335qtb.3
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 14:21:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170424122435.4engxht6k6r5xo5l@dell5510>
References: <20170423205821.7444-1-kerolasa@iki.fi> <20170423205821.7444-8-kerolasa@iki.fi>
 <20170424122435.4engxht6k6r5xo5l@dell5510>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 27 Apr 2017 22:21:00 +0100
Message-ID: <CAG27Bk0Qv_LNx6ma86Z1dupQwPSNiKM6ZcQLgEGoqgFpqggyQA@mail.gmail.com>
Subject: Re: [PATCH 07/10] sulogin: reduce vulnerability surface
To: Petr Vorel <petr.vorel@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 April 2017 at 13:24, Petr Vorel <petr.vorel@gmail.com> wrote:
>> Hopefully these changes are unreachable code, but better safe than sorry
>> when dealing with setuid root code that is installed everywhere.  Quite
>> obviously the introduced abort() calls protect from impossible inputs.
>
>> Secondly set all possible data to be read-only in attempt to make it more
>> difficult to alter anything at all.
>
>> Reference: https://www.securecoding.cert.org/confluence/display/c/DCL00-C.+Const-qualify+immutable+objects
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  login-utils/su-common.c        | 53 +++++++++++++++++++++++-------------------
>>  login-utils/sulogin-consoles.c | 20 ++++++++--------
>>  login-utils/sulogin.c          | 39 ++++++++++++-------------------
>>  3 files changed, 54 insertions(+), 58 deletions(-)
>
>> diff --git a/login-utils/su-common.c b/login-utils/su-common.c
>> index 41f2b1cea..08f327c50 100644
>> --- a/login-utils/su-common.c
>> +++ b/login-utils/su-common.c
> <snip>
>> -  int retval;
>> +  const int retval = pam_open_session (pamh, 0);;
>                                                   ^
>                                                                                                   double semicolon.

Thank you Petr, fixed and attributed.

https://github.com/kerolasa/lelux-utiliteetit/commit/c12bebe9cfe3396b9af7110e80b07103514dfe91

p.s. Karel the ioctl() &mode is fixed as well.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33828 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbcDTVGf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Apr 2016 17:06:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id b10so7011607oig.1
        for <util-linux@vger.kernel.org>; Wed, 20 Apr 2016 14:06:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <m3ega1jjnt.fsf@gmail.com>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
	<1461098145-2988-5-git-send-email-kerolasa@iki.fi>
	<m3ega1jjnt.fsf@gmail.com>
Date: Wed, 20 Apr 2016 22:06:34 +0100
Message-ID: <CAG27Bk1ak+zD-xEiDhPnozdmy_oaVnA2tmO540VNNMxd1o7RmQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] lib: avoid double free in loopdev.c
From: Sami Kerola <kerolasa@iki.fi>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 April 2016 at 23:52, Yuriy M. Kaminskiy <yumkam@gmail.com> wrote:
> Sami Kerola <kerolasa@iki.fi> writes:
>
>> Found with scan-build.
>>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  lib/loopdev.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/loopdev.c b/lib/loopdev.c
>> index 9ae61da..ca5d2f4 100644
>> --- a/lib/loopdev.c
>> +++ b/lib/loopdev.c
>> @@ -460,6 +460,7 @@ static int loop_scandir(const char *dirname, int **ary, int hasprefix)
>>                       tmp = realloc(*ary, arylen * sizeof(int));
>>                       if (!tmp) {
>>                               free(*ary);
>> +                             ary = NULL;
>
> This cannot have any effect. Probably you wanted
>                                 *ary = NULL;

Thank you for review Yuriy. Fixed in

https://github.com/kerolasa/lelux-utiliteetit/commit/34f6177a24cf602d0720b82f2064e6830ba34ffb

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

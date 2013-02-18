Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f47.google.com ([209.85.214.47]:57672 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab3BRNfs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Feb 2013 08:35:48 -0500
Received: by mail-bk0-f47.google.com with SMTP id jc3so2502090bkc.6
        for <util-linux@vger.kernel.org>; Mon, 18 Feb 2013 05:35:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130218112341.GD11636@x2.net.home>
References: <1361065052-18695-1-git-send-email-zeeshanak@gnome.org>
	<20130218112341.GD11636@x2.net.home>
Date: Mon, 18 Feb 2013 15:35:46 +0200
Message-ID: <CAAa3hFN8BDjqzz3ZN7f06KxROQP15oYZ5Xq2a0OuJj2GVVWnGg@mail.gmail.com>
Subject: Re: [PATCH] libblkid: Make use of isalnum()
From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 18, 2013 at 1:23 PM, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Feb 17, 2013 at 03:37:32AM +0200, Zeeshan Ali (Khattak) wrote:
>> From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
>>
>> ---
>>  libblkid/src/encode.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/libblkid/src/encode.c b/libblkid/src/encode.c
>> index ff57be4..e96e0e2 100644
>> --- a/libblkid/src/encode.c
>> +++ b/libblkid/src/encode.c
>> @@ -181,9 +181,7 @@ static int replace_whitespace(const char *str, char *to, size_t len)
>>
>>  static int is_whitelisted(char c, const char *white)
>>  {
>> -     if ((c >= '0' && c <= '9') ||
>> -         (c >= 'A' && c <= 'Z') ||
>> -         (c >= 'a' && c <= 'z') ||
>> +     if (isalnum (c) ||
>
>  It seems like locale sensitive function ;-)

Ouch, didn't think of locale. :(

-- 
Regards,

Zeeshan Ali (Khattak)
FSF member#5124

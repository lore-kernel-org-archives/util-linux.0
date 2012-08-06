Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56138 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab2HFHaE convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 03:30:04 -0400
Received: by wgbdr13 with SMTP id dr13so2457357wgb.1
        for <util-linux@vger.kernel.org>; Mon, 06 Aug 2012 00:30:03 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1407718255.1271532.1344233652072.JavaMail.open-xchange@email.1und1.de>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
	<1344065620-17480-6-git-send-email-kerolasa@iki.fi>
	<1407718255.1271532.1344233652072.JavaMail.open-xchange@email.1und1.de>
Date: Mon, 6 Aug 2012 09:30:03 +0200
Message-ID: <CAG27Bk157so8J93EfTCQ1YBjXBUtYVVLcgpKg4eJdN6o77cN3A@mail.gmail.com>
Subject: Re: [PATCH 5/5] vipw: make vim writebackup mode work
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 6, 2012 at 8:14 AM, Bernhard Voelker
<mail@bernhard-voelker.de> wrote:
> On August 4, 2012 at 9:33 AM Sami Kerola <kerolasa@iki.fi> wrote:
>
>> Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
>> save" in which the old file is deleted and a new one with the same name
>> created in its place.  The vipw tries to detect if such happen by
>> looking hard temporary file link count, when it is zero reopen
>> temporary file by using it's path.
>>
>> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
>> References: http://www.spinics.net/lists/util-linux-ng/msg06666.html
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  login-utils/vipw.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/login-utils/vipw.c b/login-utils/vipw.c
>> index ed3f43b..1eeeb0d 100644
>> --- a/login-utils/vipw.c
>> +++ b/login-utils/vipw.c
>> @@ -275,6 +275,18 @@ static void edit_file(int is_shadow)
>>
>>          if (fstat(fileno(tmp_fd), &end))
>>                  pw_error(tmp_file, 1, 1);
>> +        /* Some editors, such as Vim with 'writebackup' mode enabled,
>> +         * use "atomic save" in which the old file is deleted and a new
>> +         * one with the same name created in its place.  */
>> +        if (end.st_nlink == 0) {
>> +                if (close_stream(tmp_fd) != 0)
>> +                        err(EXIT_FAILURE, _("write error"));
>> +                tmp_fd = fopen(tmp_file, "r");
>> +                if (!tmp_file)
>> +                        err(EXIT_FAILURE, _("cannot open %s"), tmp_file);
>> +                if (fstat(fileno(tmp_fd), &end))
>> +                        pw_error(tmp_file, 1, 1);
>> +        }
>>          if (begin.st_mtime == end.st_mtime) {
>>                  warnx(_("no changes made"));
>>                  pw_error((char *)NULL, 0, 0);
>> --
>> 1.7.11.4

Hi Berny,

Yes, I did mention file exchange should probably warn.  When I
added the warning it looked like noise, and I could not get
message right.

> We're talking about the intermediate file (in /tmp), but as it's
> name is visible e.g. in ps listings, I'd recommend to be cautious
> about it.

The temporary file in vipw case is created to /etc/ and moved in
place within directory.  Earlier /tmp/ was used, but it resulted
to non-atomic move and rename(2) complaining about device
boundary.  See following commit for details.

commit 3c4fed097ddb65dbe3d88f60caee78fb60756f3e

I am assuming /etc/ is not normally writable for users, so the
security problem should be mostly theoretical.  That said perhaps
a message such as

vipw: intermediate /etc/vipw.XXXXX file change

might be appropriate, if it is explained in vipw(8).  Or is it
simply noise no-one cares?

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/

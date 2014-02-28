Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f49.google.com ([209.85.215.49]:33271 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaB1LAf convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Feb 2014 06:00:35 -0500
Received: by mail-la0-f49.google.com with SMTP id mc6so2529525lab.8
        for <util-linux@vger.kernel.org>; Fri, 28 Feb 2014 03:00:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
	<1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>
Date: Fri, 28 Feb 2014 12:00:34 +0100
Message-ID: <CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
From: =?ISO-8859-2?Q?Maciej_Ma=B3ecki?= <me@mmalecki.com>
To: Davidlohr Bueso <davidlohr@hp.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Davidlohr,

Thanks for the review.

I'm not sure why this is not a place for such message, as a user I
mostly open a device to write something to it. I want to know that
whatever I do, my writes will fail, otherwise I'm just wasting time
putting together my disk layout.
The reason for this patch was trying to open a write-blocked SD card.

Anyway, if that's still a NAK, should I only make this patch so that
`fdisk_context_assign_device` sets `dev->readonly = 1`, without any
error message?

On Fri, Feb 28, 2014 at 3:32 AM, Davidlohr Bueso <davidlohr@hp.com> wrote:
> On Thu, 2014-02-27 at 04:26 +0100, Maciej Małecki wrote:
>> Otherwise, `fdisk` fails silently with "Bad file descriptor" when
>> writing the partition table.
>>
>> Signed-off-by: Maciej Małecki <me@mmalecki.com>
>> ---
>>  libfdisk/src/context.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
>> index c405403..40f9080 100644
>> --- a/libfdisk/src/context.c
>> +++ b/libfdisk/src/context.c
>> @@ -248,17 +248,26 @@ static int warn_wipe(struct fdisk_context *cxt)
>>  int fdisk_context_assign_device(struct fdisk_context *cxt,
>>                               const char *fname, int readonly)
>>  {
>> -     int fd;
>> +     int fd, mode;
>>
>>       DBG(CONTEXT, dbgprint("assigning device %s", fname));
>>       assert(cxt);
>>
>>       reset_context(cxt);
>>
>> -     if (readonly == 1 || (fd = open(fname, O_RDWR|O_CLOEXEC)) < 0) {
>> -             if ((fd = open(fname, O_RDONLY|O_CLOEXEC)) < 0)
>> +retry:
>> +     mode = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
>> +     fd = open(fname, mode);
>> +     if (fd < 0) {
>> +             if (readonly)
>>                       return -errno;
>> -             readonly = 1;
>> +             else {
>> +                     fdisk_warn(cxt,
>> +                         _("%s: opening device in read write mode failed"),
>> +                         fname);
>> +                     readonly = 1;
>> +                     goto retry;
>> +             }
>>       }
>
> This is 1) obscenely ugly and 2) not the place for such message. There's
> no reason to pollute output like this. Why do I care how the device is
> opened when I'm not going to write anything to it?
>
> The correct way is to do what you do in patch 2, inform the user that
> the device is only for opened for reading and just skip the write
> operation.
>
> So, NAK for this patch.
>
> Thanks,
> Davidlohr
>
>

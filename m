Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f41.google.com ([209.85.214.41]:37282 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757635Ab3BNOEG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Feb 2013 09:04:06 -0500
Received: by mail-bk0-f41.google.com with SMTP id q16so1100912bkw.0
        for <util-linux@vger.kernel.org>; Thu, 14 Feb 2013 06:04:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130214132415.GB19379@x2.net.home>
References: <1360617732-4770-1-git-send-email-zeeshanak@gnome.org>
	<1360617732-4770-2-git-send-email-zeeshanak@gnome.org>
	<20130214132415.GB19379@x2.net.home>
Date: Thu, 14 Feb 2013 16:04:04 +0200
Message-ID: <CAAa3hFOOhm_e8Q+iTVCupDk0dtge22JhUT9K0G=zOfBh96P48g@mail.gmail.com>
Subject: Re: [PATCH 2/2] libblkid: Expose more ISO9660 headers
From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 14, 2013 at 3:24 PM, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Feb 11, 2013 at 11:22:12PM +0200, Zeeshan Ali (Khattak) wrote:
>>  libblkid/src/superblocks/iso9660.c     | 112 +++++++++++++++++++++++++++++++--
>>  libblkid/src/superblocks/superblocks.c |  40 ++++++++++++
>>  libblkid/src/superblocks/superblocks.h |   5 +-
>>  3 files changed, 151 insertions(+), 6 deletions(-)
>
>  Applied.
>
>> +#define strstrip(string, len) strchomp(strchug(string, len), len)
>
>  I have removed this code, we already have blkid_rtrim_whitespace() so
>  it seems better to add blkid_ltrim_whitespace() and use it together.

Ah ok, one is bound to make such mistakes if not familiar with code base. :)

>> +static char *
>> +strchug (char *string, size_t len)
>> +{
>> +     size_t i;
>> +
>> +     for (i = 0;  i < len && isspace(string[i]); i++);
>> +
>> +     memmove (string, string + i, len - i);
>> +
>> +     return string;
>> +}
>> +
>> +static char *
>> +strchomp (char *string, size_t len)
>> +{
>> +     size_t i = len;
>> +     while (i--) {
>> +             if (isspace((unsigned char) string[i]))
>> +                     string[i] = '\0';
>> +             else
>> +                     break;
>> +}
>
>  BTW, I didn't test it, but it seems that strstrip code will not work as expected
>  for input like
>
>     "    ABC "
>
>  the result will be very probably
>
>     "ABC ABC\0"

We'll just have a redundant NULL, yes but I don't find that anything
to worry about. Besides its a very simple function in the core of
gnome that has existed for many many years (and afaik widely used) so
hard to imagine it having any issues worth worrying about.

>> +   if (! is_str_empty(iso->system_id, sizeof(iso->system_id))) {
>> +             unsigned char system_id[32];
>> +
>> +             memcpy(system_id, iso->system_id, sizeof(system_id));
>> +             strstrip(system_id, sizeof(system_id));
>> +             blkid_probe_set_system_id(pr, system_id, sizeof(system_id));
>> +     }
>
>  the another change to the patch -- it seems better to add
>  blkid_probe_set_id_label() and use for all the _IDs. Note that we
>  have to terminate the labels by \0.

Thanks, makes sense.

>> +     /* Joliet Extension and Boot Record */
>>       off = ISO_VD_OFFSET;
>>       for (i = 0; i < ISO_VD_MAX; i++) {
>> -             iso = (struct iso_volume_descriptor *)
>> +             struct boot_record *boot= (struct boot_record *)
>>                       blkid_probe_get_buffer(pr,
>>                                       off,
>> -                                     sizeof(struct iso_volume_descriptor));
>> +                                     sizeof(struct boot_record));
>
>  This is bug, size of struct boot_record is smaller than the size of
>  iso_volume_descriptor, so then you can not cast:
>
>> +             /* Not a Boot record, lets see if its supplemntary volume descriptor */
>> +             iso = (struct iso_volume_descriptor *) boot;
>
>  ;-)

Yikes. Since you didn't fix it before merging, now everyone will know
I made this stupid mistake. :)

>  Note that "blkid <image>" without -p uses high-level libblkid cache.
>  For udev we always bypass the cache and the _ID stuff should not be
>  stored in the cache. I have fixed this issue, you have to use -p to
>  see your new IDs.

Ah, didn't know anything about the cache.

>  Thanks, it's definitely good step to use libblkid and udev for the
>  ISO stuff.

Great! Thats what I was hoping to hear. Now Kay will not kill me for
slowing down boot. :)

-- 
Regards,

Zeeshan Ali (Khattak)
FSF member#5124

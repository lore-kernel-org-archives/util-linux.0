Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33548 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbcEKUMW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 May 2016 16:12:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id t140so5842847oie.0
        for <util-linux@vger.kernel.org>; Wed, 11 May 2016 13:12:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160511163956.GO26300@vapier.lan>
References: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
	<20160511163956.GO26300@vapier.lan>
Date: Wed, 11 May 2016 21:12:20 +0100
Message-ID: <CAAz8cFgd9UO58aFAiV8EJ4qpSw+bbN2ynGd8JBBSwt76wLaVBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libfdisk: Add support for altering GPT size
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org, Mike Frysinger <vapier@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks Mike. I'll attend to those issues in the morning and resubmit.

On 11 May 2016 at 17:39, Mike Frysinger <vapier@gentoo.org> wrote:
> On 11 May 2016 15:54, Sassan Panahinejad wrote:
>> This is useful in two situations:
>>
>> 1. More than 128 partitions are required. Or
>>
>> 2. The partition table must be restricted in size, such as when a system
>> expects to find a bootloader at a location that would otherwise overlap the
>> partition table.
>>
>> The gdisk partitioner supports this feature.
>>
>> libfdisk is already capable of reading and writing partition tables of any
>> size, but previously could only create ones of 128 entries and could not
>> resize.
>>
>> This change should be fairly safe, as it has no effect unless explicitly
>> activated.
>
> i'm not super familiar with the codebase, but these look pretty nice.  thanks!
>
>> +     fdisk_info(cxt, _("Partition table length changed from %u to %u."), old, new);
>
> old & new are unsigned long, so you'll want %lu
>
>> +int fdisk_set_disklabel_length(struct fdisk_context *cxt, unsigned long entries)
>> +{
>> +     if (!cxt || !cxt->label)
>> +             return -EINVAL;
>> +     if (!cxt->label->op->set_length)
>> +             return -ENOSYS;
>> +
>> +     DBG(CXT, ul_debugobj(cxt, "setting %s label length", cxt->label->name));
>
> want to include |entries| in the debug output too ?
> -mike

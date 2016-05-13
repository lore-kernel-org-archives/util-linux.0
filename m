Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33670 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbcEMNyl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 May 2016 09:54:41 -0400
Received: by mail-oi0-f41.google.com with SMTP id v145so171083056oie.0
        for <util-linux@vger.kernel.org>; Fri, 13 May 2016 06:54:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160513135201.GT26300@vapier.lan>
References: <1463054083-2485-1-git-send-email-sassan@sassan.me.uk>
	<1463054083-2485-2-git-send-email-sassan@sassan.me.uk>
	<20160513135201.GT26300@vapier.lan>
Date: Fri, 13 May 2016 14:54:40 +0100
Message-ID: <CAAz8cFi_nz4BEwEGQpWPUtQoY0EMEq7cnEyr6jotjfKd1TB-Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libfdisk: Add support for altering GPT size
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: Sassan Panahinejad <sassan@sassan.me.uk>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks, I'll fix that and resubmit.

On 13 May 2016 at 14:52, Mike Frysinger <vapier@gentoo.org> wrote:
> On 12 May 2016 12:54, Sassan Panahinejad wrote:
>> +static int gpt_check_table_overlap(struct fdisk_context *cxt,
>> +                                uint64_t first_usable,
>> +                                uint64_t last_usable)
>> +{
>> ...
>> +             if (gpt_partition_start(&gpt->ents[i]) < first_usable) {
>> +                     fdisk_warnx(cxt, _("Partition #%u out of range (minimal start is %ju sectors)"),
>> +                                 i + 1, first_usable);
>
> %j is for uintmax_t but this is uint64_t, so you'll want to use ..." PRIu64 "...
>
>> +             if (gpt_partition_end(&gpt->ents[i]) > last_usable) {
>> +                     fdisk_warnx(cxt, _("Partition #%u out of range (maximal end is %ju sectors)"),
>> +                                 i + 1, last_usable - 1);
>
> same here
> -mike

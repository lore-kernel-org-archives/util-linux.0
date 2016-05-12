Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35143 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcELJyo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 May 2016 05:54:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id w198so11590135oiw.2
        for <util-linux@vger.kernel.org>; Thu, 12 May 2016 02:54:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160512094308.g6phhampwf7rek4n@ws.net.home>
References: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
	<20160512094308.g6phhampwf7rek4n@ws.net.home>
Date: Thu, 12 May 2016 10:54:43 +0100
Message-ID: <CAAz8cFgUJWLqaF2sCe41OtLG4Y28yjZ+QEje3a-AS-vdLWK3YQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libfdisk: Add support for altering GPT size
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Thanks for the feedback.

I think you're right that this is specific to GPT, I don't know of any
others that have variable size.

I'll fix the problems listed for this patch and modify the other
patches to use fdisk_gpt_set_npartitions() and
fdisk_get_npartitions().

On 12 May 2016 at 10:43, Karel Zak <kzak@redhat.com> wrote:
> On Wed, May 11, 2016 at 03:54:16PM +0100, Sassan Panahinejad wrote:
>> +     /* get table length */
>> +     unsigned long (*get_length)(struct fdisk_context *cxt);
>
> This is already available as fdisk_get_npartitions(), for GPT it
> returns header->npartition_entries.
>
> And also
>
>     fdisk_get_disklabel_item(cxt, GPT_LABELITEM_ENTRIESALLOC, item);
>
> returns the information, but public labelitem API is not implemented
> yet (you cannot access 'item' struct members). I'll fix it ASAP.
>
>> +     /* set table length */
>> +     int (*set_length)(struct fdisk_context *cxt, unsigned long length);
>
> Seems like a good idea, but I'm not sure if we really need it as
> generic label operation (basic fdisk API). It seems that reallocate
> number of PT entries is very GPT specific.
>
> I think it would be enough to add GPT function to the library API, we
> already have many functions to set for example SUN partition table
> stuff and I think add
>
>     fdisk_gpt_set_npartitions()
>
> would be good enough.
>
> (It would be also possible to add fdisk_set_disklabel_item(), to make
>  these things more generic, but I think it's still more user friendly
>  to have fdisk_gpt_set_npartitions() shortcut for this type of operations.)
>
>
>> +static int gpt_set_disklabel_length(struct fdisk_context *cxt, unsigned long new)
>> +{
>> +     struct fdisk_gpt_label *gpt;
>> +     ssize_t esz;
>> +     unsigned long old;
>> +
>> +     assert(cxt);
>> +     assert(cxt->label);
>> +     assert(fdisk_is_label(cxt, GPT));
>> +
>> +     gpt = self_label(cxt);
>> +
>> +     old = le32_to_cpu(gpt->pheader->npartition_entries);
>> +
>> +     gpt->pheader->npartition_entries = cpu_to_le32(new);
>> +     gpt->bheader->npartition_entries = cpu_to_le32(new);
>> +
>> +     /* calculate new size of the entries array */
>> +     esz = le32_to_cpu(gpt->pheader->npartition_entries) *
>> +                     le32_to_cpu(gpt->pheader->sizeof_partition_entry);
>> +
>> +     /* if expanding the table, allocate more memory and zero.
>> +      * Warn the user that this can cause data loss! (if table overlaps partition) */
>> +     if (new > old) {
>> +             fdisk_warnx(cxt, _("Expanding GPT may cause data loss!"));
>> +             gpt->ents = realloc(gpt->ents, esz);
>
>  We care about allocation errors.
>
>  tmp = realloc(gpt->ents, esz);
>  if (!tmp)
>      return -ENOMEM;
>  gpt->ents = tmp;
>
> It would be also better to reallocate before you change anything in
> the header to avoid inconsistent header after ENOMEM.
>
>> +             memset(gpt->ents + old, 0, (new - old) * le32_to_cpu(gpt->pheader->sizeof_partition_entry));
>> +     }
>> +     /* usable LBA addresses will have changed */
>> +     cxt->last_lba = cxt->total_sectors - 2 - (esz / cxt->sector_size);
>> +     cxt->first_lba = (esz / cxt->sector_size) + 2;
>
> Please, call fdisk_set_last_lba() and fdisk_set_first_lba()
>
>> +     gpt->pheader->first_usable_lba = cpu_to_le32(cxt->first_lba);
>> +     gpt->bheader->first_usable_lba = cpu_to_le32(cxt->first_lba);
>> +     gpt->pheader->last_usable_lba = cpu_to_le32(cxt->last_lba);
>> +     gpt->bheader->last_usable_lba = cpu_to_le32(cxt->last_lba);
>
>  All GPT LBA are 64-bit.
>
>
>  It seems you don't care if existing partitions are in the new range
>  specified by first_usable_lba and last_usable_lba. It seems very wrong.
>
>  My recommendation is to check the partitions before you change
>  anything and if any partition is out of the range then report it to
>  user as error (and suggest new start offset for the partition).
>
>  wanted_first_lba = (esz / cxt->sector_size) + 2;
>
>  for (i = 0; i < le32_to_cpu(header->npartition_entries); i++) {
>     if (partition_unused(&ents[i]))
>         continue;
>     if (gpt_partition_start(&ents[i]) < wanted_first_lba) {
>         fdisk_warnx(cxt, _("Partition #%d out of range (minimal start is %ju sectors)",
>                 i + 1, wanted_first_lba));
>         rc = -EINVAL;
>     }
>  }
>
>  if (rc)
>      return rc;
>
>
>  IMHO user should be forced to fix the partitions before he modify
>  first_usable_lba. (Yes, we don't want to resize the partitions
>  automatically in this function.)
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933219AbdDEKuT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 5 Apr 2017 06:50:19 -0400
Date: Wed, 5 Apr 2017 12:50:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fix gpt for 32bit systems
Message-ID: <20170405105015.pymuuqicbzxmiucj@ws.net.home>
References: <1491386189-8163-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491386189-8163-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 05, 2017 at 11:56:29AM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> test libfdisk/gpt failed since bb676203 because UINT32_MAX does
> not fit into ssize_t on 32bit systems.
> 
> This patch rewrites parts of commit f71b96bf. Also handling
> multiplication overflow and some typos. Note that it still looks
> questionable that we would try to read() SSIZE_MAX bytes in
> gpt_read_entries().

Maybe it would be better to have

  #define FDISK_GPT_NENTRIES_MAX  (SIZE_MAX/sizeof(struct gpt_entry))

to avoid all the checks. We have to be able to store the entries
array to the memory, so all should be based on this fact. Things like

    uint64_t sz;
    ...
    ret = calloc(1, sz);

are just crazy fun...

It also seems that the code does not care if header->sizeof_partition_entry
is the same as sizeof(struct gpt_entry), but we use the array as "struct gpt_entry".

The really correct way is to use

    (char *)buf + i * header->sizeof_partition_entry

to get the entry.

I'll play with it and send a patch for review.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

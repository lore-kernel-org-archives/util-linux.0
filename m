Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38348 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbHZXoG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Aug 2015 19:44:06 -0400
Received: by igfj19 with SMTP id j19so24559579igf.1
        for <util-linux@vger.kernel.org>; Wed, 26 Aug 2015 16:44:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150826233439.GC2410@ws.net.home>
References: <20150826224923.GA11884@www.outflux.net>
	<20150826233439.GC2410@ws.net.home>
Date: Wed, 26 Aug 2015 16:44:04 -0700
Message-ID: <CAGXu5jK3zxjp3rSoGxCUGC0KhOQOLFrMyhX6fvOiUMAf+5wdeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
From: Kees Cook <keescook@chromium.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 26, 2015 at 4:34 PM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Aug 26, 2015 at 03:49:23PM -0700, Kees Cook wrote:
>> @@ -212,6 +212,8 @@ struct libmnt_table {
>>       int             comms;          /* enable/disable comment parsing */
>>       char            *comm_intro;    /* First comment in file */
>>       char            *comm_tail;     /* Last comment in file */
>> +     char            *buf;           /* Memory for reading lines */
>> +     size_t          buf_size;       /* Size of line-reading buffer */
>
> It's overkill to add the buffer to the struct, it's necessary
> only in mnt_table_parse_next().

It seemed really inefficient to go from a stack buffer to a
malloc-per-call of mnt_table_parse_next(). I'm fine to write it that
way, though. What do you think is best here?

-Kees

-- 
Kees Cook
Chrome OS Security

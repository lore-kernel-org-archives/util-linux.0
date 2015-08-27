Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f177.google.com ([209.85.223.177]:34760 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbH0ApA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Aug 2015 20:45:00 -0400
Received: by iodb91 with SMTP id b91so39618272iod.1
        for <util-linux@vger.kernel.org>; Wed, 26 Aug 2015 17:44:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150827001634.GJ3116@vapier>
References: <20150826224923.GA11884@www.outflux.net>
	<20150827001634.GJ3116@vapier>
Date: Wed, 26 Aug 2015 17:44:59 -0700
Message-ID: <CAGXu5jLL6zSbPT7cFYkEshvhELb6A+-Z-rYwFdxVq1ZNahs5Xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
From: Kees Cook <keescook@chromium.org>
To: Kees Cook <keescook@chromium.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 26, 2015 at 5:16 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On 26 Aug 2015 15:49, Kees Cook wrote:
>> --- a/libmount/src/mountP.h
>> +++ b/libmount/src/mountP.h
>> @@ -212,6 +212,8 @@ struct libmnt_table {
>>       int             comms;          /* enable/disable comment parsing */
>>       char            *comm_intro;    /* First comment in file */
>>       char            *comm_tail;     /* Last comment in file */
>> +     char            *buf;           /* Memory for reading lines */
>> +     size_t          buf_size;       /* Size of line-reading buffer */
>
> just to be clear, this structure is zero-allocated right ?  getline
> needs the first call to have buf==NULL in order for everything to
> fall into place.

It is, yes. See mnt_new_table()'s calloc usage.

-Kees

-- 
Kees Cook
Chrome OS Security

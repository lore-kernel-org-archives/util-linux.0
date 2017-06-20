Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35676 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdFTTnZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jun 2017 15:43:25 -0400
Received: by mail-qk0-f193.google.com with SMTP id 16so7083933qkg.2
        for <util-linux@vger.kernel.org>; Tue, 20 Jun 2017 12:43:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170619084151.nejowhp7pkeeeifd@ws.net.home>
References: <20170618172536.21544-1-kerolasa@iki.fi> <20170619084151.nejowhp7pkeeeifd@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 20 Jun 2017 20:43:24 +0100
Message-ID: <CAG27Bk2VBnmNJV8DWdoPLrU-4XptohuK-+p-tx4MUiyHnce4Jg@mail.gmail.com>
Subject: Re: [PATCH] uuidparse: add new command
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 June 2017 at 09:41, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jun 18, 2017 at 05:25:36PM +0000, Sami Kerola wrote:
>> +static void uuid_unpack(const uuid_t in, struct uuid *uu)
>> +time_t uuid_time(const uuid_t uu, struct timeval *ret_tv)
>> +int uuid_type(const uuid_t uu)
>> +int uuid_variant(const uuid_t uu)
>
> Why? The functions are exported by library API.
>
> The rest seems good.

I followed a little bit too closely an example in libuuid/src/uuid_time.c
Sorry about that. Updated version is in my git branch uuidparse:

https://github.com/kerolasa/lelux-utiliteetit/commit/8756bd4eacc1986d4e5fb86919f5eac6c6a98ede

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

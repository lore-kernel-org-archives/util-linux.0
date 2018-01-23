Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f175.google.com ([209.85.223.175]:41968 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeAWIJO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Jan 2018 03:09:14 -0500
Received: by mail-io0-f175.google.com with SMTP id f4so10619534ioh.8
        for <util-linux@vger.kernel.org>; Tue, 23 Jan 2018 00:09:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
References: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
From: Timofey Titovets <nefelim4ag@gmail.com>
Date: Tue, 23 Jan 2018 11:08:32 +0300
Message-ID: <CAGqmi75B7yzQp-EWBnbjXgSpbNZAsXah1WtQqPUOE6_NjZRwhA@mail.gmail.com>
Subject: Re: Patch to add support for lz4hc and deflate optimization
 algorithms in zramctl.
To: Libor Bukata <lbukata@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

https://patchwork.kernel.org/patch/9144717/

I think your patch miss support of 842 algo

2018-01-22 23:45 GMT+03:00 Libor Bukata <lbukata@gmail.com>:
> Dear developers of Linux utils,
>
> I extended the zramctl utility to handle also lz4hc and deflate formats.
> The patch is included in the attachment. Thank you in advance for your
> comments.
>
> Kind regards,
> Libor Bukata.



-- 
Have a nice day,
Timofey.

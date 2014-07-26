Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62917 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaGZOsF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 10:48:05 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so7335846pde.9
        for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 07:48:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1406378420.29449.145898149.3B1EDA38@webmail.messagingengine.com>
References: <1406378420.29449.145898149.3B1EDA38@webmail.messagingengine.com>
Date: Sat, 26 Jul 2014 15:48:04 +0100
Message-ID: <CAG27Bk2SkstBkDGR9EiP0UENK1qag0VZ31tLZsjvgCxRss2bpw@mail.gmail.com>
Subject: Re: hwclock --compare segfaults when run as normal user
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>,
        Ondrej Oprala <ooprala@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 26 July 2014 13:40, Benno Schulenberg <bensberg@justemail.net> wrote:
> On my system there is no /etc/adjtime file, and then:
>
> $ ./hwclock --compare
> Segmentation fault
>
> When run as root, it runs fine.
>
>
> $ ./hwclock --version
> hwclock from util-linux 2.25

Hi Benno,

I tried to reproduce the issue without success. If you have core file
could you try to gdb backtrace it?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

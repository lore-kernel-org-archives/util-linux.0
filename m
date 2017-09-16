Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f65.google.com ([209.85.214.65]:34758 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdIPHb3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 16 Sep 2017 03:31:29 -0400
Received: by mail-it0-f65.google.com with SMTP id o200so2669676itg.1
        for <util-linux@vger.kernel.org>; Sat, 16 Sep 2017 00:31:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <c51ca22c-801a-1711-144a-aba8d008bb18@gmx.com>
References: <20170911195717.817-1-kerolasa@iki.fi> <20170911195717.817-3-kerolasa@iki.fi>
 <20170915110547.7znrzkpd7wf3mmdq@ws.net.home> <c51ca22c-801a-1711-144a-aba8d008bb18@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 16 Sep 2017 08:31:27 +0100
Message-ID: <CAG27Bk3e3na7G_VTEC1vqOP5=pJrKePo-2y9=_qf28o92W7BjA@mail.gmail.com>
Subject: Re: [PATCH 3/4] logger: fix memory leaks [asan]
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 16 September 2017 at 01:54, J William Piggott <elseifthen@gmx.com> wrote:
> On 09/15/2017 07:05 AM, Karel Zak wrote:
>> On Mon, Sep 11, 2017 at 08:57:16PM +0100, Sami Kerola wrote:
>>  The mem-leaks are bad thing in daemons, libs, libs tests, and
>>  allocation in loop is dangerous, otherwise for command line utils you
>>  waste time with this kind of free() calls, because kernel on exit()
>>  will be faster to remove all the program from memory.
>
> Does this rule apply to the free() calls in hwclock.c?

What I was trying to to achieve was as few ASAN failures as possible.
That makes seeing memory corruptions, buffer overflows and other
things that do matter easier. Maybe adding supressions is good
enough way to deal the rest.

https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer

Thank you Karel making my patches better. Here's what I can still
see:

https://pastebin.com/raw/U4CSUrxS

Compiled with these:

export CC=clang
export CFLAGS='-fsanitize=address -ggdb'
export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer

And disk-utils/partx.c needs atexit(close_stdout); commented out
to display errors.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

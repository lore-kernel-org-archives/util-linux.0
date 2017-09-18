Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbdIRIzl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Sep 2017 04:55:41 -0400
Date: Mon, 18 Sep 2017 10:55:36 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] logger: fix memory leaks [asan]
Message-ID: <20170918085536.6y6kp5jaxaatqrvj@ws.net.home>
References: <20170911195717.817-1-kerolasa@iki.fi>
 <20170911195717.817-3-kerolasa@iki.fi>
 <20170915110547.7znrzkpd7wf3mmdq@ws.net.home>
 <c51ca22c-801a-1711-144a-aba8d008bb18@gmx.com>
 <CAG27Bk3e3na7G_VTEC1vqOP5=pJrKePo-2y9=_qf28o92W7BjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3e3na7G_VTEC1vqOP5=pJrKePo-2y9=_qf28o92W7BjA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 16, 2017 at 08:31:27AM +0100, Sami Kerola wrote:
> On 16 September 2017 at 01:54, J William Piggott <elseifthen@gmx.com> wrote:
> > On 09/15/2017 07:05 AM, Karel Zak wrote:
> >> On Mon, Sep 11, 2017 at 08:57:16PM +0100, Sami Kerola wrote:
> >>  The mem-leaks are bad thing in daemons, libs, libs tests, and
> >>  allocation in loop is dangerous, otherwise for command line utils you
> >>  waste time with this kind of free() calls, because kernel on exit()
> >>  will be faster to remove all the program from memory.
> >
> > Does this rule apply to the free() calls in hwclock.c?
> 
> What I was trying to to achieve was as few ASAN failures as possible.
> That makes seeing memory corruptions, buffer overflows and other
> things that do matter easier. Maybe adding supressions is good
> enough way to deal the rest.
> 
> https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
> 
> Thank you Karel making my patches better. Here's what I can still
> see:
> 
> https://pastebin.com/raw/U4CSUrxS

Fixed. Thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

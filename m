Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36704 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755289AbdD0VI4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Apr 2017 17:08:56 -0400
Received: by mail-qk0-f196.google.com with SMTP id y63so6510030qkd.3
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 14:08:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170424100021.kkxu56sqbhaqeiu4@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi> <20170423205821.7444-5-kerolasa@iki.fi>
 <20170424100021.kkxu56sqbhaqeiu4@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 27 Apr 2017 22:08:54 +0100
Message-ID: <CAG27Bk28-FQf14BEC_PjJ4nbrS2p4kMQ3N6M9As_7oTd6boRwg@mail.gmail.com>
Subject: Re: [PATCH 04/10] libblkid: add blkid_return_known_pttypes()
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 April 2017 at 11:00, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 23, 2017 at 09:58:15PM +0100, Sami Kerola wrote:
>> This new function will return list partition types names libblkid is aware
>> of.  First use of this information will be in partx(8) to make bash
>> completion to work without a magic list.
>
>  See blkid_superblocks_get_name(), I think we can add the same
>  function for partitions, blkid_partitions_get_name().

Yep, that makes code nicer. Done in commits below.

https://github.com/kerolasa/lelux-utiliteetit/commit/6baae2371c1fd0edb50375a782bd866b7ef2105a
https://github.com/kerolasa/lelux-utiliteetit/commit/7c2294a8357d53fc09309447de3a34b12107947f

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

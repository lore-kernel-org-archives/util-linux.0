Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36794 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbdGPPZ7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 16 Jul 2017 11:25:59 -0400
Received: by mail-oi0-f65.google.com with SMTP id n2so15420138oig.3
        for <util-linux@vger.kernel.org>; Sun, 16 Jul 2017 08:25:59 -0700 (PDT)
Subject: Re: [PATCH 0/5] pull: five mutually unrelated changes
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
References: <20170715212046.1655-1-kerolasa@iki.fi>
 <596A9B0D.6060400@gmail.com>
 <CAG27Bk0TFAUb_cDv9fADiFpVzwP_fboUP6o9ZrZELQiCa=Vq3Q@mail.gmail.com>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <596B8585.2060405@gmail.com>
Date: Sun, 16 Jul 2017 10:25:57 -0500
MIME-Version: 1.0
In-Reply-To: <CAG27Bk0TFAUb_cDv9fADiFpVzwP_fboUP6o9ZrZELQiCa=Vq3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola wrote:
> On 15 July 2017 at 23:45, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>>> The 'big' change in this pull request is to drop reset(1) from util-linux.
>>> I don't think there is any point of keep this script hanging around.
>>
>> Why do you think that.  I find it useful when some application corrupts the
>> screen.  I realize that reset is a symlink to tset, but I find reset easier
>> to remember/use.
>
> The ncurses package contains both binaries tput(1) and reset(1). So this
> script will not work without ncurses, and the very same package has the
> binary that obsoletes the script.

Thanks.  I agree that duplicate functions should be removed.

   -- Bruce


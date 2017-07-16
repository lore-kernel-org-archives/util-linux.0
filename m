Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33658 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbdGPJIJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 16 Jul 2017 05:08:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id j25so1339142qtf.0
        for <util-linux@vger.kernel.org>; Sun, 16 Jul 2017 02:08:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <596A9B0D.6060400@gmail.com>
References: <20170715212046.1655-1-kerolasa@iki.fi> <596A9B0D.6060400@gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 16 Jul 2017 10:08:08 +0100
Message-ID: <CAG27Bk0TFAUb_cDv9fADiFpVzwP_fboUP6o9ZrZELQiCa=Vq3Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] pull: five mutually unrelated changes
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 15 July 2017 at 23:45, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>> The 'big' change in this pull request is to drop reset(1) from util-linux.
>> I don't think there is any point of keep this script hanging around.
>
> Why do you think that.  I find it useful when some application corrupts the
> screen.  I realize that reset is a symlink to tset, but I find reset easier
> to remember/use.

The ncurses package contains both binaries tput(1) and reset(1). So this
script will not work without ncurses, and the very same package has the
binary that obsoletes the script.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

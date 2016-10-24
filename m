Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753620AbcJXSdk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Oct 2016 14:33:40 -0400
Date: Mon, 24 Oct 2016 20:33:37 +0200
From: Karel Zak <kzak@redhat.com>
To: "Ice \"Zack\" Azilov" <icezackazilov@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Out of order disk partitions calling lsblk.
Message-ID: <20161024183337.ko327zeqrqitse3o@ws.net.home>
References: <CAKaFfWvpZf=zqbgb8ELe7VQQ=uOUvkyHUmjDH1ut3n0T-Nnjbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKaFfWvpZf=zqbgb8ELe7VQQ=uOUvkyHUmjDH1ut3n0T-Nnjbg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 24, 2016 at 05:17:10PM +0200, Ice "Zack" Azilov wrote:
> Recently (since 4.8 kernel), I found that lsblk doesn't show output in
> alphabetical order like it was before.

Hmm... probably kernel change, lsblk follows /sys. I'll try to fix it
for v2.29.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbeHCNOF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Aug 2018 09:14:05 -0400
Date: Fri, 3 Aug 2018 13:18:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: kerolasa@gmail.com, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: stop supporting alpha cpu architecture
Message-ID: <20180803111810.4qn4jur2o66d2ttl@ws.net.home>
References: <20180626211343.4675-1-kerolasa@iki.fi>
 <09cf76ad-032f-2e6c-0d67-e4c8ff5bb3f2@bernhard-voelker.de>
 <CAG27Bk3Z7zCQpZv_0Ubd+pfo3f1G6NnKyxr4mRJYT-kyK9+p=A@mail.gmail.com>
 <20180724123052.szmsn3yguneebree@ws.net.home>
 <20180730072905.GA32653@infradead.org>
 <20180803110519.5phtzbuvwfytc3ht@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180803110519.5phtzbuvwfytc3ht@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 03, 2018 at 01:05:19PM +0200, Karel Zak wrote:
>  It would be probably better to remove this #ifdef and call the ioctl
>  everywhere and assume EINVAL from kernel rather than play this ifdef
>  userspace game.

Fixed.
https://github.com/karelzak/util-linux/commit/0dcb713f2e2fe34756bab3c28e4d4ddec47afe1f

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

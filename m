Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbdLKOxu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 11 Dec 2017 09:53:50 -0500
Date: Mon, 11 Dec 2017 15:53:47 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Pull Request
Message-ID: <20171211145347.hitbj7kdpt7xw4kk@ws.net.home>
References: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 10, 2017 at 10:47:04AM -0500, J William Piggott wrote:
> J William Piggott (4):
>       lib/timeutils.c: bug fix Segmentation fault
>       lib/timeutils.c:strxxx_iso: test conversion errors
>       lib/timeutils.c:strxxx_iso: do not wrap tm_year
>       lib/timeutils.c: warn format_iso_time() overflow


Merged, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

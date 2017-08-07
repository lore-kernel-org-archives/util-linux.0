Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752099AbdHGHy4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Aug 2017 03:54:56 -0400
Date: Mon, 7 Aug 2017 09:54:52 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/8] Pull Request
Message-ID: <20170807075452.y73eu7cv6lckrl26@ws.net.home>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 01, 2017 at 09:10:14AM -0400, J William Piggott wrote:
>       hwclock: move systz above init clocks read
>       hwclock: move rtc permissions test
>       hwclock: move drift correction and --predict
>       hwclock: fix RTC read logic
>       hwclock: correlate hclocktime instead of set_time.
>       hwclock: update man page
>       hwclock: restore select() timeout warning
>       hwclock: remove busywait tristate return status

Applied (merged from github), thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

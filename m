Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11187 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754135AbdDDMxj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Apr 2017 08:53:39 -0400
Date: Tue, 4 Apr 2017 14:53:35 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] remove alpha cmos
Message-ID: <20170404125335.zndffzxmkvzbmket@ws.net.home>
References: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 31, 2017 at 10:40:12AM -0400, J William Piggott wrote:
>  sys-utils/hwclock-cmos.c | 417 +++++++++--------------------------------------
>  sys-utils/hwclock-rtc.c  |  20 +--
>  sys-utils/hwclock.8.in   | 110 ++++---------
>  sys-utils/hwclock.c      |  34 +---
>  sys-utils/hwclock.h      |  11 +-
>  5 files changed, 120 insertions(+), 472 deletions(-)

 Merged, let's hope we won't see negative feedback :-)

    Karel
 
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

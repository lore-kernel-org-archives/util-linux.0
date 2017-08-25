Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754059AbdHYGsb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 25 Aug 2017 02:48:31 -0400
Date: Fri, 25 Aug 2017 08:48:27 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/6] hwclock: rename/refactor set_system_clock()
Message-ID: <20170825064827.nlfjf2hm75ccj2sn@ws.net.home>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
 <ab175fb6-72c2-c3a4-5f72-fa0600c2b13d@gmx.com>
 <20170821093158.2kmbowciuklu47yc@ws.net.home>
 <113d8ff2-e593-675b-5ef2-21e15d5cea98@gmx.com>
 <20170822090457.xd65avktdmp6z76e@ws.net.home>
 <be6b5f0b-d3b9-75a5-b5f5-5f6c8ec16e08@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <be6b5f0b-d3b9-75a5-b5f5-5f6c8ec16e08@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 24, 2017 at 07:35:35PM -0400, J William Piggott wrote:
> J William Piggott (6):
>       hwclock: move systz into hctosys
>       hwclock: remove set_system_clock_timezone()
>       hwclock: update set_system_clock debugging
>       hwclock: update set_system_clock comments
>       hwclock: refactor set_system_clock()
>       hwclock: for debugging print startup system time
> 
>  sys-utils/hwclock.c | 182 ++++++++++++++++++----------------------------------
>  1 file changed, 61 insertions(+), 121 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

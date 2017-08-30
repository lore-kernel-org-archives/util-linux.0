Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdH3HkF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Aug 2017 03:40:05 -0400
Date: Wed, 30 Aug 2017 09:40:01 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] hwclock: remove audit from control struct
Message-ID: <20170830074001.brchka4sfp36wukz@ws.net.home>
References: <71b98184-ea32-0e83-013c-2fdb8edc621f@gmx.com>
 <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <484f55d0-ecaf-437c-cb70-e6a871f06878@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 29, 2017 at 12:34:07PM -0400, J William Piggott wrote:
> 
> hwaudit_on is only used in main() and hwclock_exit() and
> that is unlikely to ever change.

 Hmm... the goal is minimize global variables to keep code readable.
 It's strange to have a control struct and use global variable in the
 same time.

> Remove it from the control struct because it:
>  * cleans up an ugly directive in hwclock_exit
>  * removes an argument from usage() and hwclock_exit()
>  * makes usage() comply with util-linux standards

 I think usage() can call exit(EXIT_SUCCESS) and do not need play any
 games with audit at all. 
 
 On another places we have "ctl" so it's fine fine to keep hwaudit_on
 within the control struct.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

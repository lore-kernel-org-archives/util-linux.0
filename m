Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753106AbdBTN0l (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 20 Feb 2017 08:26:41 -0500
Date: Mon, 20 Feb 2017 14:26:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Carlos Santos <casantos@datacom.ind.br>
Cc: util-linux@vger.kernel.org, Aaron Holtzman <aholtzma@gmail.com>
Subject: Re: [PATCH] schedutils: build when configured with
 --disable-all-programs
Message-ID: <20170220132635.qyoyv52zwv44fug3@ws.net.home>
References: <1487447163-12353-1-git-send-email-casantos@datacom.ind.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487447163-12353-1-git-send-email-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 18, 2017 at 05:46:03PM -0200, Carlos Santos wrote:
> Fix AM_CONDITIONAL parameters that conditioned ionice, taskset an chrt
> to the values of build_{ionice,taskset,chrt} respectively, instead of
> build_schedutils.

 Good direction, but not ideal implementation :-) We need to care
 about $build_{taskset,ionice,chrt} because it's modified according to
 the another dependencies (UL_REQUIRES_...() macros).

 I have applied another solution, just ... "git pull".

 Thanks! 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

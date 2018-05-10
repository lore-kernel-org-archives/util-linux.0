Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756665AbeEJJbJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 May 2018 05:31:09 -0400
Date: Thu, 10 May 2018 11:31:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] lib/canonicalize: fix truncation warning
Message-ID: <20180510093105.udubsfp6slioikpf@ws.net.home>
References: <20180503215759.3720-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180503215759.3720-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 03, 2018 at 10:57:57PM +0100, Sami Kerola wrote:
>  lib/canonicalize.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied all 3 patches with small changes, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

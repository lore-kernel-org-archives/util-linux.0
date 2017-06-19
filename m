Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdFSOY0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 10:24:26 -0400
Date: Mon, 19 Jun 2017 16:24:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] flock: cleanup usage issues
Message-ID: <20170619142420.yzmqhilscitwgsmz@ws.net.home>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
 <1497872174-9852-3-git-send-email-sweet_f_a@gmx.de>
 <201706191436.17101.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201706191436.17101.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 19, 2017 at 02:36:17PM +0200, Ruediger Meier wrote:
> Sorry I forgot that the fputs/puts repacement adds another newline.
> 
> I could either
>   1. remove the newlines from the strings (but would this cause extra
>      work for translators?)
>   2. use printf instead of puts
>   3. don't change anything, just use constant FILE argument stdout.

I think fputs(..., stdout) is non-invasive change, better than modify
all strings and probably more effective than printf().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

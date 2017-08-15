Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37060 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdHOSNm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 15 Aug 2017 14:13:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id t138so2256339wmt.4
        for <util-linux@vger.kernel.org>; Tue, 15 Aug 2017 11:13:41 -0700 (PDT)
Date: Tue, 15 Aug 2017 19:13:34 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] look: use WORDLIST environment variable to find word
 list
In-Reply-To: <20170814091257.rq7kqgoi4vsqo2rb@ws.net.home>
Message-ID: <alpine.LNX.2.20.1708151911190.1230@imuri>
References: <20170812083208.1208-1-kerolasa@iki.fi> <20170812083208.1208-2-kerolasa@iki.fi> <20170814091257.rq7kqgoi4vsqo2rb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 14 Aug 2017, Karel Zak wrote:

> Would be better fallback to _PATH_WORDS if WORDLIST= points to
> nowhere?
> 
>     file = _PATH_WORDS; /* default */
>     if ((x = getenv("WORDLIST")) && access(file, R_OK) == 0)
>         file = x;
> 
> seems like more backwardly compatible way.

No problems, change is updated much like proposed above.

https://github.com/kerolasa/lelux-utiliteetit/commit/dd8be07d84988b130286a1194210bdb26b223736

That is in branch: 2017wk32

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

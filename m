Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759645AbdLRStQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Dec 2017 13:49:16 -0500
Date: Mon, 18 Dec 2017 19:49:12 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: Fixes for commit 3c49b23
Message-ID: <20171218184912.rk3t2lr4x3wdlhgl@ws.net.home>
References: <72856395-656c-b67d-1b28-f121e3f05b11@gmx.com>
 <20171218114920.b23vqpbmvqawlv5y@ws.net.home>
 <99c74bd8-e951-bf73-d422-9de2841913a9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <99c74bd8-e951-bf73-d422-9de2841913a9@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 18, 2017 at 01:02:50PM -0500, J William Piggott wrote:
> commit b9e4ee42c285e73b36879a96b9cde43edb0f90c6
> Author: Karel Zak <kzak@redhat.com>
> Date:   Tue Nov 28 10:53:35 2017 +0100
> 
>     nsenter: fix compiler warning [-Wuninitialized]
>     
>     sys-utils/nsenter.c: In function â<80><98>is_same_namespaceâ<80><99>:
>     sys-utils/nsenter.c:170:2: warning: â<80><98>b_inoâ<80><99> may be used uninitialized in this function [-Wuninitialized]
>     sys-utils/nsenter.c:170:2: warning: â<80><98>a_inoâ<80><99> may be used uninitialized in this function [-Wuninitialized]
>     
>     Signed-off-by: Karel Zak <kzak@redhat.com>
> 
>  ---
> 
> Looks like copy/paste from a terminal. Maybe there is no easy way to avoid
> that? Would setting LANG=C when running the command due it? Maybe even that is
> too much hassle.

Yes, it's copy & past from terminal. I'll try to avoid this in future.
Maybe we can use some git commit hook to see a warning, not sure how
difficult is to write such hook.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

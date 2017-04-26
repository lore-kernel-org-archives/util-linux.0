Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2996962AbdDZJYr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Apr 2017 05:24:47 -0400
Date: Wed, 26 Apr 2017 11:24:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] switch_root: unlink files without _DIRENT_HAVE_D_TYPE
Message-ID: <20170426092441.fuhcv3ymzf4gn6sb@ws.net.home>
References: <89de54c7029bebc3cbb9d5eaee67c5d38873985a.1492907475.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <89de54c7029bebc3cbb9d5eaee67c5d38873985a.1492907475.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 23, 2017 at 02:33:04AM +0200, Patrick Steinhardt wrote:
>  sys-utils/switch_root.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Good catch! Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdGaL5j (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jul 2017 07:57:39 -0400
Date: Mon, 31 Jul 2017 13:57:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] whereis: include native multiarch path in lib search
 paths
Message-ID: <20170731115736.e3ahyn53qmdm6wpv@ws.net.home>
References: <1501437137-30759-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501437137-30759-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 30, 2017 at 07:52:17PM +0200, Andreas Henriksson wrote:
>  configure.ac         | 5 +++++
>  misc-utils/whereis.c | 5 +++++
>  2 files changed, 10 insertions(+)

 Good idea. Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

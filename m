Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752877AbdDJNno (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Apr 2017 09:43:44 -0400
Date: Mon, 10 Apr 2017 15:43:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: fix some printf format strings
Message-ID: <20170410134340.jotz4za247el7ytr@ws.net.home>
References: <20170407113559.16107-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170407113559.16107-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 07, 2017 at 01:35:58PM +0200, Ruediger Meier wrote:
>  libblkid/src/partitions/gpt.c | 3 ++-
>  libfdisk/src/alignment.c      | 2 +-
>  sys-utils/blkzone.c           | 8 ++++----
>  3 files changed, 7 insertions(+), 6 deletions(-)

 All applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

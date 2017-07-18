Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdGRMoM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jul 2017 08:44:12 -0400
Date: Tue, 18 Jul 2017 14:44:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: Add dm-integrity superblock signature
Message-ID: <20170718124408.vnbv4rjjogul42w4@ws.net.home>
References: <20170718110823.6716-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170718110823.6716-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 18, 2017 at 01:08:23PM +0200, Milan Broz wrote:
>  libblkid/src/superblocks/lvm.c         | 38 ++++++++++++++++++++++++++++++++++
>  libblkid/src/superblocks/superblocks.c |  1 +
>  libblkid/src/superblocks/superblocks.h |  1 +
>  3 files changed, 40 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732631AbeGKMhq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 11 Jul 2018 08:37:46 -0400
Date: Wed, 11 Jul 2018 14:33:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: Check for a secondary LUKS2 header.
Message-ID: <20180711123335.khwgkbkhyhpgveig@ws.net.home>
References: <20180711103439.10443-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711103439.10443-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 11, 2018 at 12:34:39PM +0200, Milan Broz wrote:
>  libblkid/src/superblocks/luks.c | 60 ++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 13 deletions(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

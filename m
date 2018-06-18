Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966483AbeFRIod (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Jun 2018 04:44:33 -0400
Date: Mon, 18 Jun 2018 10:44:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org, cespedes@debian.org,
        898426@bugs.debian.org
Subject: Re: [PATCH] partx: exit with error code when partition read failed
Message-ID: <20180618084429.uq3q64un2bycw3t5@ws.net.home>
References: <20180617124916.2124-1-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180617124916.2124-1-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 17, 2018 at 02:49:15PM +0200, Andreas Henriksson wrote:
>  disk-utils/partx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

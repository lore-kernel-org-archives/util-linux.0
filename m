Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbdCWOsr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Mar 2017 10:48:47 -0400
Date: Thu, 23 Mar 2017 15:48:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: prevent OOB access while probing HFS+
Message-ID: <20170323144842.zldx3kyl33xjjngp@ws.net.home>
References: <20170315211159.GA29768@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315211159.GA29768@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 15, 2017 at 10:12:00PM +0100, Tobias Stoeckmann wrote:
>  libblkid/src/superblocks/hfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

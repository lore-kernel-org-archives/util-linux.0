Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdCNNDa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Mar 2017 09:03:30 -0400
Date: Tue, 14 Mar 2017 14:03:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk, sfdisk: avoid non-ANSI function declarations
 [smatch scan]
Message-ID: <20170314130323.arrry2qb3qn5cmsu@ws.net.home>
References: <20170220221242.24130-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170220221242.24130-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 20, 2017 at 10:12:42PM +0000, Sami Kerola wrote:
>  disk-utils/fdisk.c  | 1 +
>  disk-utils/sfdisk.c | 1 +
>  2 files changed, 2 insertions(+)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

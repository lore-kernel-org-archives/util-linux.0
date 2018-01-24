Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933613AbeAXNZu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 08:25:50 -0500
Date: Wed, 24 Jan 2018 14:25:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount(8): drop redundant filesystem-specific sections
Message-ID: <20180124132546.ex7ealkh6qnomixm@ws.net.home>
References: <20180119184520.13067-1-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119184520.13067-1-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 19, 2018 at 01:45:20PM -0500, Mike Frysinger wrote:
>  sys-utils/mount.8 | 335 ++----------------------------------------------------
>  1 file changed, 8 insertions(+), 327 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43105 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965007AbcAZKfi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jan 2016 05:35:38 -0500
Date: Tue, 26 Jan 2016 11:35:36 +0100
From: Karel Zak <kzak@redhat.com>
To: "Wayne R. Roth" <wayneroth42@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mkswap: add warnings for insecure device
 permissions/owners Logic modified from sys-utils/swapon.c
Message-ID: <20160126103536.eeug74hblnzin6gf@ws.net.home>
References: <20160120045857.GP14840@vapier.lan>
 <1453270177-19981-1-git-send-email-wayneroth42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453270177-19981-1-git-send-email-wayneroth42@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 19, 2016 at 10:09:37PM -0800, Wayne R. Roth wrote:
>  disk-utils/mkswap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

 Applied, although I don't feel 100% happy with it. At least we will
 educate users about the problem :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

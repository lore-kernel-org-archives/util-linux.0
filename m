Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964858AbcHBOVv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 10:21:51 -0400
Date: Tue, 2 Aug 2016 16:13:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] taskset: clarify that masks are always hex in man page
Message-ID: <20160802141349.2rwa6turcojnpnif@ws.net.home>
References: <1469808380-3120-1-git-send-email-cmetcalf@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469808380-3120-1-git-send-email-cmetcalf@mellanox.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 29, 2016 at 12:06:20PM -0400, Chris Metcalf wrote:
> The man page confusingly says that the mask is "typically"
> hexadecimal, when in fact it is always hexadecimal.  Fix the
> language, and provide an additional example with no leading "0x".

Well, we have --cpu-list, then the mask is a list, for example
0,5,8-11. Maybe we can make a note about it to the paragraph and to
the example (now it's in the OPTIONS only).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

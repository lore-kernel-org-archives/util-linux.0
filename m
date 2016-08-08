Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45492 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbcHHKRF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2016 06:17:05 -0400
Date: Mon, 8 Aug 2016 12:17:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: Add --show-pt-geometry compatibility code
Message-ID: <20160808101703.zcpzegq4juhs4xkq@ws.net.home>
References: <83b22751-8099-958c-d337-bc357b8f9abc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83b22751-8099-958c-d337-bc357b8f9abc@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 04, 2016 at 08:15:57PM +0200, Stanislav Brabec wrote:
> --show-pt-geometry existed since cf3f26bf (2006), and it is used by third party
> tools. To prevent failure of these tools, add a minimal compatibility code.

 Applied, but it would be better to update the tools to stop depend on
 geometry nonsense. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

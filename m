Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbcEMNu2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 May 2016 09:50:28 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA7C5C05B1D2
	for <util-linux@vger.kernel.org>; Fri, 13 May 2016 13:50:27 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4DDoQQ3010453
	for <util-linux@vger.kernel.org>; Fri, 13 May 2016 09:50:27 -0400
Date: Fri, 13 May 2016 15:50:26 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libblkid: make blkid_do_wipe() work with probes with
 offset
Message-ID: <20160513135026.t5sfsdi7r36sktlf@ws.net.home>
References: <1460989325-28748-1-git-send-email-petr.uzel@suse.cz>
 <20160418180018.wgjfgaule76mcfyb@ws.net.home>
 <20160419090502.GA20078@skipper.site>
 <20160419091851.nzetsxvea7klztbm@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160419091851.nzetsxvea7klztbm@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 19, 2016 at 11:18:51AM +0200, Karel Zak wrote:
> Maybe we can improve it and add --wipe-partitions too. IMHO it should
> not be enabled by default, because change disk layout and keep
> filesystems seems like a valid use-case.

Implemented in git tree.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

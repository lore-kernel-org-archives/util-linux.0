Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbcFWJrz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Jun 2016 05:47:55 -0400
Date: Thu, 23 Jun 2016 11:47:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Alexey Obitotskiy <aleksey.obitotskiy@intel.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH][RESEND] Add metadata signature check for IMSM on 4Kn
 drives
Message-ID: <20160623094753.eby4c4vqxkdwvnga@ws.net.home>
References: <1466670736-31676-1-git-send-email-aleksey.obitotskiy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466670736-31676-1-git-send-email-aleksey.obitotskiy@intel.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 23, 2016 at 10:32:16AM +0200, Alexey Obitotskiy wrote:
> Drives with 512 and 4K sectors have different offset for
> metadata signature. Without signature detected on 4Kn drives
> those drives will not be recognized as raid member. This
> patch adds checking for IMSM signature for 4Kn drives.

The patch seems OK, but be patient. I'm currently busy with another
stuff (RHEL). Thanks,

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

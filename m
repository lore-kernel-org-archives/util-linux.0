Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab3JaHzH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Oct 2013 03:55:07 -0400
Date: Thu, 31 Oct 2013 08:55:01 +0100
From: Karel Zak <kzak@redhat.com>
To: andreas.hanke@gmx-topmail.de
Cc: util-linux@vger.kernel.org
Subject: Re: Support the new Linux /home partition GUID
Message-ID: <20131031075501.GD2119@x2.net.home>
References: <trinity-e7dfd7ef-b198-4b29-a28a-a1243935fd6a-1382782598509@3capp-gmx-bs40>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <trinity-e7dfd7ef-b198-4b29-a28a-a1243935fd6a-1382782598509@3capp-gmx-bs40>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 26, 2013 at 12:16:38PM +0200, andreas.hanke@gmx-topmail.de wrote:
> systemd has recently introduced a new GUID that is used to
> auto-mount /home partitions on Linux. [1] This is documented at [2]
> and [3] and already supported in gdisk [4], but not yet in fdisk. I
> think this would be a useful addition.

 Good point. Added.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

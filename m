Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56797 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1LHN3K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Dec 2011 08:29:10 -0500
Date: Thu, 8 Dec 2011 14:29:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] partx: don't treat empty partition table as error
Message-ID: <20111208132904.GA16934@nb.redhat.com>
References: <1323115372-3983-4-git-send-email-psusi@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323115372-3983-4-git-send-email-psusi@cfl.rr.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 05, 2011 at 03:02:52PM -0500, Phillip Susi wrote:
> -	if (!blkid_partlist_numof_partitions(ls)) {
> -		warnx(_("%s: %s partition table does not contains "
> -			"usable partitions"), device,
> -			blkid_parttable_get_type(tab));
> -		return NULL;
> -	}

 I have replaced the warnign and return NULL with message printed in
 verbose mode only.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

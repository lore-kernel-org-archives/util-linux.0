Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbcBLKK7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 05:10:59 -0500
Date: Fri, 12 Feb 2016 11:10:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: add test for loop option in fstab
Message-ID: <20160212101057.kgzns7d5esr74hn2@ws.net.home>
References: <56BCE4F4.6020409@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BCE4F4.6020409@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 11, 2016 at 08:45:56PM +0100, Stanislav Brabec wrote:
>  tests/expected/mount/fstab-loop |  1 +
>  tests/ts/mount/fstab-loop       | 51 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 tests/expected/mount/fstab-loop
>  create mode 100755 tests/ts/mount/fstab-loop

 Applied, thanks. Don't fail now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

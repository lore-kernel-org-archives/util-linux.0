Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22167 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab1KNNvF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 08:51:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAEDp5GW026652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 14 Nov 2011 08:51:05 -0500
Date: Mon, 14 Nov 2011 14:51:03 +0100
From: Karel Zak <kzak@redhat.com>
To: harald@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] switch_root.c: umount mount points we cannot move with
	MNT_DETACH
Message-ID: <20111114135103.GA23020@nb.net.home>
References: <1321276261-9165-1-git-send-email-harald@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321276261-9165-1-git-send-email-harald@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:11:01PM +0100, harald@redhat.com wrote:
>  sys-utils/switch_root.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

 Applied, thanks. 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

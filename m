Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27764 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689Ab3JHN4M (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Oct 2013 09:56:12 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r98DuBcc008908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Oct 2013 09:56:11 -0400
Date: Tue, 8 Oct 2013 15:56:09 +0200
From: Karel Zak <kzak@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blockdev: Remove the --setbsz (set blocksize) option
 which has never worked.
Message-ID: <20131008135609.GF13559@x2.net.home>
References: <1381222450-30380-1-git-send-email-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381222450-30380-1-git-send-email-rjones@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 08, 2013 at 09:54:10AM +0100, Richard W.M. Jones wrote:
>  bash-completion/blockdev | 7 +------
>  disk-utils/blockdev.8    | 2 --
>  disk-utils/blockdev.c    | 7 -------
>  3 files changed, 1 insertion(+), 15 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

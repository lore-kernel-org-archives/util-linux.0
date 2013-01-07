Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34005 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab3AGRMy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Jan 2013 12:12:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r07HCr9B004323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 7 Jan 2013 12:12:53 -0500
Date: Mon, 7 Jan 2013 18:12:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lsblk: Add write-same attribute to topology info
Message-ID: <20130107171251.GB8265@x2.net.home>
References: <1356003743-8013-1-git-send-email-mbroz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356003743-8013-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 20, 2012 at 12:42:23PM +0100, Milan Broz wrote:
>  misc-utils/lsblk.8 |    2 +-
>  misc-utils/lsblk.c |   19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)

 Applied, renamed from WRITE-SAME to to WSAME, thanks. 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

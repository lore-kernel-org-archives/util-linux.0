Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32567 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbaFPMx5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jun 2014 08:53:57 -0400
Date: Mon, 16 Jun 2014 14:53:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Only move shared libraries to /lib if they exists
Message-ID: <20140616125353.GJ30975@x2.net.home>
References: <1402603827-29129-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402603827-29129-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 12, 2014 at 10:10:27PM +0200, Thomas Petazzoni wrote:
>  libblkid/src/Makemodule.am | 2 +-
>  libmount/src/Makemodule.am | 2 +-
>  libuuid/src/Makemodule.am  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

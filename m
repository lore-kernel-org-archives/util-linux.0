Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59966 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab2DJKZt (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 10 Apr 2012 06:25:49 -0400
Date: Tue, 10 Apr 2012 12:25:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: [PATCH 3/3] eject: use CDROM_DRIVE_STATUS if available for tray
 toggling
Message-ID: <20120410102547.GD19784@x2.net.home>
References: <1333641046-13125-1-git-send-email-vapier@gentoo.org>
 <1333641046-13125-3-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333641046-13125-3-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2012 at 11:50:46AM -0400, Mike Frysinger wrote:
>  sys-utils/eject.c |   52 ++++++++++++++++++++++++++++++++--------------------
>  1 files changed, 32 insertions(+), 20 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

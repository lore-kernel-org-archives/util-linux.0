Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756220AbaGWGyh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Jul 2014 02:54:37 -0400
Date: Wed, 23 Jul 2014 08:54:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <davidlohr@hp.com>
Cc: aswin@hp.com, util-linux@vger.kernel.org
Subject: Re: [PATCH 00/13] sfdisk:
Message-ID: <20140723065434.GD26781@x2.net.home>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 04:44:44PM -0700, Davidlohr Bueso wrote:
> The sfdisk(8) program is the only one left to be rewritten to use the new libfdisk library.

Note that I'd like to move all core sfdisk functionality to libfdisk,
to make it possible to save / load partitioning scripts in all fdisk
applications (fdisk and cfdisk).

>  disk-utils/fdisk.c  |    2 -
>  disk-utils/sfdisk.8 |    4 +-
>  disk-utils/sfdisk.c | 4751 ++++++++++++++++++++++++++-------------------------
>  3 files changed, 2417 insertions(+), 2340 deletions(-)

 OK, I'll apply this later this week. Thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

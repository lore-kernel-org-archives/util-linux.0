Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649Ab1I0NAo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Sep 2011 09:00:44 -0400
Date: Tue, 27 Sep 2011 15:00:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] more lscpu and chcpu changes
Message-ID: <20110927130039.GC1982@nb.net.home>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 15, 2011 at 08:52:28AM +0200, Heiko Carstens wrote:
>  include/path.h        |   17 ++++
>  lib/path.c            |  217 ++++++++++++++++++++++++++++++++++++++++++++
>  sys-utils/Makefile.am |    6 +-
>  sys-utils/chcpu.c     |  122 +++++++++++--------------
>  sys-utils/lscpu.1     |    9 ++-
>  sys-utils/lscpu.c     |  237 ++++++++++---------------------------------------
>  6 files changed, 348 insertions(+), 260 deletions(-)
>  create mode 100644 include/path.h
>  create mode 100644 lib/path.c

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

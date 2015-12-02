Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51198 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbLBKlj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Dec 2015 05:41:39 -0500
Date: Wed, 2 Dec 2015 11:41:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: nacc@linux.vnet.ibm.com, util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lscpu: Print physical cpu information
Message-ID: <20151202104137.GI4955@ws.net.home>
References: <1448482240-31011-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448482240-31011-1-git-send-email-sukadev@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 25, 2015 at 12:10:39PM -0800, Sukadev Bhattiprolu wrote:
>  configure.ac            |  6 ++++++
>  sys-utils/Makemodule.am |  2 +-
>  sys-utils/lscpu.1       | 10 ++++++++-
>  sys-utils/lscpu.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+), 2 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

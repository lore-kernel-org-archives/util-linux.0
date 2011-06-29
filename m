Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51711 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037Ab1F2Ku2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Jun 2011 06:50:28 -0400
Date: Wed, 29 Jun 2011 12:50:24 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/6] sfdisk: fix for data type mismatches
Message-ID: <20110629105024.GL6418@nb.net.home>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi> <1307387239-9022-7-git-send-email-kerolasa@iki.fi> <20110614112919.GE14293@nb.net.home> <BANLkTik2HR3BCHFta13hg_QK6nXEZm19Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTik2HR3BCHFta13hg_QK6nXEZm19Pw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 14, 2011 at 10:00:56PM +0200, Sami Kerola wrote:
> Yes are right, that was silly. I reviewed the patch and changed data
> types to size_t. The fix is pushed with force to my git.

 Merged.

> p.s. The style in the file is really horrible. How about doing the
> following, which will unify the style within the file without changing
> everything.
> 
> indent -linux -i4 -psl -brf sfdisk.c

 Hmm.. I don't like such patches, but you're right that the file is
 horrible. Fixed....

    Karel
 
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab2GPQZY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jul 2012 12:25:24 -0400
Date: Mon, 16 Jul 2012 18:25:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>, Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 1/2] fdisk: don't call update_units() in label probes if
 not necessary
Message-ID: <20120716162520.GH9087@x2.net.home>
References: <1342086439-21462-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342086439-21462-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 12, 2012 at 11:47:18AM +0200, Petr Uzel wrote:
>  fdisks/fdiskaixlabel.c |    1 -
>  fdisks/fdiskmaclabel.c |    1 -
>  fdisks/fdisksgilabel.c |    1 -
>  3 files changed, 0 insertions(+), 3 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

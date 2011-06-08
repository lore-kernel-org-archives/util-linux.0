Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab1FHLLc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jun 2011 07:11:32 -0400
Date: Wed, 8 Jun 2011 13:11:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim, setarch: replace error() with err()
Message-ID: <20110608111130.GB11003@nb.net.home>
References: <1307042277-8282-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307042277-8282-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 02, 2011 at 09:17:57PM +0200, Francesco Cosoleto wrote:
>  sys-utils/fstrim.c  |   10 +++-------
>  sys-utils/setarch.c |   17 ++++++++---------
>  2 files changed, 11 insertions(+), 16 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

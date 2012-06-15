Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45926 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901Ab2FOJnh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jun 2012 05:43:37 -0400
Date: Fri, 15 Jun 2012 11:43:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] setsid: fix off-by-one error in execvp call
Message-ID: <20120615094334.GD16531@x2.net.home>
References: <4FCF6AEE.5040004@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FCF6AEE.5040004@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 06, 2012 at 04:36:30PM +0200, Bernhard Voelker wrote:
>  sys-utils/setsid.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

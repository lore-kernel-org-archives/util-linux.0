Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab1FTKwR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 06:52:17 -0400
Date: Mon, 20 Jun 2011 12:52:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH,HURD] Fix Hurd build
Message-ID: <20110620105203.GD17967@nb.net.home>
References: <20110619153435.GA28888@const.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110619153435.GA28888@const.famille.thibault.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 19, 2011 at 05:34:35PM +0200, Samuel Thibault wrote:
> There are a lot of build failures due to BLKALIGNOFF not being available
> on the Hurd, as well as a few other glitches, see log below. I've also
> attached a proposed patch.

 Applied, thanks.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

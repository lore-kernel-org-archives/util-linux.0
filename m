Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13851 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895Ab1F0OVW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jun 2011 10:21:22 -0400
Date: Mon, 27 Jun 2011 16:21:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk
Message-ID: <20110627142119.GB6418@nb.net.home>
References: <4E04D6A3.4060105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E04D6A3.4060105@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 24, 2011 at 01:25:39PM -0500, Bruce Dubbs wrote:
> On my system, a block appears to be 2-512 byte sectors, but is it
> always so?

 Yes. It's stupid legacy (the same thing you can found in
 /proc/partitions).

 I hope that one day we will have better and nicer fdisk with 
 human readable sizes ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

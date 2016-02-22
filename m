Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbcBVI55 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Feb 2016 03:57:57 -0500
Date: Mon, 22 Feb 2016 09:57:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Romain Naour <romain.naour@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] build-sys: fix typo
Message-ID: <20160222085753.vuwrhmmrf3fb4dmo@ws.net.home>
References: <1455918648-11430-1-git-send-email-romain.naour@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455918648-11430-1-git-send-email-romain.naour@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 19, 2016 at 10:50:47PM +0100, Romain Naour wrote:
> When timer_create is available have_timer must be
> set to "yes". But instead have_time is used.

Thanks! both patches applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

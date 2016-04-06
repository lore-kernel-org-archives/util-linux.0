Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37127 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746AbcDFL5P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 07:57:15 -0400
Date: Wed, 6 Apr 2016 13:57:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] build-sys: add --disable-logger and
 --disable-lslogins
Message-ID: <20160406115712.fqmc4eaqsxza2ajr@ws.net.home>
References: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de>
 <1459939867-20719-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459939867-20719-2-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 06, 2016 at 12:51:07PM +0200, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> Now we are able to disable all programs which have systemd/journald
> support. This feature is needed by openSUSE packagers who are building
> util-linux in 2 stages to avoid build cycles.

Well, systemd support is optional, you can build all (including logger
and lslogins) --without-systemd.

But I have nothing against --disable-lslogins and --disable-logger.

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45595 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbcCHNew (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Mar 2016 08:34:52 -0500
Date: Tue, 8 Mar 2016 14:34:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: Re: [PATCH] include sysmacros.h where used
Message-ID: <20160308133449.valpkagmel6jaegy@ws.net.home>
References: <1457389593-15124-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457389593-15124-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 07, 2016 at 05:26:33PM -0500, Mike Frysinger wrote:
> BSD/Linux systems stick major/minor/makedev in sysmacros.h.  Newer Linux
> libraries have been moving away from including sysmacros.h implicitly via
> sys/types.h, so include it directly.

Applied and then reverted ;-) It seems in conflict with Rudi's
changes. We need #ifdef HAVE_SYS_SYSMACROS_H for the file.

I have moved it to c.h, it seems better to keep it on one place. (I
hope it does not have any side effects to have it everywhere.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

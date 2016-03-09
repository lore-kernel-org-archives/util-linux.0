Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46870 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbcCILB5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Mar 2016 06:01:57 -0500
Date: Wed, 9 Mar 2016 12:01:55 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: Re: [PATCH] include sysmacros.h where used
Message-ID: <20160309110155.rlfvh553zaflh6iu@ws.net.home>
References: <1457389593-15124-1-git-send-email-vapier@gentoo.org>
 <20160308133449.valpkagmel6jaegy@ws.net.home>
 <20160308142831.GM6588@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160308142831.GM6588@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 08, 2016 at 09:28:31AM -0500, Mike Frysinger wrote:
> On 08 Mar 2016 14:34, Karel Zak wrote:
> > I have moved it to c.h, it seems better to keep it on one place. (I
> > hope it does not have any side effects to have it everywhere.)
> 
> hopefully not, but i'd watch out for shadowing.  like lib/linux_version.c
> which has variables named "major" and "minor".

Good point. Fixed

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

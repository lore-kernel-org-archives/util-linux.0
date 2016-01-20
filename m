Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933127AbcATKan (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jan 2016 05:30:43 -0500
Date: Wed, 20 Jan 2016 11:30:42 +0100
From: Karel Zak <kzak@redhat.com>
To: "Wayne R. Roth" <wayneroth42@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mkswap: Add warnings for insecure device
 permissions/owners
Message-ID: <20160120103042.clphjleuiesjrl52@ws.net.home>
References: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453228626-18667-1-git-send-email-wayneroth42@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 19, 2016 at 10:37:06AM -0800, Wayne R. Roth wrote:
> Logic copied from sys-utils/swapon.c

Why? I think swapon is the right place for this check.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

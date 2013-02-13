Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3BMOZq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 09:25:46 -0500
Date: Wed, 13 Feb 2013 15:25:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Richard Weinberger <richard@nod.at>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] [RFC] switch_root: Add a sanity check
Message-ID: <20130213142536.GA30987@x2.net.home>
References: <1360434170-27206-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360434170-27206-1-git-send-email-richard@nod.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 09, 2013 at 07:22:50PM +0100, Richard Weinberger wrote:
> As switch_root basically does rm -Rf / we should make sure
> that / is really an initramfs.

Oh, nice (we should not ask for details, right? :-) Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

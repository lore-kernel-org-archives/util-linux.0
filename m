Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965200AbcCNPHN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 11:07:13 -0400
Date: Mon, 14 Mar 2016 16:07:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/12] travis: add OSX build
Message-ID: <20160314150710.7zeoruhhqddhwe7n@ws.net.home>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
 <1457908280-15588-13-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457908280-15588-13-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 13, 2016 at 11:31:20PM +0100, Ruediger Meier wrote:
> BTW to increase travis build speed again we could remove some targets
> from the matrix without losing tested scenarios:
>  - nonroot for Linux seems to be waste of time
>  - clang/Linux could be root check only
> For now we keep it as is.

I agree, non-root tests are subset of all tests executed by root. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab3AJKq0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Jan 2013 05:46:26 -0500
Date: Thu, 10 Jan 2013 11:46:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] build-sys: add files to distribution
Message-ID: <20130110104617.GD593@x2.net.home>
References: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 09, 2013 at 10:44:04PM +0000, Sami Kerola wrote:
>  fdisks/Makemodule.am  | 7 ++++---
>  include/Makemodule.am | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

> +	include/colors.h \

 BTW, any idea where we can use colors?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

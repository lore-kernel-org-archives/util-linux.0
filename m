Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46232 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754735AbcCUUET (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 16:04:19 -0400
Date: Mon, 21 Mar 2016 21:04:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] minor cosmetics and build issues for non-Linux
Message-ID: <20160321200417.cduzdqlpvbtzzs7w@ws.net.home>
References: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 21, 2016 at 02:04:40PM +0100, Ruediger Meier wrote:
>  libmount/python/Makemodule.am |  6 ++++--
>  libmount/python/pylibmount.c  |  2 ++
>  libmount/python/pylibmount.h  |  4 ++++
>  libmount/src/Makemodule.am    |  6 ++++--
>  login-utils/sulogin.c         |  5 +++++
>  sys-utils/ipcs.c              | 16 +++++++++++-----
>  tests/ts/ipcs/functions.sh    |  2 ++
>  7 files changed, 32 insertions(+), 9 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

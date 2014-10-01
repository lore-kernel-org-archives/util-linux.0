Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbaJALOg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 07:14:36 -0400
Date: Wed, 1 Oct 2014 13:14:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/23] pull: mostly textual and compiler warning fix
 changes
Message-ID: <20141001111425.GP26272@x2.net.home>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 28, 2014 at 08:51:33PM +0100, Sami Kerola wrote:
>   libblkid: fix implicit constant conversion warning
>   cfdisk: add missing initializers to struct main_menuitems
>   findmnt: add missing initializers to struct colinfo
>   lsblk: add missing initializers to struct colinfo
>   lscpu: add missing initializers to struct lscpu_coldesc
>   libsmartcols: add explicit column flags default
>   lslogins: add missing initializers to struct lslogins_coldesc
>   lslogins: use more narrow layout when initializing struct members

 Rejected, the rest merged. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

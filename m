Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48060 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929AbaDDNlf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Apr 2014 09:41:35 -0400
Date: Fri, 4 Apr 2014 15:41:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Jonathan Liu <net147@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] umount: fix typo in usage
Message-ID: <20140404134132.GA22126@x2.net.home>
References: <1396617299-32123-1-git-send-email-net147@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396617299-32123-1-git-send-email-net147@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 05, 2014 at 12:14:59AM +1100, Jonathan Liu wrote:
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  po/ca.po           | 2 +-
>  po/cs.po           | 2 +-
>  po/da.po           | 2 +-
>  po/de.po           | 2 +-
>  po/es.po           | 2 +-
>  po/et.po           | 2 +-
>  po/eu.po           | 2 +-
>  po/fi.po           | 2 +-
>  po/fr.po           | 3 +--
>  po/gl.po           | 2 +-
>  po/hr.po           | 2 +-
>  po/hu.po           | 2 +-
>  po/id.po           | 2 +-
>  po/it.po           | 2 +-
>  po/ja.po           | 2 +-
>  po/nl.po           | 2 +-
>  po/pl.po           | 2 +-
>  po/pt_BR.po        | 2 +-
>  po/ru.po           | 2 +-
>  po/sl.po           | 2 +-
>  po/sv.po           | 2 +-
>  po/tr.po           | 2 +-
>  po/uk.po           | 2 +-
>  po/util-linux.pot  | 2 +-
>  po/vi.po           | 2 +-
>  po/zh_CN.po        | 2 +-
>  po/zh_TW.po        | 2 +-
>  sys-utils/umount.c | 2 +-
>  28 files changed, 28 insertions(+), 29 deletions(-)

No, this is bad way. The previous version of the patch was correct. 

The po/ stuff will be updated before release.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

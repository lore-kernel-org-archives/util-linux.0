Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13721 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab2GZOqj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 10:46:39 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q6QEkdQq000755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Jul 2012 10:46:39 -0400
Date: Thu, 26 Jul 2012 16:46:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/5] Add string_add_to_idarray() - parse and add to id
 list.
Message-ID: <20120726144637.GA21901@x2.net.home>
References: <1343304884-14297-1-git-send-email-mbroz@redhat.com>
 <1343310728-16624-1-git-send-email-mbroz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343310728-16624-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 26, 2012 at 03:52:04PM +0200, Milan Broz wrote:
>  include/strutils.h |    4 ++++
>  lib/strutils.c     |   26 ++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

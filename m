Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33673 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622Ab2JWMKR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 23 Oct 2012 08:10:17 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9NCAHM2002373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 23 Oct 2012 08:10:17 -0400
Date: Tue, 23 Oct 2012 14:10:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <mbroz@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] lsblk: add parent kernel name column
Message-ID: <20121023121006.GH21724@x2.net.home>
References: <1350648641-19388-1-git-send-email-mbroz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350648641-19388-1-git-send-email-mbroz@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 19, 2012 at 02:10:39PM +0200, Milan Broz wrote:
> For raw output used in scripts it is sometimes necessary
> to reconstruct tree of devices.

 All three patches applied. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

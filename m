Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934380AbaEFJBz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 05:01:55 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4691tkj010566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 6 May 2014 05:01:55 -0400
Date: Tue, 6 May 2014 11:01:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lsblk: add -O option to show all available columns
Message-ID: <20140506090153.GD29151@x2.net.home>
References: <1398575921-7592-1-git-send-email-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398575921-7592-1-git-send-email-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 27, 2014 at 02:18:41PM +0900, Masatake YAMATO wrote:
> Simple command line for gathering information as many
> as possible is useful when understanding a system,
> especially when trouble shooting.
> 
> This patch introduces -O option which enables all
> available columns.

 Applied with some changes, thanks.

 (I want so huge LCD you have, my 24" is not enough for -O ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

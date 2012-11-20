Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44260 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab2KTNwt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Nov 2012 08:52:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAKDqmmW025383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 20 Nov 2012 08:52:48 -0500
Date: Tue, 20 Nov 2012 14:52:46 +0100
From: Karel Zak <kzak@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] wipefs: Add --force option
Message-ID: <20121120135246.GB2006@x2.net.home>
References: <20121119154116.GA28909@rhmail.home.annexia.org>
 <20121120111634.GH20338@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121120111634.GH20338@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 20, 2012 at 12:16:34PM +0100, Karel Zak wrote:
> On Mon, Nov 19, 2012 at 03:41:16PM +0000, Richard W.M. Jones wrote:
> > This change adds the --force option which, when used, undoes the above
> > flag change.  However you still have to use --force most of the time
> > when erasing something that isn't a plain unmounted filesystem.
> 
>  I'll improve the code. It's stupid disadvantage that --force is
>  necessary for things like partitions tables. We have to use
>  O_EXCL more carefully.

 ... it seems that this is unnecessary. It's possible to delete
 partition table (open with O_EXCL) if any of the partitions is not
 mounted. It seems that only mount(2) has any impact to O_EXCL.

 I guess that --force is enough.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

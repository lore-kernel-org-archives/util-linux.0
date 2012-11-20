Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45805 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab2KTLQg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Nov 2012 06:16:36 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAKBGaVv017359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 20 Nov 2012 06:16:36 -0500
Date: Tue, 20 Nov 2012 12:16:34 +0100
From: Karel Zak <kzak@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] wipefs: Add --force option
Message-ID: <20121120111634.GH20338@x2.net.home>
References: <20121119154116.GA28909@rhmail.home.annexia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121119154116.GA28909@rhmail.home.annexia.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 19, 2012 at 03:41:16PM +0000, Richard W.M. Jones wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=872831
> https://bugzilla.redhat.com/show_bug.cgi?id=865961
> 
> Unfortunately this means you nearly always need to use the --force
> option with wipefs when trying to wipe something which is not an
> unmounted filesystem.
> 
> Tested using a modified version of libguestfs which detects if wipefs
> supports the --force option, and if it does unconditionally adds it.
> I verified that this fixes the virt-format utility on Fedora 18.

 Applied, thanks.

> This change adds the --force option which, when used, undoes the above
> flag change.  However you still have to use --force most of the time
> when erasing something that isn't a plain unmounted filesystem.

 I'll improve the code. It's stupid disadvantage that --force is
 necessary for things like partitions tables. We have to use
 O_EXCL more carefully.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

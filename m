Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53465 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab3KNWYo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Nov 2013 17:24:44 -0500
Date: Thu, 14 Nov 2013 23:24:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: external mount utilities and utab
Message-ID: <20131114222440.GH13330@x2.net.home>
References: <5273FF29.1090403@ubuntu.com>
 <20131104133735.GH23604@x2.net.home>
 <5277AA0C.70309@ubuntu.com>
 <5283C4CC.5010200@ubuntu.com>
 <20131114083912.GA7281@x2.net.home>
 <5284F7AD.2030207@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5284F7AD.2030207@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 14, 2013 at 11:17:49AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/14/2013 3:39 AM, Karel Zak wrote:
> > I have improved libmount (in git tree) and now it updates utab for
> > the helpers.
> 
> But does that mean that the helper has to use libmount?

No, after successful helper execution (helper has to return 0) the
library checks utab and update the file if there is user= mount option
and the mountpoint is not in the file.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
